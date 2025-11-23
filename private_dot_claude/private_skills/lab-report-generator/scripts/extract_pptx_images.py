#!/usr/bin/env python3
"""
Extract images from PowerPoint files by converting to PDF then extracting pages as PNG.

Usage:
    python3 extract_pptx_images.py <pptx_file> <output_dir> [page_numbers]

Arguments:
    pptx_file: Path to PowerPoint file
    output_dir: Directory to save extracted images
    page_numbers: Comma-separated page numbers (1-indexed), e.g., "1,3-5,7"
                 If not provided, extracts all pages

Example:
    python3 extract_pptx_images.py presentation.pptx ./images "2,5-8"

Dependencies:
    - LibreOffice (for PPTX to PDF conversion)
    - PyMuPDF (pip install PyMuPDF)
"""

import sys
import os
import subprocess
import tempfile
from pathlib import Path

try:
    import fitz  # PyMuPDF
except ImportError:
    print("Error: PyMuPDF is not installed. Install with: pip install PyMuPDF")
    sys.exit(1)


def parse_page_numbers(page_str, max_pages):
    """
    Parse page number string into list of page indices (0-indexed).

    Examples:
        "1,3,5" -> [0, 2, 4]
        "1-3,5" -> [0, 1, 2, 4]
        "all" or None -> [0, 1, 2, ..., max_pages-1]
    """
    if not page_str or page_str.lower() == "all":
        return list(range(max_pages))

    pages = set()
    for part in page_str.split(','):
        part = part.strip()
        if '-' in part:
            start, end = map(int, part.split('-'))
            pages.update(range(start - 1, end))  # Convert to 0-indexed
        else:
            pages.add(int(part) - 1)  # Convert to 0-indexed

    return sorted([p for p in pages if 0 <= p < max_pages])


def convert_pptx_to_pdf(pptx_path, output_pdf_path):
    """Convert PowerPoint to PDF using LibreOffice."""
    print(f"Converting {pptx_path} to PDF...")

    # Create temp directory for conversion
    temp_dir = tempfile.mkdtemp()

    try:
        # Run LibreOffice conversion
        result = subprocess.run(
            [
                'soffice',
                '--headless',
                '--convert-to', 'pdf',
                '--outdir', temp_dir,
                pptx_path
            ],
            capture_output=True,
            text=True,
            timeout=60
        )

        if result.returncode != 0:
            print(f"Error: LibreOffice conversion failed: {result.stderr}")
            return None

        # Find generated PDF
        pdf_files = list(Path(temp_dir).glob('*.pdf'))
        if not pdf_files:
            print("Error: No PDF generated")
            return None

        # Move PDF to output location
        temp_pdf = pdf_files[0]
        temp_pdf.rename(output_pdf_path)

        print(f"✓ PDF created: {output_pdf_path}")
        return output_pdf_path

    except subprocess.TimeoutExpired:
        print("Error: LibreOffice conversion timed out")
        return None
    except Exception as e:
        print(f"Error during conversion: {e}")
        return None
    finally:
        # Cleanup temp directory
        import shutil
        shutil.rmtree(temp_dir, ignore_errors=True)


def extract_pdf_pages_as_images(pdf_path, output_dir, page_numbers=None, dpi=150):
    """Extract specific pages from PDF as PNG images."""
    print(f"Extracting pages from {pdf_path}...")

    # Open PDF
    doc = fitz.open(pdf_path)
    total_pages = len(doc)

    # Parse page numbers
    pages_to_extract = parse_page_numbers(page_numbers, total_pages)

    if not pages_to_extract:
        print(f"Warning: No valid pages to extract (total pages: {total_pages})")
        return []

    # Create output directory
    os.makedirs(output_dir, exist_ok=True)

    # Extract pages
    extracted_files = []
    for page_idx in pages_to_extract:
        page = doc.load_page(page_idx)
        pix = page.get_pixmap(dpi=dpi)

        # Generate filename (1-indexed page number)
        output_file = os.path.join(output_dir, f"page_{page_idx + 1}.png")
        pix.save(output_file)

        extracted_files.append(output_file)
        print(f"✓ Extracted page {page_idx + 1} -> {output_file}")

    doc.close()
    return extracted_files


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        sys.exit(1)

    pptx_file = sys.argv[1]
    output_dir = sys.argv[2]
    page_numbers = sys.argv[3] if len(sys.argv) > 3 else None

    # Validate input
    if not os.path.exists(pptx_file):
        print(f"Error: File not found: {pptx_file}")
        sys.exit(1)

    # Convert PPTX to PDF
    temp_pdf = tempfile.mktemp(suffix='.pdf')
    pdf_path = convert_pptx_to_pdf(pptx_file, temp_pdf)

    if not pdf_path:
        print("Failed to convert PowerPoint to PDF")
        sys.exit(1)

    # Extract pages as images
    try:
        extracted = extract_pdf_pages_as_images(pdf_path, output_dir, page_numbers)
        print(f"\n✅ Successfully extracted {len(extracted)} pages to {output_dir}")
    finally:
        # Cleanup temp PDF
        if os.path.exists(temp_pdf):
            os.remove(temp_pdf)


if __name__ == "__main__":
    main()
