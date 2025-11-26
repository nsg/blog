#!/usr/bin/env python3
"""
CMS - Obsidian to Blog Publisher

Watches the vault directory for Obsidian notes with 'publish' tag,
converts them to Zola blog posts, and commits to the repository.
"""

import json
import re
import shutil
import subprocess
import time
import urllib.request
import yaml
from datetime import datetime, timezone
from pathlib import Path

# Configuration
POLL_INTERVAL = 60  # seconds
OLLAMA_HOST = "grond"
OLLAMA_PORT = 11434
OLLAMA_MODEL = "gemma3:4b"


class BlogCMS:
    def __init__(self, vault_dir: Path, blog_dir: Path, dev_mode: bool = False):
        self.vault_dir = vault_dir
        self.blog_dir = blog_dir
        self.posts_dir = blog_dir / "site/content/post"
        self.images_dir = blog_dir / "site/static/images"
        self.dev_mode = dev_mode
        self.file_mtimes: dict[Path, float] = {}
        self._existing_tags: list[str] | None = None

        if not self.vault_dir.exists():
            raise ValueError(f"Vault directory does not exist: {self.vault_dir}")
        if not self.posts_dir.exists():
            raise ValueError(f"Posts directory does not exist: {self.posts_dir}")

    # -------------------------------------------------------------------------
    # Main loop
    # -------------------------------------------------------------------------

    def watch(self):
        """Watch vault directory for changes."""
        print(f"Watching {self.vault_dir} for changes...")
        print("Press Ctrl+C to stop\n")

        try:
            while True:
                self.scan_vault()
                time.sleep(POLL_INTERVAL)
        except KeyboardInterrupt:
            print("\nStopping CMS watcher...")

    def scan_vault(self):
        """Scan vault for publishable notes."""
        for md_file in self.vault_dir.rglob("*.md"):
            # Skip .obsidian and .stfolder directories
            if ".obsidian" in md_file.parts or ".stfolder" in md_file.parts:
                continue

            mtime = md_file.stat().st_mtime

            if md_file in self.file_mtimes and self.file_mtimes[md_file] >= mtime:
                continue

            if self._has_publish_tag(md_file):
                print(f"Found: {md_file.name}")
                try:
                    self._publish(md_file)
                    self.file_mtimes[md_file] = mtime
                    print("  ✓ Published")
                except Exception as e:
                    print(f"  ✗ Failed: {e}")

    # -------------------------------------------------------------------------
    # Publishing
    # -------------------------------------------------------------------------

    def _has_publish_tag(self, md_file: Path) -> bool:
        """Check if note has 'publish' tag in YAML frontmatter."""
        try:
            content = md_file.read_text()
            if not content.startswith("---"):
                return False

            parts = content.split("---", 2)
            if len(parts) < 3:
                return False

            frontmatter = yaml.safe_load(parts[1])
            if not frontmatter or "tags" not in frontmatter:
                return False

            tags = frontmatter["tags"]
            if isinstance(tags, list):
                return "publish" in tags
            return tags == "publish"

        except Exception as e:
            print(f"Error reading {md_file}: {e}")
            return False

    def _publish(self, md_file: Path):
        """Convert Obsidian note to blog post and commit."""
        content = md_file.read_text()
        body = self._extract_body(content)

        year = datetime.now().year
        slug = self._slugify(md_file.stem)
        year_dir = self.posts_dir / str(year)
        self._ensure_year_dir(year_dir, year)

        # Process images before generating tags
        body, image_files = self._process_images(body, md_file, year, slug)

        tags = self._generate_tags(body)
        blog_content = self._build_post(md_file.stem, body, tags)

        output_file = year_dir / f"{slug}.md"
        output_file.write_text(blog_content)

        self._git_commit(output_file, md_file.stem, image_files)

    def _extract_body(self, content: str) -> str:
        """Extract body content, removing YAML frontmatter."""
        if content.startswith("---"):
            parts = content.split("---", 2)
            if len(parts) >= 3:
                return parts[2].strip()
        return content

    def _process_images(self, body: str, md_file: Path, year: int, post_slug: str) -> tuple[str, list[Path]]:
        """Find Obsidian images, copy them, and transform syntax."""
        image_files: list[Path] = []
        year_images_dir = self.images_dir / str(year)
        year_images_dir.mkdir(parents=True, exist_ok=True)

        # Find all ![[image]] references
        pattern = r'!\[\[([^\]]+)\]\]'

        def replace_image(match: re.Match) -> str:
            image_name = match.group(1)

            # Search for the image in vault (check attachments folder and root)
            source_image = None
            for search_path in [
                md_file.parent / "attachments" / image_name,
                md_file.parent / image_name,
                self.vault_dir / "attachments" / image_name,
            ]:
                if search_path.exists():
                    source_image = search_path
                    break

            if not source_image:
                print(f"  [warn] Image not found: {image_name}")
                return match.group(0)  # Keep original if not found

            # Build unique image name: postslug-originalname.ext
            stem = source_image.stem.lower()
            stem = re.sub(r"[^\w\s-]", "", stem)
            stem = re.sub(r"[\s_]+", "-", stem).strip("-")
            dest_name = f"{post_slug}-{stem}{source_image.suffix.lower()}"

            dest_image = year_images_dir / dest_name
            shutil.copy2(source_image, dest_image)
            image_files.append(dest_image)
            print(f"  Copied image: {dest_name}")

            return f"![](/images/{year}/{dest_name})"

        body = re.sub(pattern, replace_image, body)
        return body, image_files

    def _build_post(self, name: str, body: str, tags: list[str]) -> str:
        """Build Zola post with TOML frontmatter."""
        # Transform [[wiki links]] to inline code
        body = re.sub(r"\[\[([^\]]+)\]\]", r"`\1`", body)

        title = name.replace("-", " ").replace("_", " ").title()
        date = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%S+00:00")
        tags_str = ", ".join(f'"{t}"' for t in tags)

        frontmatter = (
            f'+++\ndate = "{date}"\ntitle = "{title}"\n'
            f'[taxonomies]\ntags = [{tags_str}]\n+++\n\n'
        )
        return frontmatter + body

    # -------------------------------------------------------------------------
    # Tag generation
    # -------------------------------------------------------------------------

    def _get_existing_tags(self) -> list[str]:
        """Get most common tags from last 10 years of blog posts."""
        if self._existing_tags is not None:
            return self._existing_tags

        current_year = datetime.now().year
        tag_counts: dict[str, int] = {}

        for year in range(current_year - 10, current_year + 1):
            year_dir = self.posts_dir / str(year)
            if not year_dir.exists():
                continue

            for md_file in year_dir.glob("*.md"):
                try:
                    content = md_file.read_text()
                    if content.startswith("+++"):
                        parts = content.split("+++", 2)
                        if len(parts) >= 3:
                            match = re.search(r'tags\s*=\s*\[(.*?)\]', parts[1])
                            if match:
                                for tag in re.findall(r'"([^"]+)"', match.group(1)):
                                    tag = tag.lower().strip()
                                    tag_counts[tag] = tag_counts.get(tag, 0) + 1
                except Exception:
                    continue

        sorted_tags = sorted(tag_counts.items(), key=lambda x: x[1], reverse=True)
        self._existing_tags = [tag for tag, _ in sorted_tags[:30]]
        return self._existing_tags

    def _generate_tags(self, content: str) -> list[str]:
        """Use Ollama to generate relevant tags for the content."""
        print("  Generating tags with AI...")

        existing = self._get_existing_tags()
        prompt = f"""Based on this blog post content, suggest 2-5 relevant tags.
Choose from these existing tags when possible: {", ".join(existing)}
You may suggest new tags if none of the existing ones fit well.

Return ONLY a JSON array of lowercase tag strings, nothing else.
Example: ["linux", "personal", "homelab"]

Content:
{content[:2000]}"""

        try:
            data = json.dumps({
                "model": OLLAMA_MODEL,
                "prompt": prompt,
                "stream": False
            }).encode()

            req = urllib.request.Request(
                f"http://{OLLAMA_HOST}:{OLLAMA_PORT}/api/generate",
                data=data,
                headers={"Content-Type": "application/json"}
            )

            with urllib.request.urlopen(req, timeout=30) as resp:
                result = json.loads(resp.read().decode())
                response_text = result.get("response", "[]")

                match = re.search(r'\[.*?\]', response_text, re.DOTALL)
                if match:
                    tags = json.loads(match.group())
                    tags = [t.lower().strip() for t in tags if isinstance(t, str)]
                    print(f"  Tags: {tags}")
                    return tags

        except Exception as e:
            print(f"  [warn] Tag generation failed: {e}")

        return []

    # -------------------------------------------------------------------------
    # Helpers
    # -------------------------------------------------------------------------

    def _ensure_year_dir(self, year_dir: Path, year: int):
        """Create year directory with _index.md if needed."""
        year_dir.mkdir(exist_ok=True)
        index_file = year_dir / "_index.md"
        if not index_file.exists():
            index_file.write_text(f'+++\ntitle = "{year}"\nsort_by = "date"\n+++\n')

    def _slugify(self, title: str) -> str:
        """Create URL-friendly slug from title."""
        slug = title.lower()
        slug = re.sub(r"[^\w\s-]", "", slug)
        slug = re.sub(r"[\s_]+", "-", slug)
        return slug.strip("-")

    def _git_commit(self, file_path: Path, title: str, image_files: list[Path] | None = None):
        """Commit new blog post and images to git, then push."""
        rel_path = file_path.relative_to(self.blog_dir)
        files_to_commit = [rel_path]

        if image_files:
            for img in image_files:
                files_to_commit.append(img.relative_to(self.blog_dir))

        if self.dev_mode:
            print(f"  [dev] Would commit: {', '.join(str(f) for f in files_to_commit)}")
            return

        for f in files_to_commit:
            subprocess.run(["git", "add", str(f)], cwd=self.blog_dir, check=True)

        subprocess.run(
            ["git", "commit", "-m", f"feat: add blog post '{title}'"],
            cwd=self.blog_dir,
            check=True,
        )
        subprocess.run(["git", "push"], cwd=self.blog_dir, check=True)
        print(f"  Committed and pushed: {rel_path}")


# -----------------------------------------------------------------------------
# CLI
# -----------------------------------------------------------------------------

def main():
    import argparse

    parser = argparse.ArgumentParser(description="Obsidian to Blog Publisher")
    parser.add_argument("--dev", action="store_true", help="Dev mode: skip git commit")
    args = parser.parse_args()

    script_dir = Path(__file__).parent
    vault_dir = script_dir / "vault"
    blog_dir = script_dir.parent

    print("=" * 50)
    print("Blog CMS - Obsidian to Blog Publisher")
    if args.dev:
        print("[DEV MODE - no git commits]")
    print("=" * 50)
    print(f"Vault: {vault_dir}")
    print(f"Blog:  {blog_dir}")
    print()

    cms = BlogCMS(vault_dir, blog_dir, dev_mode=args.dev)
    cms.watch()


if __name__ == "__main__":
    main()
