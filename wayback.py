#!/usr/bin/env python3

import argparse
import requests
import re
import sys
import time
from pathlib import Path

def extract_date_from_file(file_path: Path) -> str:
    """Extract YYYYMMDD date from blog post frontmatter."""
    with open(file_path, 'r', encoding='utf-8') as f:
        for line in f:
            if line.startswith('date = '):
                # Extract date from line like: date = "2020-01-01T12:00:00+00:00"
                match = re.search(r'"(\d{4}-\d{2}-\d{2})', line)
                if match:
                    return match.group(1).replace('-', '')

    raise ValueError(f"Could not extract date from {file_path}")

def extract_urls_from_file(file_path: Path) -> list:
    """Extract external URLs from markdown file."""
    urls = []
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
        # Find HTTP(S) URLs, excluding wayback machine
        found_urls = re.findall(r'https?://[^\s)"]+', content)
        for url in found_urls:
            if 'wayback.archive.org' not in url:
                urls.append(url)
    return urls

def is_url_dead(url: str, timeout: int = 10) -> bool:
    """Check if URL returns non-2xx status code and print status."""
    try:
        response = requests.head(url, timeout=timeout, allow_redirects=True)
        if 200 <= response.status_code < 300:
            return False
    except requests.RequestException:
        pass
    return True

def wait_for_url_input() -> str:
    """Wait for URL input from url.in file."""
    url_file = Path("url.in")
    
    # Create the file if it doesn't exist
    if not url_file.exists():
        url_file.touch()
    
    while True:
        try:
            with open(url_file, 'r', encoding='utf-8') as f:
                content = f.read().strip()
                if content:
                    # Clear the file after reading
                    with open(url_file, 'w', encoding='utf-8') as f:
                        f.write("")
                    # Return None if user wants to skip
                    if content == "-":
                        return None
                    return content
        except IOError:
            pass
        
        time.sleep(0.5)  # Check every 500ms

def process_file(file_path: Path, dry_run: bool = False, timeout: int = 10):
    """Main processing function."""
    
    # Extract date and URLs from the file
    target_date = extract_date_from_file(file_path)
    urls = extract_urls_from_file(file_path)
    
    for url in urls:
        if is_url_dead(url, timeout):
            print(f"\nFile: {file_path}")
            print(f"Dead URL found: {url}")
            print(f"Select a url from https://web.archive.org/web/{target_date}*/{url}")
            print("Write replacement URL to url.in file (or '-' to skip)")

            replacement_url = wait_for_url_input()
            
            if replacement_url is None:
                print("Skipped by user request")
                continue

            if dry_run:
                print(f"Would replace {url} with {replacement_url}")
                continue

            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            updated_content = content.replace(url, replacement_url)
            
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(updated_content)
            
            print(f"Replaced {url} with {replacement_url}")

def main():
    parser = argparse.ArgumentParser(description="Update dead external links with Wayback Machine links")
    parser.add_argument("--dry-run", action="store_true", help="Show what would be changed without making modifications")
    parser.add_argument("file_path", help="Markdown file to process")
    
    args = parser.parse_args()
    
    process_file(Path(args.file_path), dry_run=args.dry_run)

if __name__ == "__main__":
    main()
