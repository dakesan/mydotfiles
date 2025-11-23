---
name: lab-report-generator
description: Generate comprehensive test report package from lab notebook with data analysis workflow. Creates structured directory, analyzes PowerPoint/Excel data, extracts images, generates summary tables, and integrates everything into refined markdown reports. Use when user requests creating test report, lab report, or experimental report with data analysis.
allowed-tools: AskUserQuestion, Bash, Read, Write, Edit, Glob, mcp__serena__list_dir, mcp__serena__find_file, mcp__serena__get_symbols_overview, Skill
---

# Lab Report Generator

This skill generates a structured test report package from lab notebook files following Logomix's documentation standards, with integrated data analysis workflow for PowerPoint/Excel data.

## Overview

This skill provides two workflows:

### Workflow A: Basic Report Generation (Original)
Creates a standardized directory structure under `_LabReports/` containing:
- Test report documentation (PDF only, exported via Obsidian)
- Data files (moved from original location)
- Results files (moved from original location)
- Reference materials (moved from original location)
- File inventory (markdown)
- Summary document (markdown, convertible to docx)

### Workflow B: Data Analysis & Markdown Refinement (New)
Extended workflow that includes:
- Step-by-step TODO management for the report generation process
- PowerPoint image extraction (figures, plots, results)
- Excel data analysis and summary table generation
- Markdown refinement based on Obsidian templates
- Integration of images and tables into refined markdown
- Iterative review and improvement cycles
- Final deliverables (PDF, file inventory, summary)

**Important**: Original lab notebook (markdown) remains in its original location and is NOT copied to _LabReports/.

## Directory Structure

```
_LabReports/
└── XX-NNNN-{実験タイトル}/
    ├── LAB_REPORT_TODO.md (workflow B only)
    ├── ファイル一覧.md
    ├── Summary.md
    ├── 1_試験報告書/
    │   └── {ラボノート}.pdf (via Obsidian export)
    ├── 2_データ/
    │   └── (user provided Excel, CSV files)
    ├── 3_結果/
    │   └── (user provided PowerPoint, result files)
    ├── 4_資料/
    │   └── (optional user provided files)
    └── 5_images/ (workflow B only)
        └── (extracted PNG images from PowerPoint)
```

## Workflow Selection

Ask user which workflow to use:
- **Workflow A (Basic)**: Quick report generation without data analysis
- **Workflow B (Full)**: Complete workflow with data analysis, image extraction, and markdown refinement

If user requests data analysis, Excel/PowerPoint processing, or markdown refinement, use Workflow B.
If user only needs basic file organization and PDF export, use Workflow A.

---

## Workflow A: Basic Report Generation

This is the original, streamlined workflow for basic report generation.

### A.Step 1: Gather Information

Ask user for required information if not provided:

1. **Experiment ID** (format: `XX-NNNN-{実験タイトル}`)
   - XX: Project code (2 characters)
   - NNNN: Sequential number (4 digits)
   - 実験タイトル: Descriptive title
   - Example: `CN-0001-iPS細胞分化実験`

2. **Lab Notebook Path**
   - Full path to the lab notebook markdown file
   - Example: `0_LabNotebook/AI/20250124_experiment_analysis.md`

3. **Data and Results Files**
   - List of files to be organized (mentioned in conversation context)
   - Files can be .pptx, .docx, or other formats
   - Categorize into: データ (data), 結果 (results), 資料 (reference materials)

Use AskUserQuestion tool to collect missing information:

```
Question 1: "実験番号を指定してください（形式: XX-NNNN-{実験タイトル}）"
Question 2: "対象のラボノートファイルのパスを指定してください"
Question 3: "整理するファイルをカテゴリごとに教えてください：
- データファイル（2_データ/）
- 結果ファイル（3_結果/）
- 資料ファイル（4_資料/）※任意"
```

### A.Step 2: Create Directory Structure

Create the following directories under `_LabReports/`:

```bash
mkdir -p "_LabReports/{実験番号}/1_試験報告書"
mkdir -p "_LabReports/{実験番号}/2_データ"
mkdir -p "_LabReports/{実験番号}/3_結果"
mkdir -p "_LabReports/{実験番号}/4_資料"
```

### A.Step 3: Organize Files

1. **Keep lab notebook** in its original location (do NOT copy to 1_試験報告書/)
   - The lab notebook will remain in the original location (e.g., random/, 0_LabNotebook/, etc.)
   - Only PDF export will be saved to 1_試験報告書/ (see Step 7)

2. **Move data files** to `2_データ/` (if provided)

3. **Move result files** to `3_結果/` (if provided)

4. **Move reference files** to `4_資料/` (if provided)

### A.Step 4: Generate File Inventory

Create `ファイル一覧.md` at root of experiment directory using the template:
- List all files in each subdirectory
- Include file descriptions based on conversation context
- Follow template in `templates/file_list_template.md`

### A.Step 5: Generate Summary Document

Create `Summary.md` at root of experiment directory:
- Extract key information from lab notebook (expects template format with 4 summary callouts)
- Parse Background from `[!Todo] Background` callout
- Parse Purpose from `[!Works] Purpose` callout
- Parse Results from `[!Done] Results Summary` callout
- Parse Key Points from `[!Important] Key Points` callout
- Summarize individual experiments from standard heading sections
- Follow template in `templates/summary_template.md`

Then inform user:
```
Summary.mdを作成しました。pandocを使用してdocxに変換できます：
pandoc Summary.md -o Summary.docx
```

### A.Step 6: Completion Report

Report to user:
- Directory structure created
- Files organized
- Generated documents (ファイル一覧.md, Summary.md)
- Next steps (docx conversion if needed)

### A.Step 7: PDF Export via Obsidian

Export lab notebook as PDF using Obsidian's renderer (this is the primary report document):

1. **Run obsidian-pdf-export.sh script** (use original lab notebook path):
   ```bash
   /Users/oodakemac/.claude/skills/lab-report-generator/scripts/obsidian-pdf-export.sh "{元のラボノートパス}"
   ```
   Example: `/Users/oodakemac/.claude/skills/lab-report-generator/scripts/obsidian-pdf-export.sh "random/20251024_experiment.md"`

2. **Inform user** - IMPORTANT instructions:
   - Obsidian will open with PDF export dialog
   - **MUST save to: `_LabReports/` directory (root level)**
   - Filename: Same as markdown file but with .pdf extension
   - Example: `20251024_experiment.pdf`
   - This preserves Obsidian's beautiful rendering including colored callouts

3. **Wait for user confirmation** that PDF has been saved

4. **Check for exported PDF** in `_LabReports/` root:
   ```bash
   find _LabReports -maxdepth 1 -name "*.pdf" -type f
   ```

5. **Move PDF to correct location**:
   ```bash
   mv "_LabReports/{ラボノート名}.pdf" "_LabReports/{実験番号}/1_試験報告書/"
   ```

6. **Update ファイル一覧.md** - Add PDF entry in 1_試験報告書/ section:
   - Filename: {ラボノート名}.pdf
   - Description: ラボノートのPDF版。Obsidian PDFエクスポート機能により生成。色付きcallout、表、強調表示を含む美しいレンダリング
   - Date: Current date

**Note**: This step uses obsidian-pdf-export.sh script which requires:
- Obsidian to be installed
- Advanced URI plugin to be installed in Obsidian
- Script location: `scripts/obsidian-pdf-export.sh` (bundled with this skill)

---

## Workflow B: Data Analysis & Markdown Refinement

This workflow extends the basic report generation with comprehensive data analysis and markdown refinement. Use this workflow when user requests PowerPoint/Excel data analysis or markdown refinement.

**Key Features:**
- Step-by-step TODO tracking for transparency
- PowerPoint image extraction with selective page selection
- Excel data analysis with summary table generation
- Markdown template validation and refinement
- Iterative review cycles with user feedback
- Integration of visual data (images + tables) into markdown

### B.Step 0: Initialize TODO Management

**FIRST STEP**: Initialize TODO tracking for this report generation process.

```bash
python3 ~/.claude/skills/lab-report-generator/scripts/manage_lab_report_todo.py \
    init "_LabReports/{実験番号}"
```

This creates `LAB_REPORT_TODO.md` in the report directory with 7 workflow tasks:
1. ファイルアップロードと整理
2. MarkdownレポートのObsidian編集
3. PowerPoint画像抽出
4. Excelデータ解析
5. Markdown統合
6. レビューと改善
7. 最終成果物生成

**Important**: Update TODO status after completing each major step:
```bash
python3 ~/.claude/skills/lab-report-generator/scripts/manage_lab_report_todo.py \
    update "_LabReports/{実験番号}" <task_number> <status>
```

Status values: `pending`, `in_progress`, `completed`, `skipped`

### B.Step 1: File Upload and Organization

Ask user to provide data files for analysis:

```
必要なデータファイルを教えてください：
1. PowerPointファイル（.pptx）- 図、プロット、結果を含む
2. Excelファイル（.xlsx）- 生データ、測定値を含む
3. その他のデータファイル

各ファイルの現在の場所を教えてください。
```

Create directory structure (if not already done):
```bash
mkdir -p "_LabReports/{実験番号}/2_データ"
mkdir -p "_LabReports/{実験番号}/3_結果"
mkdir -p "_LabReports/{実験番号}/4_資料"
mkdir -p "_LabReports/{実験番号}/5_images"
```

Copy files to appropriate directories:
- Excel files → `2_データ/`
- PowerPoint files → `3_結果/`
- Other reference files → `4_資料/`

**Update TODO**: Mark task 1 as completed after organizing files.

### B.Step 2: Markdown Refinement with Obsidian Template

Before data analysis, ensure the lab notebook markdown follows proper template structure.

**Read lab notebook** and verify template compliance:
1. YAML frontmatter with required fields (date, tags, author, etc.)
2. Four summary callouts in correct order:
   - `[!Todo] Background`
   - `[!Works] Purpose`
   - `[!Done] Results Summary`
   - `[!Important] Key Points`
3. Experimental sections with proper headings structure
4. Data source citations in Results sections

**If template elements are missing**, ask user for missing information and update markdown:
- Use Edit tool to add missing sections
- Follow obsidian-note skill guidelines for proper formatting
- Ensure Japanese/English language consistency

**Markdown Quality Checks:**
- All experiments have Results sections
- Each Results section includes data source citation
- Tables and lists are properly formatted
- Links and references are valid

**Update TODO**: Mark task 2 as completed after markdown refinement.

### B.Step 3: PowerPoint Image Extraction

Extract relevant figures/plots from PowerPoint files as PNG images.

**Process:**

1. **Identify target pages** - Ask user which PowerPoint pages to extract:
   ```
   PowerPointファイル「{filename}」から画像を抽出します。
   抽出したいページ番号を教えてください（例：2,5-8,10）
   ```

2. **Run extraction script**:
   ```bash
   python3 ~/.claude/skills/lab-report-generator/scripts/extract_pptx_images.py \
       "_LabReports/{実験番号}/3_結果/{filename}.pptx" \
       "_LabReports/{実験番号}/5_images" \
       "{page_numbers}"
   ```

3. **Rename extracted images** for clarity:
   - Default: `page_5.png`, `page_6.png`
   - Rename to: `exp1_melting_curve.png`, `exp2_amplification_plot.png`
   - Use descriptive names that match experiment sections

4. **Verify extraction**:
   ```bash
   ls -lh "_LabReports/{実験番号}/5_images"
   ```

**Alternative: Manual extraction with pandas**
If script fails, use LibreOffice + PyMuPDF directly (see `references/data_analysis_workflow.md` for details).

**Update TODO**: Mark task 3 as completed after image extraction.

### B.Step 4: Excel Data Analysis

Analyze Excel files to generate markdown summary tables.

**Process:**

1. **Read Excel structure**:
   ```python
   import pandas as pd
   df = pd.read_excel('path/to/file.xlsx', sheet_name='SheetName')
   print(df.columns.tolist())
   print(df.head())
   ```

2. **Determine analysis type**:
   - qPCR data: Use qPCR-specific analysis
   - Generic tabular data: Use generic summary
   - Time-series data: Use time-series analysis

3. **Generate summary table**:

   **Option A: Use bundled script**
   ```bash
   python3 ~/.claude/skills/lab-report-generator/scripts/analyze_excel_data.py \
       "_LabReports/{実験番号}/2_データ/{filename}.xlsx" \
       "SheetName" \
       --analysis-type qpcr \
       --output /tmp/summary.md
   ```

   **Option B: Use xlsx skill** (for complex analysis)
   ```
   Invoke Skill tool with command "xlsx"
   ```

   **Option C: Custom pandas analysis** (for specialized needs)
   ```python
   # Read and analyze data
   summary_df = analyze_custom_logic(df)
   # Generate markdown table
   markdown_table = summary_df.to_markdown(index=False)
   ```

4. **Review generated tables** with user:
   ```
   以下のサマリーテーブルを作成しました：
   [Show markdown table]

   内容は正しいですか？修正が必要な点はありますか？
   ```

**Update TODO**: Mark task 4 as completed after Excel analysis.

### B.Step 5: Markdown Integration

Integrate extracted images and summary tables into the lab notebook markdown.

**Image Integration:**

1. **Determine placement** - Images should appear in Results sections after data source citations
2. **Use relative paths** from markdown file location
3. **Add with figure captions**:
   ```markdown
   ![Description](../_LabReports/{実験番号}/5_images/{image_name}.png)

   *Figure X: Detailed caption explaining the figure content and significance.*
   ```

**Table Integration:**

1. **Add after data source citations** in Results sections
2. **Include table captions**:
   ```markdown
   | Column1 | Column2 | Column3 |
   |:--------|:--------|:--------|
   | Data1   | Data2   | Data3   |

   *Table X: Caption explaining metrics, interpretation, and key findings.*
   ```

**Integration Guidelines:**
- Maintain logical flow: data source → image → table → interpretation
- Keep figure/table numbering sequential
- Ensure captions are informative and self-contained
- Use Edit tool to modify existing markdown

**Quality Check:**
- All images load correctly in Obsidian preview
- Tables render properly
- Figure/table references are consistent
- Captions are clear and informative

**Update TODO**: Mark task 5 as completed after markdown integration.

### B.Step 6: Review and Iteration

Iterate with user feedback until report is satisfactory.

**Review Cycle:**

1. **Show updated sections** to user:
   ```
   以下のセクションを更新しました：
   - {Experiment 1}: 画像とサマリーテーブルを追加
   - {Experiment 2}: データ解析結果を統合

   内容を確認してください。修正が必要な点はありますか？
   ```

2. **Collect feedback**:
   - Image selection and placement
   - Table content and formatting
   - Caption clarity and completeness
   - Overall flow and readability

3. **Make requested modifications**:
   - Adjust image resolution or cropping
   - Modify table columns or metrics
   - Refine captions
   - Reorganize content flow

4. **Repeat until approved**:
   - Show changes after each iteration
   - Ask for confirmation before proceeding

**Update TODO**: Mark task 6 as completed when user approves final content.

### B.Step 7: Final Deliverables

Once content is finalized, generate all final deliverables.

**Process:**

1. **Export PDF via Obsidian** (same as Workflow A.Step 7):
   ```bash
   ~/.claude/skills/lab-report-generator/scripts/obsidian-pdf-export.sh "{ラボノートパス}"
   ```
   - User saves PDF to `_LabReports/` root
   - Move PDF to `1_試験報告書/`

2. **Update File Inventory** (ファイル一覧.md):
   - List all files in each subdirectory
   - Include 5_images/ directory with extracted images
   - Add descriptions for each file

3. **Generate Summary Document** (Summary.md):
   - Extract from refined markdown
   - Follow template structure

4. **Final TODO update**:
   ```bash
   python3 ~/.claude/skills/lab-report-generator/scripts/manage_lab_report_todo.py \
       update "_LabReports/{実験番号}" 7 completed
   ```

5. **Show final status**:
   ```bash
   python3 ~/.claude/skills/lab-report-generator/scripts/manage_lab_report_todo.py \
       status "_LabReports/{実験番号}"
   ```

**Completion Report:**
```
✅ Lab Report Generation Complete!

Report Directory: _LabReports/{実験番号}/
- ✓ TODO管理ファイル (LAB_REPORT_TODO.md)
- ✓ PDFレポート (1_試験報告書/)
- ✓ データファイル (2_データ/)
- ✓ 結果ファイル (3_結果/)
- ✓ 参考資料 (4_資料/)
- ✓ 抽出画像 (5_images/: {count}枚)
- ✓ ファイル一覧 (ファイル一覧.md)
- ✓ サマリー文書 (Summary.md)

Lab Notebook: {元のラボノートパス}
- ✓ 画像統合: {count}枚
- ✓ サマリーテーブル: {count}個
- ✓ データ出典: 全セクション追加済み
```

---

## Important Notes

1. **Always ask for missing information** - Never assume experiment ID or file paths
2. **Keep lab notebook in original location** - Do NOT copy .md file to _LabReports/
3. **Move data/result/reference files** to organize them into the report package
4. **Create empty directories** even if no files provided (especially 4_資料/)
5. **Follow Japanese naming conventions** for directories and generated documents
6. **Expect template-compliant lab notebooks** - Lab notebooks should follow the 4-callout structure: `[!Todo] Background` → `[!Works] Purpose` → `[!Done] Results Summary` → `[!Important] Key Points` followed by experimental sections
7. **Extract meaningful content** from lab notebook when generating Summary (parse callouts and heading sections)
8. **List files with context** in file inventory, not just filenames
9. **PDF-only in 1_試験報告書/** - CRITICAL:
   - Only PDF files should be in 1_試験報告書/
   - Do NOT save .md or .docx files to 1_試験報告書/
   - Instruct user to save PDF to `_LabReports/` root directory
   - Always check `_LabReports/` root for exported PDFs with `find` command
   - Move PDF to `1_試験報告書/` subdirectory after user confirms export
   - Update `ファイル一覧.md` with PDF entry only
   - Never assume PDF location - always search and verify

## Error Handling

- If lab notebook path is invalid, ask user to verify
- If experiment ID format is incorrect, prompt user with format example
- If _LabReports/ directory doesn't exist, create it
- If target directory already exists, warn user and ask for confirmation before overwriting

## Examples

### Example 1: Basic Usage

User: "このラボノートから試験報告書を作成してください"

Assistant actions:
1. Ask for experiment ID
2. Ask for lab notebook path
3. Ask for files to organize
4. Create directory structure
5. Move data/result files (keep lab notebook in original location)
6. Generate ファイル一覧.md and Summary.md
7. Report completion
8. Export lab notebook as PDF via Obsidian and move to 1_試験報告書/

### Example 2: With Context

User: "CN-0001-iPS分化実験の報告書を作りたい。ラボノートは0_LabNotebook/Pancreas/20250124_differentiation.mdです。データとして analysis.pptx と results.docx があります。"

Assistant actions:
1. Experiment ID: CN-0001-iPS分化実験 ✓
2. Lab notebook: 0_LabNotebook/Pancreas/20250124_differentiation.md ✓
3. Files identified: analysis.pptx (データ), results.docx (結果) ✓
4. Proceed with directory creation
5. Move data/result files (keep lab notebook at 0_LabNotebook/Pancreas/)
6. Generate ファイル一覧.md and Summary.md
7. Report completion
8. Export PDF from 0_LabNotebook/Pancreas/20250124_differentiation.md and move to 1_試験報告書/
