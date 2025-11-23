#!/usr/bin/env python3
"""
Obsidian Filename Normalizer

This script normalizes filenames according to the Hiro repository conventions:
- Converts spaces (both ASCII and full-width) to hyphens
- Adds YYYYMMDD date prefix if not present
- Ensures .md extension
- Reads date from frontmatter when renaming files

Usage:
    python normalize_filename.py <title> [--date YYYYMMDD]
    python normalize_filename.py --rename <current_path> [--date YYYYMMDD]
"""

import argparse
import re
import sys
from datetime import datetime
from pathlib import Path


def extract_date_from_frontmatter(file_path: str) -> str:
    """
    Extract date from YAML frontmatter in a markdown file.

    Args:
        file_path: Path to the markdown file

    Returns:
        Date string in YYYYMMDD format, or None if not found
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Match YAML frontmatter
        frontmatter_match = re.match(r'^---\n(.*?)\n---', content, re.DOTALL)
        if not frontmatter_match:
            return None

        frontmatter = frontmatter_match.group(1)

        # Look for date field (supports various formats)
        # date: YYYY-MM-DD
        # date: YYYY/MM/DD
        # date: YYYYMMDD
        date_match = re.search(r'^date:\s*["\']?(\d{4})[-/]?(\d{2})[-/]?(\d{2})["\']?',
                              frontmatter, re.MULTILINE)

        if date_match:
            year, month, day = date_match.groups()
            return f"{year}{month}{day}"

        return None

    except Exception as e:
        print(f"Warning: Could not read frontmatter from {file_path}: {e}", file=sys.stderr)
        return None


def normalize_title(title: str) -> str:
    """
    Normalize a title by replacing all spaces with hyphens.

    Handles both ASCII spaces and full-width spaces (U+3000).
    Special case: If title starts with YYYYMMDD followed by space,
    replace that first space with underscore.

    Args:
        title: The title to normalize

    Returns:
        Normalized title with spaces replaced by hyphens/underscore
    """
    # Special handling for YYYYMMDD date prefix followed by space
    # Convert "20231124 title" to "20231124_title"
    if re.match(r'^\d{8}[\s\u3000]', title):
        # Replace the first space after date with underscore
        normalized = re.sub(r'^(\d{8})[\s\u3000]', r'\1_', title)
        # Replace remaining spaces with hyphens
        normalized = re.sub(r'[\s\u3000]+', '-', normalized)
    else:
        # Replace all spaces with hyphens
        normalized = re.sub(r'[\s\u3000]+', '-', title)

    return normalized


def add_date_prefix(title: str, date_str: str = None) -> str:
    """
    Add YYYYMMDD date prefix to title if not already present.

    Args:
        title: The title to add prefix to
        date_str: Optional date string in YYYYMMDD format (defaults to today)

    Returns:
        Title with date prefix
    """
    # Check if title already starts with date pattern (with various separators)
    # Matches: 20231124_, 20231124-, 20231124 (space), etc.
    if re.match(r'^\d{8}[_\-\s\u3000]', title):
        return title

    # Use provided date or today's date
    if date_str is None:
        date_str = datetime.now().strftime('%Y%m%d')

    # Validate date format
    if not re.match(r'^\d{8}$', date_str):
        raise ValueError(f"Invalid date format: {date_str}. Expected YYYYMMDD")

    return f"{date_str}_{title}"


def ensure_md_extension(filename: str) -> str:
    """
    Ensure filename has .md extension.

    Args:
        filename: The filename to check

    Returns:
        Filename with .md extension
    """
    if not filename.endswith('.md'):
        return f"{filename}.md"
    return filename


def generate_filename(title: str, date_str: str = None) -> str:
    """
    Generate a normalized filename from a title.

    Args:
        title: The title to convert to filename
        date_str: Optional date string in YYYYMMDD format (if None, no date prefix added)

    Returns:
        Normalized filename with optional date prefix and .md extension
    """
    # Normalize the title
    normalized = normalize_title(title)

    # Add date prefix only if date_str is provided
    if date_str is not None:
        with_date = add_date_prefix(normalized, date_str)
    else:
        with_date = normalized

    # Ensure .md extension
    final = ensure_md_extension(with_date)

    return final


def rename_file(current_path: str, date_str: str = None, dry_run: bool = False) -> tuple[str, str]:
    """
    Rename a file according to naming conventions.

    If date_str is not provided, attempts to extract date from frontmatter.

    Args:
        current_path: Path to the current file
        date_str: Optional date string in YYYYMMDD format (if not provided, reads from frontmatter)
        dry_run: If True, don't actually rename, just return what would happen

    Returns:
        Tuple of (old_path, new_path)
    """
    path = Path(current_path)

    if not path.exists():
        raise FileNotFoundError(f"File not found: {current_path}")

    # If date not provided, try to extract from frontmatter
    if date_str is None:
        date_str = extract_date_from_frontmatter(current_path)
        if date_str:
            print(f"Found date in frontmatter: {date_str}", file=sys.stderr)
        else:
            print(f"Warning: No date found in frontmatter and --date not specified", file=sys.stderr)
            print(f"Warning: File will not have a date prefix", file=sys.stderr)

    # Get the filename without extension
    current_name = path.stem

    # Generate new filename
    new_filename = generate_filename(current_name, date_str)

    # Create new path
    new_path = path.parent / new_filename

    if not dry_run:
        path.rename(new_path)

    return str(path), str(new_path)


def main():
    parser = argparse.ArgumentParser(
        description='Normalize Obsidian filenames according to Hiro repository conventions',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Generate filename from title
  python normalize_filename.py "FAT3の変異解析"
  # Output: 20250125_FAT3の変異解析.md

  # Generate with specific date
  python normalize_filename.py "weekly meeting" --date 20231124
  # Output: 20231124_weekly-meeting.md

  # Rename existing file
  python normalize_filename.py --rename "FAT3の変異解析.md" --date 20231124
  # Renames to: 20231124_FAT3の変異解析.md

  # Dry run (preview only)
  python normalize_filename.py --rename "FAT3の変異解析.md" --dry-run
        """
    )

    parser.add_argument(
        'title',
        nargs='?',
        help='Title to convert to filename (or path if using --rename)'
    )

    parser.add_argument(
        '--date',
        help='Date prefix in YYYYMMDD format (defaults to today)'
    )

    parser.add_argument(
        '--rename',
        metavar='PATH',
        help='Rename an existing file instead of generating a filename'
    )

    parser.add_argument(
        '--dry-run',
        action='store_true',
        help='Preview changes without actually renaming (only with --rename)'
    )

    args = parser.parse_args()

    # Determine which mode to use
    if args.rename:
        # Rename mode
        try:
            old_path, new_path = rename_file(args.rename, args.date, args.dry_run)
            if args.dry_run:
                print(f"Would rename:")
                print(f"  From: {old_path}")
                print(f"  To:   {new_path}")
            else:
                print(f"Renamed:")
                print(f"  From: {old_path}")
                print(f"  To:   {new_path}")
        except Exception as e:
            print(f"Error: {e}", file=sys.stderr)
            sys.exit(1)

    elif args.title:
        # Generate mode
        try:
            filename = generate_filename(args.title, args.date)
            print(filename)
        except Exception as e:
            print(f"Error: {e}", file=sys.stderr)
            sys.exit(1)

    else:
        parser.print_help()
        sys.exit(1)


if __name__ == '__main__':
    main()
