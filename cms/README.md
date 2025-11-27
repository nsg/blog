# CMS - Obsidian to Blog Publisher

Watches `vault/` for Obsidian notes with `publish` tag and converts them to Zola blog posts.

## Setup

```bash
make install   # Install and start systemd service
make cms       # Run manually
make cms-dev   # Run without git commits
```

## Publishing

Add `publish` or `draft` to tags in YAML frontmatter:

```yaml
---
tags: [publish]  # or [draft] for unpublished drafts
---
```

The CMS will:
- Convert to Zola format with TOML frontmatter
- Copy `![[images]]` to `site/static/images/YYYY/`
- Generate tags using Ollama (gemma3:4b on grond:11434)
- Commit and push to git
