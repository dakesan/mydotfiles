---
name: obsidian-note
description: Use this skill when creating or editing Markdown documents in the Hiro Obsidian repository. This skill provides comprehensive guidelines for Obsidian-flavored Markdown syntax, project-specific documentation standards, formatting rules, and file naming conventions. Applicable for lab notebooks, meeting notes, research surveys, technical memos, and quick notes.
---

# Obsidian Note

## Overview

This skill enables Claude to create and edit Markdown documents following the Hiro repository's documentation standards. The skill combines Obsidian-flavored Markdown syntax with project-specific conventions to ensure consistency, long-term readability, and AI-friendly document structure across all note types.

## When to Use This Skill

Use this skill when:

1. **Creating new notes** in any directory of the Hiro repository
2. **Editing existing Markdown files** to improve formatting or structure
3. **Reformatting notes** that deviate from documentation standards
4. **Converting rough notes** from Quick Notes to polished documentation
5. **Reviewing documents** for compliance with repository standards
6. **Creating meeting notes from audio transcripts** (gijiroku functionality)

**Specific triggers**:
- User requests to create a lab notebook entry
- User asks to format meeting notes
- User wants to clean up or reformat existing markdown
- User needs help with Obsidian syntax (wikilinks, callouts, etc.)
- User asks to create any type of note following repository conventions
- **User provides audio transcript and asks to create meeting notes**
- **User mentions "gijiroku" or "音声文字起こし" or "議事録を完成させる"**
- User provides long conversational text that appears to be from speech recognition

## Core Principles

All documentation in this repository follows four core principles:

1. **Knowledge Repository**: Build reliable reference materials using Obsidian
2. **Long-term Readability**: Write content understandable 6 months later; avoid excessive abbreviation
3. **Potential Sharing**: Write with awareness content may be shared with supervisors or colleagues
4. **AI-Friendly Structure**: Structure documents to facilitate information extraction by AI tools

## Documentation Standards

### Language and Terminology

- **Primary Language**: Japanese (日本語)
- **Mixed Usage**: English technical terms and business English can be freely mixed
- **Biology Terms**: Always use English (oncology, cell therapy, iPS therapy, CGT, cancer, homologous recombination, genome editing)
- **Standard Names**: Company = "Logomix", Personal = "大嶽" (Hiro)

### Formatting Guidelines

#### Basic Structure
- Use simple Markdown as foundation
- Base structure on headings and bullet lists
- **Do NOT use bold in headings**
- Allowed inline formats: `code` and *italic*

#### Emphasis
- **Bold text**: Use **bold** for emphasis within body text
- **Highlighting**: Use ==highlighting== only for particularly important content (sparingly)

#### Obsidian Callouts

Callouts are powerful visual elements that can be used to emphasize content or structure documents.

**Allowed Types** (limit to 7 only):
- `warning` - Critical warnings or cautions
- `info` - Important information or notes
- `error` - Errors or problems to address
- `todo` - Tasks or items to be completed
- `works` - Work in progress or methods
- `done` - Completed tasks or results
- `important` - Critical information requiring attention

**Usage Patterns**:

1. **MANDATORY Lab Notebook Quick Summary** (REQUIRED for all lab notebooks):

Lab notebooks MUST start with these 4 callouts in this exact order for quick summary:

```markdown
>[!Todo] Background
>- 研究背景と先行研究の概要
>- 実験の動機と仮説

>[!Works] Purpose
>- 実験の具体的な目的
>- 検証したい項目

>[!Done] Results Summary
>- 主要な実験結果のサマリー
>- 重要な発見事項

>[!Important] Key Points
>- 特記事項や重要な観察結果
>- 今後の方向性や注意点
```

After these 4 summary callouts, use standard markdown headings (H2, H3) for detailed experimental content.

2. **For Important Notes (Protocols)**: Highlight critical information within protocols.

```markdown
> [!info]
> - テクニカルレプリケートは最低3回実施する
> - ネガティブコントロール（NTC）を必ず含める
```

3. **For Important Notes (Meetings)**: Highlight critical decisions or follow-up items.

```markdown
> [!Important]
> - 次回までに契約書のレビューを完了する
> - 重要な決定事項を関係者に共有
```

**Guidelines**:
- **Lab notebooks**: Always use the 4-callout summary structure at the beginning, then standard headings
- **Other documents**: Use callouts sparingly for emphasis only
- Use consistently within a document type
- Each callout should have a clear purpose (structural or emphatic)
- Don't nest callouts within callouts

#### Wikilinks
- Use Obsidian wikilinks appropriately: `[[Note Name]]` or `[[Note Name|Display Text]]`
- Target approximately 30 links per document for key terms and concepts
- Link to related notes, protocols, and concepts

#### Writing Style
- **Balance**: Neither too verbose nor too concise
- **Complete Sentences**: Avoid noun-only phrases or telegraphic style
- **Clarity**: Maintain simple but clear subject-predicate relationships

**Good**: `実験を開始した。サンプルは3つ準備した。`

**Poor**: `実験開始。サンプル3つ。`

### File Naming Conventions

Follow these patterns strictly:

- **Experiment Notes**: `YYYYMMDD_<title>.md`
- **Meeting Records**: `YYYYMMDD_<meeting_name>.md`
- **Protocols**: `YYYYMMDD_protocol_<title>.md`
- **General Pattern**: Date prefix + descriptive title
- **Space Handling**: Spaces automatically converted to hyphens

Examples:
```
20250125_CRISPRa-screening-results.md
20250125_weekly-bizdev-meeting.md
20250125_protocol_cell-lysis.md
```

#### Filename Normalization Tool

Use the `scripts/normalize_filename.py` tool to automatically generate or normalize filenames according to conventions:

**Generate filename from title**:
```bash
python scripts/normalize_filename.py "FAT3の変異解析"
# Output: 20250125_FAT3の変異解析.md

python scripts/normalize_filename.py "weekly meeting" --date 20231124
# Output: 20231124_weekly-meeting.md
```

**Rename existing file**:
```bash
# With explicit date
python scripts/normalize_filename.py --rename "FAT3の変異解析.md" --date 20231124
# Renames to: 20231124_FAT3の変異解析.md

# Auto-detect date from frontmatter
python scripts/normalize_filename.py --rename "meeting notes.md"
# Reads date from frontmatter and renames accordingly
# If no date found in frontmatter, only normalizes spaces (no date prefix)

# Preview changes without renaming
python scripts/normalize_filename.py --rename "meeting notes.md" --dry-run
# Shows what would happen without actually renaming
```

**Key features**:
- Converts spaces (ASCII and full-width) to hyphens
- Adds YYYYMMDD date prefix if not present
- **Automatically reads date from YAML frontmatter** when renaming (if `--date` not specified)
- Ensures .md extension
- Preserves existing date prefix
- Dry-run mode for previewing changes
- Won't add today's date if no date found (avoids incorrect dating)

This tool replicates the filename normalization functionality from the Templater templates, ensuring consistent naming across all documents.

### Document Structure

#### Standard Frontmatter (YAML)

Frontmatter structure varies by document type. **Always use inline array format `[tag1, tag2]` for tags.**

**Lab Notebook**:
```yaml
---
date: YYYY-MM-DD
cdate: YYYY-MM-DD
mdate: YYYY-MM-DD
tags: [labnote, experiment, topic]
status: in-progress # {in-progress/completed}
author: Hiro
---
```

**Notes on Lab Notebook**:
- `date`: Experiment date (primary date)
- **MANDATORY STRUCTURE**: Must follow template format with 4 summary callouts followed by standard headings
- Template structure: `[!Todo] Background` → `[!Works] Purpose` → `[!Done] Results Summary` → `[!Important] Key Points` → Experimental Timeline → Individual experiments (H2/H3) → Conclusions
- Template file available at: `assets/templates/labnote.md`

**Meeting Notes**:
```yaml
---
date: YYYY-MM-DD
cdate: YYYY-MM-DD
mdate: YYYY-MM-DD
tags: [meeting, meeting-type]
meeting_type: pl|bizdev|udc|cmc|research|recruiting|vendor|management
meeting_scope: internal|external
---
```

**Notes on Meeting Frontmatter**:
- `date`: Meeting date (primary date)
- `cdate`: File creation date
- `mdate`: Last modification date
- `tags`: Always include `meeting` plus meeting type (should match `meeting_type`)
- `meeting_type`: Required field for categorization (one of: `pl`, `bizdev`, `udc`, `cmc`, `research`, `recruiting`, `vendor`, `management`)
- `meeting_scope`: **Required field** - `internal` for internal Logomix meetings, `external` for meetings with external parties
- Meeting metadata (participants) should be in body text when needed, not frontmatter
- Template file available at: `assets/templates/meeting.md`

**Meeting File Naming Convention**:
- **Internal meetings**: `YYYYMMDD_社内-<内容>.md` (e.g., `20250909_社内-Parsebio振り返り.md`)
- **External meetings**: `YYYYMMDD_<企業名/組織名>-<内容>.md` (e.g., `20250730_プロメガ-森さん.md`, `20250903_Synthetic-Gestalt-神谷幸太郎さん.md`)
- The file name should clearly indicate whether it's internal (社内) or external (company/organization name)

**Meeting Type Guidelines**:
- `pl` (Project Leader meeting): Internal Logomix meeting - **No attendees list needed**
- `bizdev` (Business Development): Internal Logomix meeting - **No attendees list needed**
- `udc` (UDC weekly): Internal team meeting - **No attendees list needed**
- `cmc` (CMC meeting): May include external - **Include attendees if external participants**
- `research`: Internal research discussion - **No attendees list needed**
- `recruiting`: Two types:
  - **Company recruiting** (Logomix hiring): Interview meetings - **Include attendees** (interviewer and candidate)
  - **Personal career transition**: Career agency meetings - **Include agent name** but not full attendee list (see Career Transition Meetings section below)
- `vendor`: External vendor meeting - **Include attendees** (Lx members and vendor representatives)

**Survey/Research Notes**:
```yaml
---
date: YYYY-MM-DD
cdate: YYYY-MM-DD
mdate: YYYY-MM-DD
tags: [survey, topic, subject-area]
status: in-progress # {in-progress/completed}
author: Hiro
---
```

**Notes on Survey Notes**:
- `date`: Survey/research date (primary date)
- Template file available at: `assets/templates/survey.md`

**Technical Memos**:
```yaml
---
date: YYYY-MM-DD
cdate: YYYY-MM-DD
mdate: YYYY-MM-DD
tags: [technote, topic, tool]
status: completed # {draft/completed}
author: Hiro
---
```

**Notes on Technical Memos**:
- `date`: Technical memo date (primary date)
- Template file available at: `assets/templates/technote.md`

**Protocols**:
```yaml
---
date: YYYY-MM-DD
cdate: YYYY-MM-DD
mdate: YYYY-MM-DD
tags: [protocol, technique, topic]
status: validated # {draft/validated/deprecated}
author: Hiro
version: "1.0"
---
```

**Notes on Protocols**:
- `date`: Protocol creation/validation date (primary date)
- Include version tracking for protocol iterations
- Template file available at: `assets/templates/protocol.md`

**Quick Notes**:
```yaml
---
date: YYYY-MM-DD
cdate: YYYY-MM-DD
mdate: YYYY-MM-DD
tags: [quicknote, topic]
status: draft
author: Hiro
---
```

**Notes on Quick Notes**:
- `date`: Note creation date (primary date)
- Temporary holding area for ideas
- Should be refined and moved to appropriate directories
- Template file available at: `assets/templates/quicknote.md`

**Career Transition Meetings** (Personal Job Search):
```yaml
---
date: YYYY-MM-DD
cdate: YYYY-MM-DD
mdate: YYYY-MM-DD
tags: [meeting, recruiting, jac, <company-name>]
meeting_type: recruiting
meeting_scope: external
---
```

**Notes on Career Transition Meetings**:
- `date`: Meeting date with career agency
- `tags`: Include `recruiting`, agency name (`jac`), and target company name (e.g., `nissin`, `platinumbio`)
- `meeting_type`: Always `recruiting` for career-related meetings
- `meeting_scope`: Always `external` (meetings with external career agency)
- **File naming**: `YYYYMMDD_JAC-<company-or-topic>.md` (e.g., `20250808_JAC-日清食品求人について.md`)
- **Content format**:
  - Include `参加者: Odake` (or your name)
  - Include `エージェント: JAC Recruitment [担当者名]` if known
  - Use `## 議事` for discussion notes about the opportunity
  - Use `## Tasks` for action items and follow-up tasks (can be unformatted bullet points)
  - Include company details: organization structure, position details, selection process, compensation
  - Can be less formal than business meetings - focus on capturing information
- **Privacy**: These are personal career transition notes, separate from Logomix recruiting activities

#### Content Organization

1. **Main Heading** (H1): Clear title
2. **Document Metadata** (for meetings):
   - Always include meeting date: `日時: YYYY-MM-DD`
   - Include attendees **only when needed** (see Meeting Type Guidelines above)
   - For external meetings, use format: `Lx: [Logomix members]` and list external participants
   - For internal meetings (pl, udc, research), omit attendees list
3. **Structured Sections** (H2, H3, or Callouts): Organize content hierarchically
4. **Lists**: Use for steps, findings, observations
5. **Tables**: Use for structured data (parameters, samples, results)

Example structure (standard format):
```markdown
# Experiment Title

## Background
- Context and rationale

## Methods
1. Step-by-step procedures
2. Reference protocols with wikilinks

## Results
### Primary Findings
- Key observations

### Data Tables
| Parameter | Value | Notes |
|-----------|-------|-------|

## Conclusions
- Main takeaways
```

Example structure (callout format for lab notes):
```markdown
# Experiment Title

>[!Todo] Background
>- Context and rationale

>[!Works] Methods
>
>1. Step-by-step procedures
>2. Reference protocols with wikilinks

>[!Done] Results
>
>### Data Tables
>| Parameter | Value | Notes |
>|-----------|-------|-------|

>[!Important]
>- Critical observations
>- Issues requiring follow-up
```

Example structure (meeting notes - internal meeting without attendees):
```markdown
# 20250125_PL-meeting

日時: 2025-01-25

## 議事

### Topic 1
- Discussion points

## 決定事項・タスク

- [ ] Task 1
```

Example structure (meeting notes - external meeting with attendees):
```markdown
# 20250125_vendor-meeting

日時: 2025-01-25

Lx: Odake, Tanaka
Vendor: Sato, Suzuki

## 議事

### Topic 1
- Discussion points

## Tasks

- [ ] Task 1
```

## Writing Process

When creating or editing documents:

### 1. Determine Document Type

Identify the appropriate type based on content:
- Lab Notebook (`0_LabNotebook/`) - Use callout section headings pattern
- Meeting Note (`1_Meeting/`) - Use date/participants format in body
- Research Survey (`2_Survey/`) - Use standard heading pattern
- Technical Memo (`3_TechMemo/`) - Use standard heading pattern
- Quick Note (`5_Quick Notes/`) - Flexible, to be cleaned up later

### 2. Set Up File

**Use Template Files**: Start with the appropriate template from `assets/templates/`:

General templates:
- `meeting.md` - General meeting notes
- `labnote.md` - Lab notebook entries (with callout section headings)
- `protocol.md` - Experimental protocols
- `survey.md` - Research surveys
- `technote.md` - Technical memos
- `quicknote.md` - Quick notes
- `idea.md` - Structured ideas/concepts
- `deepresearch.md` - Deep research with hypothesis testing
- `lab-report.md` - Formal research reports (研究報告書)

Meeting-specific templates:
- `meeting-bizdev.md` - Business development meetings
- `meeting-pl.md` - Project/product leadership meetings
- `meeting-recruiting.md` - Interview/recruiting meetings
- `meeting-vendor.md` - Vendor evaluation meetings

**Or create from scratch**:
- Create filename following naming conventions
- Add appropriate YAML frontmatter (use inline array format for tags!)
- Add main heading (H1)
- For meetings: Add date and participants in body text with wikilinks in `attendees` field

### 3. Structure Content

- For lab notebooks: Consider using callout section headings (`[!Todo]`, `[!Works]`, `[!Done]`, `[!Important]`)
- For meetings: Use `日時:` and `Lx:` format in body, ensure `attendees` field has wikilinks in PascalCase
- For other documents: Use standard heading hierarchy (H1 → H2 → H3)
- Organize with lists and tables
- Add wikilinks to related concepts (~30 per document)
- Use callouts sparingly for critical information (if not using callout section headings)

### 4. Apply Formatting

- **Do NOT** bold headings
- Use **bold** for emphasis in body text
- Use ==highlighting== very sparingly
- Format code with backticks
- Use proper list syntax (prefer `-` for unordered)

### 5. Quality Check

Before finalizing, verify:
- [ ] Filename follows conventions
- [ ] YAML frontmatter complete with inline array format for tags
- [ ] **Tags verified against `references/standard_tags.md`** (correct spelling, capitalization, no deprecated tags)
- [ ] Content tags added (2-5 tags describing technologies, companies, research areas)
- [ ] Language usage correct (Japanese + English technical terms)
- [ ] No bold in headings
- [ ] Appropriate emphasis (bold, highlighting)
- [ ] Callouts used appropriately (section headings for lab notes, sparingly otherwise)
- [ ] For meetings: date in body, attendees only if external participants (see Meeting Type Guidelines)
- [ ] Wikilinks added (~30)
- [ ] Person names in PascalCase format (e.g., `[[OdakeHiro]]`)
- [ ] Complete sentences (no telegraphic style)
- [ ] Clear subject-predicate relationships
- [ ] Readable 6 months later

## Reformatting Existing Documents

When reformatting documents that deviate from standards:

### Critical Rules
1. **NEVER omit or lose original content**
2. **Preserve original intent** - supplement words to complete sentences, but don't add new meaning
3. **Make minimal necessary changes** to conform to standards

### Process
1. Read entire document first
2. Identify deviations from standards
3. Make corrections preserving all information
4. Complete incomplete sentences where clear
5. Add proper formatting (headings, lists, emphasis)
6. Ensure wikilinks are appropriately used
7. Update frontmatter to use inline array format for tags
8. For meetings: ensure date/participants in body text format
9. **MANDATORY**: Use the 4-callout template structure for all lab notebooks

## Directory-Specific Guidelines

### Lab Notebooks (`0_LabNotebook/`)
- **MANDATORY STRUCTURE**: Must follow template format exactly
  1. 4 summary callouts: `[!Todo] Background` → `[!Works] Purpose` → `[!Done] Results Summary` → `[!Important] Key Points`
  2. Experimental Timeline table
  3. Individual experiment sections with standard headings (H2, H3)
  4. Comprehensive conclusions section
- Include clear protocols with wikilinks
- Use tables for data and results
- Add detailed observations and interpretations
- Frontmatter: `tags: [labnote, topic]`

### Meetings (`1_Meeting/`)
- **Required format**: `日時:` and `Lx:` (or `参加者:`) in body text, NOT in frontmatter
- Use action items with checkboxes
- Reference related notes with wikilinks
- Document decisions and next steps
- End with `[!Info]` callout for meeting ID (optional for career transition meetings)
- Frontmatter: `tags: [meeting, type]`, `meeting_type`, `meeting_scope`

**Career Transition Meetings** (subset of recruiting meetings):
- Personal job search meetings with career agencies (e.g., JAC Recruitment)
- File naming: `YYYYMMDD_JAC-<company-or-topic>.md`
- Tags: `[meeting, recruiting, jac, <company-name>]`
- Include `参加者: Odake` and `エージェント: JAC Recruitment [担当者名]`
- Use `## 議事` and `## Tasks` sections
- Can be less formal - focus on information capture
- Include: position details, selection process, organization structure, compensation discussions
- These are private career notes, separate from Logomix recruiting activities

### Surveys (`2_Survey/`)
- Cite sources appropriately
- Summarize key findings
- Use headings to organize topics
- Add subject area tags

### Tech Memos (`3_TechMemo/`)
- Focus on technical accuracy
- Include code examples where relevant
- Reference related technical docs
- Document troubleshooting steps

### Quick Notes (`5_Quick Notes/`)
- Temporary holding area
- **Need additional research and refinement**
- Should eventually be moved to appropriate directories
- May have relaxed formatting initially but should be cleaned up

## Common Obsidian Syntax

For detailed Obsidian Markdown syntax reference, see `references/obsidian_syntax.md`. Key features:

### Wikilinks
```markdown
[[Note Name]]
[[Note Name#Heading]]
[[Note Name|Display Text]]
```

### Embeds
```markdown
![[Note Name]]
![[Image.png]]
![[Image.png|300]]
```

### Callouts
```markdown
> [!info] Title
> Content here

> [!warning]
> Critical warning message
```

### Task Lists
```markdown
- [x] Completed task
- [ ] Incomplete task
```

### Tables
```markdown
| Header 1 | Header 2 |
| -------- | -------- |
| Cell 1   | Cell 2   |
```

### Frontmatter (Tags in Inline Array Format)
```yaml
---
date: 2025-01-25
tags: [tag1, tag2, tag3]
---
```

## Templates

This skill includes comprehensive document templates in `assets/templates/`:

### General Templates

- **`meeting.md`** - General meeting notes template
- **`labnote.md`** - Lab notebook entry with callout section headings
- **`protocol.md`** - Experimental protocol template
- **`survey.md`** - Research survey/literature review template
- **`technote.md`** - Technical memo template
- **`quicknote.md`** - Quick note/temporary idea template
- **`idea.md`** - Structured idea/concept development template
- **`deepresearch.md`** - Deep research template with hypothesis testing framework
- **`lab-report.md`** - Formal research report template (研究報告書)

### Meeting-Specific Templates

- **`meeting-bizdev.md`** - Business development meeting template
- **`meeting-pl.md`** - Project/product leadership meeting template
- **`meeting-recruiting.md`** - Interview/recruiting meeting template
- **`meeting-vendor.md`** - Vendor evaluation meeting template

**Usage**: Copy the appropriate template content when creating a new note, or reference the template structure when formatting existing notes.

## References

This skill includes comprehensive reference documentation:

### `references/obsidian_syntax.md`
Complete Obsidian-flavored Markdown syntax reference including:
- Basic formatting (headings, text styles, code)
- Lists (ordered, unordered, tasks, nested)
- Links (wikilinks, Markdown, Obsidian URIs)
- Embeds (notes, images)
- Callouts (all types and variations)
- Blockquotes, horizontal rules, comments
- Footnotes
- YAML frontmatter (properties)
- Tables
- Escaping and line breaks
- Obsidian-specific features

**When to read**: When you need detailed syntax information for specific Markdown elements, especially advanced features like callout variations, embed syntax, or complex frontmatter.

### `references/documentation_standards.md`
Project-specific documentation standards including:
- Detailed philosophy and principles
- Language and terminology rules
- Complete formatting guidelines (including detailed callout usage patterns)
- File naming conventions
- Document structure templates with proper frontmatter formats

### `tags.yaml` (Repository Root)
**CRITICAL**: Standard tags configuration - **ALWAYS consult before adding tags**:

**Location**: `/Users/oodakemac/Documents/Hiro/tags.yaml`

**Contents**:
- Required document type tags (`meeting`, `labnote`, `protocol`, etc.)
- Meeting type tags (`pl`, `bizdev`, `udc`, etc.)
- Research area tags (technologies, diseases, applications)
- Company/organization tags (partners, vendors, institutions)
- Tag usage rules and case sensitivity guidelines
- Deprecated tags to avoid

**When to read**:
- **ALWAYS** before adding tags to any document
- When reformatting existing documents
- When unsure about correct tag spelling or capitalization
- To ensure tag consistency across repository

**Format**: YAML file with categorized tag lists for easy reference and programmatic access

### `references/standard_tags.md`
**DEPRECATED**: This file is deprecated. Use `/Users/oodakemac/Documents/Hiro/tags.yaml` instead.
- Meeting note formatting (date/participants in body text)
- Reformatting process
- Directory-specific guidelines
- Quality checklist
- Common mistakes to avoid
- Complete examples (standard lab notes, callout-based lab notes, simple meeting notes, structured meeting notes)

**When to read**: When creating new documents, reformatting existing ones, or need detailed examples of well-formatted notes for different document types. Especially useful for understanding callout usage patterns, meeting note formats, and frontmatter structures with concrete examples.

### `scripts/normalize_filename.py`
Filename normalization utility that enforces repository naming conventions:
- Converts spaces (ASCII and full-width Japanese spaces) to hyphens
- Adds YYYYMMDD date prefix if not present
- **Automatically extracts date from YAML frontmatter** when renaming files
- Ensures .md extension
- Supports both generation mode (create filename from title) and rename mode (rename existing files)
- Includes dry-run mode for safe previewing
- Won't add today's date if no date is found (prevents incorrect dating)

**When to use**:
- When creating new notes and need to generate a properly formatted filename
- When renaming existing files to conform to naming conventions
- When batch processing filenames for consistency
- Replaces the manual filename normalization done in Templater templates

**Usage**:
```bash
# Generate new filename with specific date
python scripts/normalize_filename.py "meeting notes" --date 20231124

# Rename existing file - auto-detects date from frontmatter
python scripts/normalize_filename.py --rename "old-name.md"

# Rename with explicit date (overrides frontmatter)
python scripts/normalize_filename.py --rename "old-name.md" --date 20231124

# Preview rename without making changes
python scripts/normalize_filename.py --rename "old-name.md" --dry-run
```

## Quick Start Examples

### Creating a Lab Note (Callout Section Headings)
```markdown
---
cdate: 2025-01-25
mdate: 2025-01-25
tags: [labnote, CRISPR]
status: in-progress # {in-progress/completed}
author: Hiro
---

# 20250125_CRISPRa-screening-round-1

>[!Todo] Background
>- [[CRISPRa]]を使用してtarget genesの発現を活性化
>- Phenotypic changesを観察する

>[!Works] Methods
>
>1. [[iPSC]]を播種（[[protocol_Seeding iPS cells into 96 well plate]]参照）
>2. Library transfection
>3. 7日間culture

>[!Done] Results
>
>| Condition | Viability | Notes |
>| --------- | --------- | ----- |
>| Control   | 95%       | 正常  |
>| Guide A   | 45%       | 低下  |

>[!Important]
>- Guide Aのtoxicityについて追加検証が必要
>- Dose-response curveを作成する

## Next Steps

- [ ] Dose-response curveを作成
- [ ] Alternative guidesをテスト
```

### Creating a Meeting Note (Simple Format)
```markdown
---
cdate: 2025-01-25
mdate: 2025-01-25
tags: [meeting, bizdev]
draft: false
meetingType: "bizdev"
attendees: ["[[OdakeHiro]]", "[[TanakaTaro]]"]
---

# 20250125_weekly-bizdev

日時: 2025-01-25

Lx: [[OdakeHiro]], [[TanakaTaro]]

## 議事

[[Project A]]の進捗をreviewした：
- Phase 1は完了した
- Phase 2は来週開始予定

## Action Items

- [ ] [[OdakeHiro]]: データ解析を完了 - Due: 2025-01-30
- [ ] [[TanakaTaro]]: Reportを作成 - Due: 2025-02-01

---

> [!Info]
> 追加情報やメモ
```

### Creating a Meeting Note (Structured Format)
```markdown
---
cdate: 2025-01-25
mdate: 2025-01-25
tags: [meeting, management]
draft: false
meetingType: "pl"
attendees: ["[[OdakeHiro]]", "[[TanakaTaro]]", "[[PartnerCompany/SatoKen]]"]
---

# 20250125_PL-meeting

日時: 2025-01-25

参加者:
- Logomix: [[OdakeHiro]], [[TanakaTaro]]
- Partner: [[PartnerCompany/SatoKen]]

## アジェンダ

### 1. 前回からの進捗

### 2. 各プロジェクトレビュー

#### [[Project Alpha]]
- 進捗: Phase 2完了、Phase 3に移行中
- 課題: リソース不足、追加人員が必要

## 決定事項

| 項目 | 決定内容 | 実行責任者 |
|------|----------|------------|
| Project Alpha staffing | 新規メンバー2名を2月から投入 | [[OdakeHiro]] |

## Action Items

| タスク | 担当者 | 期限 | 優先度 |
|--------|--------|------|--------|
| リソース採用計画の作成 | [[OdakeHiro]] | 2025-02-05 | High |

---

> [!Info]
> 追加情報やメモ
```

---

**Note**: For comprehensive syntax details, always refer to `references/obsidian_syntax.md`. For detailed standards and complete examples (including callout usage patterns, meeting formats, and frontmatter structures), refer to `references/documentation_standards.md`.

## Special Mode: Creating Meeting Notes from Audio Transcripts (Gijiroku)

When the user provides an audio transcript and asks to create meeting notes, use this special workflow:

### Detection Triggers

Activate this mode when:
- User explicitly says "gijiroku skillを使って" or "音声文字起こしから議事録を作成"
- User provides both:
  1. Long conversational text (likely from speech recognition)
  2. An existing meeting note file to enhance
- Text shows characteristics of speech recognition (informal, conversational, few punctuation marks)

### Workflow

**STEP 0: Create TODO List (MANDATORY)**

Before starting any work, create a TODO list using TodoWrite tool:

```json
[
  {
    "content": "speech_correction.yamlを読み込み、音声認識誤りを修正する",
    "status": "in_progress",
    "activeForm": "音声認識誤りを修正中"
  },
  {
    "content": "音声文字起こしを構造化し、話題ごとにグルーピングする",
    "status": "pending",
    "activeForm": "音声を構造化中"
  },
  {
    "content": "既存メモと音声情報を統合し、完全な議事録を作成する",
    "status": "pending",
    "activeForm": "メモと音声を統合中"
  },
  {
    "content": "YAMLフロントマターとタグを適用し、フォーマットを調整する",
    "status": "pending",
    "activeForm": "フォーマットを調整中"
  },
  {
    "content": "品質チェックリストで確認し、ファイルに書き込む",
    "status": "pending",
    "activeForm": "品質チェックと書き込み中"
  }
]
```

**IMPORTANT**:
- Update TODO status after completing each step
- Always have exactly ONE task as `in_progress`
- Mark completed immediately after finishing, don't batch updates

**STEP 1: Read the specialized guide**
```
Read: guides/meeting_from_audio.md
```
This guide contains the complete 3-phase process for converting audio transcripts to structured meeting notes.

**STEP 2: Read the speech correction dictionary**
```
Read: guides/speech_correction.yaml
```
This dictionary contains all known speech recognition errors and their corrections, prioritized by importance.

**STEP 3: Follow the 3-Phase Process**

The `meeting_from_audio.md` guide defines three phases:
1. **Phase 1: Speech Recognition Correction** (最重要)
   - Fix company names (Logomix most important)
   - Fix person names (大嶽 for the author)
   - Fix technical terms (SWING, CAS9, etc.)
   - Use `speech_correction.yaml` as reference

2. **Phase 2: Structuring**
   - Group topics logically
   - Create heading hierarchy
   - Remove redundancy while preserving essence
   - Add context for clarity

3. **Phase 3: Integration with Existing Notes**
   - Preserve all content from existing notes
   - Enhance with details from audio
   - Add new topics from audio
   - Create comprehensive meeting record

**STEP 4: Apply Standard Formatting**
- Use proper YAML frontmatter with `tags.yaml` reference
- Add `meeting_scope: internal|external`
- Format with H2/H3/H4 hierarchy
- Create Tasks section with checkboxes

**STEP 5: Quality Check**
- Verify all speech corrections were applied
- Check against the quality checklist in `meeting_from_audio.md`
- Ensure 6-month readability

### Important Notes

- **MANDATORY: Create TODO list FIRST** using TodoWrite tool before any work
- **Always correct speech recognition errors FIRST** before structuring
- **Priority corrections**: Logomix > 大嶽 > Technical terms > Others
- **Preserve existing memo content** - never delete user's notes
- **Add context** - make it understandable 6 months later
- **Balance** - be comprehensive but not redundant
- **Update TODO status** after each phase completion (don't batch updates)

### Files to Reference

1. **MUST READ**: `guides/meeting_from_audio.md` - Complete workflow guide
2. **MUST READ**: `guides/speech_correction.yaml` - Speech error corrections
3. **MUST READ**: `/Users/oodakemac/Documents/Hiro/tags.yaml` - Tag standards
4. **Optional**: `guides/documentation_standards.md` - General standards

This mode combines the best of both worlds: accurate correction of speech recognition errors with proper Obsidian formatting standards.
