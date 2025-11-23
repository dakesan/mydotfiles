#!/usr/bin/env python3
"""
LA-Bench JSONL Parser

Parse LA-Bench JSONL files and extract specific entries by ID.
Outputs structured data including instruction, mandatory_objects,
source_protocol_steps, expected_final_states, and references.
"""

import json
import sys
from pathlib import Path
from typing import Optional


def parse_labench_entry(jsonl_path: str, entry_id: str) -> Optional[dict]:
    """
    Parse a JSONL file and extract the entry with the specified ID.

    Supports both compact JSONL (one JSON object per line) and
    pretty-printed JSON (multi-line formatted JSON objects).

    Args:
        jsonl_path: Path to the JSONL file
        entry_id: ID of the entry to extract

    Returns:
        Dictionary containing the parsed entry data, or None if not found
    """
    jsonl_file = Path(jsonl_path)

    if not jsonl_file.exists():
        print(f"Error: File not found: {jsonl_path}", file=sys.stderr)
        return None

    try:
        with open(jsonl_file, 'r', encoding='utf-8') as f:
            content = f.read()

        # Try to parse as compact JSONL first (one JSON per line)
        entries = []
        for line in content.strip().split('\n'):
            line = line.strip()
            if not line:
                continue
            try:
                entry = json.loads(line)
                entries.append(entry)
            except json.JSONDecodeError:
                # Not compact JSONL, will try multi-line parsing
                break

        # If compact JSONL parsing failed, try parsing as multi-line JSON objects
        if not entries:
            # Split by "}\n{" pattern to separate JSON objects
            json_objects = []
            depth = 0
            current_obj = []

            for char in content:
                current_obj.append(char)
                if char == '{':
                    depth += 1
                elif char == '}':
                    depth -= 1
                    if depth == 0:
                        # Complete JSON object found
                        obj_str = ''.join(current_obj)
                        try:
                            entry = json.loads(obj_str)
                            json_objects.append(entry)
                        except json.JSONDecodeError as e:
                            print(f"Warning: Failed to parse JSON object: {e}", file=sys.stderr)
                        current_obj = []

            entries = json_objects

        # Search for the entry with matching ID
        for entry in entries:
            if entry.get('id') == entry_id:
                # Extract the required fields
                input_data = entry.get('input', {})

                result = {
                    'id': entry['id'],
                    'instruction': input_data.get('instruction', ''),
                    'mandatory_objects': input_data.get('mandatory_objects', []),
                    'source_protocol_steps': input_data.get('source_protocol_steps', []),
                    'expected_final_states': input_data.get('expected_final_states', []),
                    'references': input_data.get('references', [])
                }

                return result

        print(f"Error: Entry with ID '{entry_id}' not found in {jsonl_path}", file=sys.stderr)
        return None

    except Exception as e:
        print(f"Error reading file: {e}", file=sys.stderr)
        return None


def main():
    """Main entry point for CLI usage."""
    if len(sys.argv) != 3:
        print("Usage: parse_labench.py <jsonl_path> <entry_id>", file=sys.stderr)
        print("\nExample: parse_labench.py data/private_test_input.jsonl private_test_1", file=sys.stderr)
        sys.exit(1)

    jsonl_path = sys.argv[1]
    entry_id = sys.argv[2]

    result = parse_labench_entry(jsonl_path, entry_id)

    if result:
        # Output as pretty-printed JSON
        print(json.dumps(result, ensure_ascii=False, indent=2))
        sys.exit(0)
    else:
        sys.exit(1)


if __name__ == '__main__':
    main()
