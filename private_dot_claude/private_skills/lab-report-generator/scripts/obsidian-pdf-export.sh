#!/bin/bash
# Obsidian PDF Export using Advanced URI plugin
# Usage: ./obsidian-pdf-export.sh <relative-file-path>

set -e

VAULT="Hiro"
FILE_PATH="$1"

if [ -z "$FILE_PATH" ]; then
    echo "Usage: $0 <file-path>"
    echo "Example: $0 'random/20251024_example.md'"
    exit 1
fi

# URL encode the file path
ENCODED_PATH=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$FILE_PATH'))")

# Construct Obsidian URI
URI="obsidian://advanced-uri?vault=${VAULT}&filepath=${ENCODED_PATH}&commandid=workspace:export-pdf"

echo "Opening Obsidian to export PDF..."
echo "File: $FILE_PATH"
echo "URI: $URI"
echo ""

# Open URI
open "$URI"

echo "✓ PDF export command sent to Obsidian"
echo "Please check Obsidian for the export dialog"
