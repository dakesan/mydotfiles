# Data Analysis and Markdown Refinement Workflow

This document provides detailed guidance for analyzing PowerPoint/Excel data and integrating results into lab report markdown files.

## Overview

The data analysis workflow extends the basic lab report generation by:
1. Extracting visual data from PowerPoint presentations as images
2. Analyzing Excel data to create summary tables
3. Integrating images and tables into refined markdown reports
4. Iterating with user feedback until satisfactory

## Step-by-Step Workflow

### Step 1: File Upload and Organization

Ask user to provide data files:
- PowerPoint files (`.pptx`) containing figures, plots, results
- Excel files (`.xlsx`) containing raw data, measurements
- Other data files as needed

Copy files to appropriate _LabReports subdirectories:
- `2_データ/` for raw data files
- `3_結果/` for result files (PowerPoint presentations)
- `4_資料/` for reference materials

### Step 2: Markdown Refinement with Obsidian Template

Before data analysis, ensure the lab notebook markdown follows proper template structure.

**Required template elements:**
1. YAML frontmatter with metadata
2. Four summary callouts:
   - `[!Todo] Background`
   - `[!Works] Purpose`
   - `[!Done] Results Summary`
   - `[!Important] Key Points`
3. Experimental sections with standard headings

**Refinement process:**
1. Read the lab notebook markdown
2. Identify missing or incomplete template sections
3. Ask user for missing information
4. Update markdown to match template structure
5. Ensure all experiments have proper documentation

### Step 3: PowerPoint Image Extraction

Extract relevant figures/plots from PowerPoint files as PNG images.

**Process:**
1. Identify which PowerPoint files and pages contain relevant figures
2. Create `5_images/` directory in _LabReports project folder
3. Use `extract_pptx_images.py` script:
   ```bash
   python3 scripts/extract_pptx_images.py <pptx_file> <output_dir> <page_numbers>
   ```
4. Verify extracted images

**Example:**
```bash
# Extract pages 2, 5-8 from presentation
python3 ~/.claude/skills/lab-report-generator/scripts/extract_pptx_images.py \
    "_LabReports/QP-0001/3_結果/results.pptx" \
    "_LabReports/QP-0001/5_images" \
    "2,5-8"
```

**Naming convention for extracted images:**
- Use descriptive names: `exp1_melting_curve.png`, `preliminary_results.png`
- Include experiment number or identifier
- Keep names concise but clear

### Step 4: Excel Data Analysis

Analyze Excel files to create markdown summary tables.

**Process:**
1. Read Excel file and identify relevant sheets
2. Determine analysis type:
   - qPCR data: Use qPCR-specific analysis
   - Generic data: Use generic summary
3. Use `analyze_excel_data.py` script:
   ```bash
   python3 scripts/analyze_excel_data.py <excel_file> <sheet_name> --analysis-type <type> --output <output_file>
   ```
4. Review generated markdown tables

**Example:**
```bash
# Analyze qPCR results
python3 ~/.claude/skills/lab-report-generator/scripts/analyze_excel_data.py \
    "_LabReports/QP-0001/2_データ/qpcr_results.xlsx" \
    "Results" \
    --analysis-type qpcr \
    --output /tmp/exp2_summary.md
```

**Alternative: Direct pandas analysis**
For custom analysis beyond script capabilities, use pandas directly:
```python
import pandas as pd

# Read data
df = pd.read_excel('data.xlsx', sheet_name='Results', skiprows=44)

# Custom analysis logic
# ...

# Generate markdown table
summary_df.to_markdown(index=False)
```

### Step 5: Markdown Integration

Integrate extracted images and summary tables into the lab notebook markdown.

**Image integration:**
1. Add images after data source citations
2. Use relative paths from markdown location
3. Include descriptive figure captions
4. Format:
   ```markdown
   ![Description](../_LabReports/XX-NNNN-title/5_images/image.png)

   *Figure X: Detailed caption explaining the figure content and significance.*
   ```

**Table integration:**
1. Add summary tables after data source citations
2. Include table captions explaining the data
3. Format:
   ```markdown
   | Column1 | Column2 | Column3 |
   |:--------|:--------|:--------|
   | Data1   | Data2   | Data3   |

   *Table X: Caption explaining the table content, metrics, and interpretation.*
   ```

**Integration guidelines:**
- Place images and tables in Results sections of each experiment
- Maintain logical flow: data source → visual evidence → summary table → interpretation
- Keep original text structure but enhance with visual data
- Ensure figure/table numbers are sequential

### Step 6: Review and Iteration

Iterate with user feedback until report is satisfactory.

**Review process:**
1. Show user the updated markdown sections
2. Ask for feedback on:
   - Image selection and placement
   - Table content and formatting
   - Caption clarity
   - Overall flow
3. Make requested modifications
4. Repeat until user approves

**Common iterations:**
- Adjusting image resolution or cropping
- Modifying table columns or metrics
- Refining captions for clarity
- Reorganizing content flow

### Step 7: Final Deliverables

Once content is finalized, generate final deliverables:

1. **PDF Export** - Export refined markdown as PDF via Obsidian
2. **File Inventory** - Update ファイル一覧.md with new images
3. **Summary Document** - Ensure Summary.md reflects final content

## Best Practices

### Image Extraction
- Use 150 DPI for good quality without excessive file size
- Extract only relevant pages, not entire presentations
- Organize images in logical groups (by experiment)
- Use consistent naming conventions

### Data Analysis
- Validate data structure before analysis
- Handle missing data appropriately
- Include relevant metrics (mean, SD, counts)
- Use clear status indicators (✅ ❌ ⚠️)

### Markdown Formatting
- Use proper markdown syntax
- Keep tables readable (not too wide)
- Use relative paths for images
- Include alt text for accessibility

### Quality Checks
- Verify all images load correctly
- Ensure tables render properly
- Check figure/table numbering
- Validate data source citations

## Troubleshooting

### Images not displaying
- Check relative path from markdown file location
- Ensure images were actually extracted
- Verify file permissions

### Table formatting issues
- Ensure proper markdown table syntax
- Check for special characters that need escaping
- Validate column alignment specifications

### Data analysis errors
- Verify Excel sheet structure matches expectations
- Check for missing columns or renamed fields
- Handle 'Undetermined' or 'N/A' values appropriately

## Dependencies

Required Python packages:
- PyMuPDF (for PDF/image handling): `pip install PyMuPDF`
- pandas (for data analysis): `pip install pandas openpyxl`
- tabulate (for markdown tables): `pip install tabulate`

Required external tools:
- LibreOffice (for PowerPoint conversion): `brew install libreoffice`
- Obsidian (for PDF export with beautiful rendering)
