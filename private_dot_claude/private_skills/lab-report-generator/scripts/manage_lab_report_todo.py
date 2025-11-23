#!/usr/bin/env python3
"""
Manage TODO list for lab report generation workflow.

Usage:
    # Initialize TODO list
    python3 manage_lab_report_todo.py init <report_dir>

    # Show current status
    python3 manage_lab_report_todo.py status <report_dir>

    # Update task status
    python3 manage_lab_report_todo.py update <report_dir> <task_number> <status>

    # Add custom task
    python3 manage_lab_report_todo.py add <report_dir> <task_description>

Status values: pending, in_progress, completed, skipped

Example:
    python3 manage_lab_report_todo.py init _LabReports/QP-0001-直接qPCRシステム確立
    python3 manage_lab_report_todo.py status _LabReports/QP-0001-直接qPCRシステム確立
    python3 manage_lab_report_todo.py update _LabReports/QP-0001-直接qPCRシステム確立 1 completed
"""

import sys
import os
import json
from pathlib import Path
from datetime import datetime


TODO_FILENAME = "LAB_REPORT_TODO.md"

DEFAULT_WORKFLOW = [
    {
        "id": 1,
        "task": "ファイルアップロードと整理",
        "description": "PowerPoint、Excel、データファイルを_LabReportsにコピー",
        "status": "pending"
    },
    {
        "id": 2,
        "task": "MarkdownレポートのObsidian編集",
        "description": "テンプレートに基づいてラボノートをリファイン",
        "status": "pending"
    },
    {
        "id": 3,
        "task": "PowerPoint画像抽出",
        "description": "PPTXファイルから関連ページを画像として抽出",
        "status": "pending"
    },
    {
        "id": 4,
        "task": "Excelデータ解析",
        "description": "Excelファイルを解析してサマリーテーブル作成",
        "status": "pending"
    },
    {
        "id": 5,
        "task": "Markdown統合",
        "description": "画像とサマリーテーブルをMarkdownに追加",
        "status": "pending"
    },
    {
        "id": 6,
        "task": "レビューと改善",
        "description": "ユーザーレビューに基づいて編集を繰り返す",
        "status": "pending"
    },
    {
        "id": 7,
        "task": "最終成果物生成",
        "description": "PDF変換、ファイル一覧作成",
        "status": "pending"
    }
]


def get_todo_path(report_dir):
    """Get path to TODO file."""
    return os.path.join(report_dir, TODO_FILENAME)


def read_todo(todo_path):
    """Read TODO list from markdown file."""
    if not os.path.exists(todo_path):
        return None

    tasks = []
    with open(todo_path, 'r') as f:
        lines = f.readlines()

    for line in lines:
        if line.startswith('- ['):
            # Parse markdown checkbox format: - [ ] Task description
            status_part = line[3:4]
            if status_part == ' ':
                status = 'pending'
            elif status_part == 'x':
                status = 'completed'
            elif status_part == '~':
                status = 'skipped'
            elif status_part == '>':
                status = 'in_progress'
            else:
                continue

            # Extract task info
            rest = line[6:].strip()
            if ':' in rest:
                task_id_str, description = rest.split(':', 1)
                try:
                    task_id = int(task_id_str.strip())
                except ValueError:
                    continue

                tasks.append({
                    'id': task_id,
                    'task': description.split('|')[0].strip(),
                    'description': description.split('|')[1].strip() if '|' in description else '',
                    'status': status
                })

    return tasks


def write_todo(todo_path, tasks, report_dir):
    """Write TODO list to markdown file."""
    with open(todo_path, 'w') as f:
        f.write(f"# Lab Report Generation TODO\n\n")
        f.write(f"**Report Directory:** `{report_dir}`\n")
        f.write(f"**Last Updated:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
        f.write("## Progress\n\n")

        # Count status
        completed = sum(1 for t in tasks if t['status'] == 'completed')
        total = len(tasks)
        progress = int((completed / total) * 100) if total > 0 else 0

        f.write(f"Progress: {completed}/{total} tasks completed ({progress}%)\n\n")

        # Status legend
        f.write("**Status:**\n")
        f.write("- `[ ]` Pending\n")
        f.write("- `[>]` In Progress\n")
        f.write("- `[x]` Completed\n")
        f.write("- `[~]` Skipped\n\n")

        # Tasks
        f.write("## Tasks\n\n")
        for task in tasks:
            checkbox = {
                'pending': '[ ]',
                'in_progress': '[>]',
                'completed': '[x]',
                'skipped': '[~]'
            }.get(task['status'], '[ ]')

            f.write(f"- {checkbox} {task['id']}: {task['task']} | {task['description']}\n")

        f.write("\n---\n\n")
        f.write("*This TODO list is managed by lab-report-generator skill*\n")


def init_todo(report_dir):
    """Initialize TODO list."""
    todo_path = get_todo_path(report_dir)

    if os.path.exists(todo_path):
        print(f"Warning: TODO file already exists: {todo_path}")
        response = input("Overwrite? (y/N): ")
        if response.lower() != 'y':
            print("Cancelled.")
            return

    # Create directory if needed
    os.makedirs(report_dir, exist_ok=True)

    # Write default workflow
    write_todo(todo_path, DEFAULT_WORKFLOW, report_dir)
    print(f"✅ TODO list initialized: {todo_path}")


def show_status(report_dir):
    """Show current TODO status."""
    todo_path = get_todo_path(report_dir)

    if not os.path.exists(todo_path):
        print(f"Error: TODO file not found: {todo_path}")
        print("Run 'init' command first.")
        sys.exit(1)

    tasks = read_todo(todo_path)

    print(f"\n=== Lab Report TODO Status ===")
    print(f"Report: {report_dir}\n")

    for task in tasks:
        icon = {
            'pending': '⏸️',
            'in_progress': '🔄',
            'completed': '✅',
            'skipped': '⏭️'
        }.get(task['status'], '❓')

        print(f"{icon} [{task['id']}] {task['task']}")
        print(f"    {task['description']}")
        print(f"    Status: {task['status']}\n")

    completed = sum(1 for t in tasks if t['status'] == 'completed')
    total = len(tasks)
    print(f"Progress: {completed}/{total} tasks completed")


def update_task(report_dir, task_number, new_status):
    """Update task status."""
    todo_path = get_todo_path(report_dir)

    if not os.path.exists(todo_path):
        print(f"Error: TODO file not found: {todo_path}")
        sys.exit(1)

    tasks = read_todo(todo_path)

    # Find and update task
    found = False
    for task in tasks:
        if task['id'] == task_number:
            old_status = task['status']
            task['status'] = new_status
            found = True
            print(f"✓ Task {task_number} updated: {old_status} → {new_status}")
            break

    if not found:
        print(f"Error: Task {task_number} not found")
        sys.exit(1)

    # Write updated TODO
    write_todo(todo_path, tasks, report_dir)


def add_task(report_dir, description):
    """Add custom task."""
    todo_path = get_todo_path(report_dir)

    if not os.path.exists(todo_path):
        print(f"Error: TODO file not found: {todo_path}")
        print("Run 'init' command first.")
        sys.exit(1)

    tasks = read_todo(todo_path)

    # Find next ID
    next_id = max(t['id'] for t in tasks) + 1 if tasks else 1

    # Add new task
    new_task = {
        'id': next_id,
        'task': description,
        'description': 'Custom task',
        'status': 'pending'
    }
    tasks.append(new_task)

    write_todo(todo_path, tasks, report_dir)
    print(f"✅ Task {next_id} added: {description}")


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        sys.exit(1)

    command = sys.argv[1]
    report_dir = sys.argv[2]

    if command == 'init':
        init_todo(report_dir)
    elif command == 'status':
        show_status(report_dir)
    elif command == 'update':
        if len(sys.argv) < 5:
            print("Error: update requires task_number and status")
            sys.exit(1)
        task_number = int(sys.argv[3])
        new_status = sys.argv[4]
        update_task(report_dir, task_number, new_status)
    elif command == 'add':
        if len(sys.argv) < 4:
            print("Error: add requires task description")
            sys.exit(1)
        description = ' '.join(sys.argv[3:])
        add_task(report_dir, description)
    else:
        print(f"Error: Unknown command: {command}")
        print("Valid commands: init, status, update, add")
        sys.exit(1)


if __name__ == "__main__":
    main()
