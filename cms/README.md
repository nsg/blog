# CMS - Obsidian to Blog Publisher

Watches an Obsidian vault directory and automatically publishes notes tagged with `#publish` to the blog.

## Directory Structure

```
cms/
├── cms.py              # Main Python application
├── requirements.txt    # Python dependencies
├── vault/             # Obsidian vault (synchronized from phone)
└── README.md          # This file
```

## Setup

Install Python dependencies:

```bash
make cms-setup
```

## Usage

Start the CMS watcher:

```bash
make cms-watch
```

The watcher will:
1. Monitor `cms/vault/` for Markdown files
2. Detect files with `#publish` tag
3. Convert Obsidian format to Zola blog format
4. Create post in `site/content/post/YYYY/`
5. Commit changes to git

## Publishing from Obsidian

To publish a note, add `#publish` anywhere in the note or add to frontmatter:

```markdown
---
tags: [publish]
---

# My Blog Post

Content here...
```

## Transformations

- `[[wiki links]]` → backtick-quoted text
- Adds Zola TOML frontmatter if missing
- Creates slug from filename
- Places in current year directory
