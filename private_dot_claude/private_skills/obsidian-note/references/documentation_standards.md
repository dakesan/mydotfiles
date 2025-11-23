# Documentation Standards for Hiro Repository

This document outlines the documentation standards and guidelines specific to the Hiro repository.

## Philosophy

The documentation in this repository follows these core principles:

1. **Knowledge Repository**: Build a knowledge repository using Obsidian that serves as a reliable reference.

2. **Long-term Readability**: Write content that will be understandable 6 months later. Avoid excessive abbreviation or shortcuts.

3. **Potential Sharing**: While primarily personal notes, always write with the awareness that content may be shared with supervisors or colleagues.

4. **AI-Friendly Structure**: Structure documents to facilitate information extraction by AI tools. Prioritize clear, parseable text structures.

## Language and Terminology

### Language Usage

- **Primary Language**: Japanese (日本語)
- **Technical Terms**: English technical terms and business English can be freely mixed in
- **Biology Terms**: Always use English (e.g., oncology, cell therapy, iPS therapy, CGT, cancer, homologous recombination, genome editing)

### Standard Names

- **Company Name**: "Logomix"
- **Personal Name**: "大嶽" (English: Hiro)

## Formatting Rules

### Basic Markdown Structure

1. **Base Format**: Use simple Markdown as the foundation
2. **Headings**: Do NOT use bold in headings
3. **Heading Levels**: Use heading hierarchy and bullet lists as the primary structure
4. **Inline Formatting**:
   - `code` formatting is allowed
   - *italic* formatting is allowed

### Emphasis and Highlighting

- **Bold Text**: Use **bold** for emphasis within body text
- **Highlighting**: Use ==highlighting== for particularly important content
- **Guideline**: Use highlighting sparingly - only for critical information

### Obsidian Callouts

Callouts are powerful visual elements in Obsidian that can be used to emphasize content or structure documents.

#### Allowed Types

Limit callouts to 7 types only:
- `warning` - Critical warnings or cautions
- `info` - Important information or notes
- `error` - Errors or problems to address
- `todo` - Tasks or items to be completed
- `works` - Work in progress or methods
- `done` - Completed tasks or results
- `important` - Critical information requiring attention

#### Usage Patterns

**1. As Section Headings (Lab Notes)**

Callouts are commonly used as visual section headings in lab notebooks to clearly delineate experiment phases:

```markdown
>[!Todo] Background
>- 先行研究の概要
>- 実験の動機

>[!Works] Purpose
>- 実験の目的を明確に記載

>[!Done] Results
>- 実験結果をまとめる

>[!Important]
>- 特記事項や重要な観察結果
```

**2. For Important Notes (Protocols)**

Use callouts to highlight critical information within protocols or procedures:

```markdown
## プロトコル

### 反応液の調製

| Component | Volume |
|-----------|--------|
| Buffer    | 10 μL  |

> [!info]
> - テクニカルレプリケートは最低3回実施する
> - ネガティブコントロール（NTC）を必ず含める

### PCR条件

| Step | Temperature | Time |
|------|-------------|------|
```

**3. For Meta Information (Meetings)**

Use callouts to display meta information or identifiers:

```markdown
## Tasks

- [ ] タスク1
- [ ] タスク2
```

#### Guidelines

1. **Avoid Overuse**: Callouts should be used sparingly. Not every section needs a callout.
2. **Consistent Pattern**: Within a document type (e.g., all lab notes), use callouts consistently for the same purposes.
3. **Clear Purpose**: Each callout should have a clear purpose - either structural (section heading) or emphatic (highlighting critical info).
4. **Don't Nest**: Avoid nesting callouts within callouts.

#### When NOT to Use Callouts

- Regular body text or paragraphs
- Every bullet point or list
- Routine information that doesn't need emphasis
- When regular headings (##, ###) would suffice

### Wikilinks

- **Usage**: Use Obsidian wikilinks appropriately throughout documents
- **Target**: Aim for approximately 30 links per document for key terms and concepts
- **Format**: `[[Note Name]]` or `[[Note Name|Display Text]]`

### Writing Style

1. **Balance**: Aim for writing that is neither too verbose nor too concise
2. **Complete Sentences**: Avoid incomplete sentences consisting only of noun phrases or single words
3. **Subject-Predicate Clarity**: Maintain simple but clear subject-predicate relationships
4. **Avoid**: Pure keyword lists or telegraphic style

**Good Example**:
```markdown
実験を開始した。サンプルは3つ準備した。
```

**Poor Example**:
```markdown
実験開始。サンプル3つ。
```

## File Naming Conventions

Follow these naming patterns for different document types:

- **Experiment Notes**: `YYYYMMDD_<title>.md`
- **Meeting Records**: `YYYYMMDD_<meeting_name>.md`
- **Protocols**: `YYYYMMDD_protocol_<title>.md`
- **General Pattern**: Most files follow the date prefix + descriptive title pattern
- **Space Handling**: Spaces in titles are automatically converted to hyphens to prevent file system issues

**Examples**:
```
20250125_CRISPRa-screening-results.md
20250125_weekly-bizdev-meeting.md
20250125_protocol_cell-lysis.md
```

## Document Structure

### Standard Sections

Most documents should include:

1. **Frontmatter (YAML)**: Metadata for the document
2. **Main Heading**: Clear title (H1)
3. **Structured Content**: Use H2, H3 for organization
4. **Lists and Tables**: For structured data presentation

### Frontmatter Templates

Frontmatter structure varies by document type. Use inline array format `[tag1, tag2]` for tags.

#### Lab Notebook
```yaml
---
date: YYYY-MM-DD
tags: [labnote, experiment, topic]
status: in-progress|completed
author: Hiro
---
```

#### Meeting Notes
```yaml
---
date: YYYY-MM-DD
cdate: YYYY-MM-DD
mdate: YYYY-MM-DD
tags: [meeting, meeting-type]
meeting_type: pl|bizdev|udc|cmc|research|recruiting|vendor
---
```

**Notes**:
- `date`: Meeting date (primary date)
- `cdate`: File creation date
- `mdate`: Last modification date
- `tags`: Always include `meeting` plus meeting type (should match `meeting_type`)
- `meeting_type`: Required field for categorization
- Meeting metadata (participants) should be in body text when needed, not frontmatter
- Template: `assets/templates/meeting.md`

**Meeting Type Guidelines - Attendees Requirements**:
- `pl` (Project Leader meeting): Internal Logomix meeting - **No attendees list needed**
- `bizdev` (Business Development): Internal Logomix meeting - **No attendees list needed**
- `udc` (UDC weekly): Internal team meeting - **No attendees list needed**
- `cmc` (CMC meeting): May include external - **Include attendees if external participants**
- `research`: Internal research discussion - **No attendees list needed**
- `recruiting`: Interview/hiring - **Include attendees** (interviewer + candidate)
- `vendor`: External vendor meeting - **Include attendees** (Lx: + vendor representatives)

#### General Documents (Survey, Tech Memo, etc.)
```yaml
---
date: YYYY-MM-DD
tags: [category, topic]
status: draft|in-progress|completed
author: Hiro
---
```

**Note**: Use `date` (not `created`/`modified`) as the primary date field. Tags should use inline array format `[tag1, tag2]` rather than multiline list format.

## Content Organization

### Use of Headings and Lists

- **Primary Structure**: Headings + bullet lists
- **Hierarchy**: Maintain clear heading hierarchy (H1 → H2 → H3)
- **Lists**: Use for enumerating items, steps, or related information

**Example**:
```markdown
# Experiment Title

## Background
- Previous studies showed X
- Hypothesis: Y affects Z

## Methods
1. Prepare samples
2. Run analysis
3. Collect data

## Results
### Primary Findings
- Result 1
- Result 2

### Secondary Observations
- Observation 1
- Observation 2
```

### Tables for Structured Data

Use tables for:
- Experimental parameters
- Sample information
- Comparative data
- Structured observations

**Example**:
```markdown
| Sample ID | Concentration | Temperature | Result |
| --------- | ------------- | ----------- | ------ |
| S001      | 10 μM         | 37°C        | +      |
| S002      | 20 μM         | 37°C        | ++     |
```

## Reformatting Guidelines

When reformatting existing markdown that deviates from documentation rules:

### Critical Rules

1. **Never Omit Content**: NEVER omit or lose any original content
2. **Preserve Intent**: When possible, supplement words to complete sentences, but avoid adding intent not present in the original text
3. **Conservative Edits**: Make minimal necessary changes to conform to standards

### Reformatting Process

1. Read the entire document first
2. Identify deviations from standards
3. Make corrections while preserving all original information
4. Complete incomplete sentences where contextually clear
5. Add proper formatting (headings, lists, emphasis)
6. Ensure wikilinks are appropriately used

**Before Reformatting**:
```markdown
実験結果
サンプル1: 良好
温度高め → 問題？
```

**After Reformatting**:
```markdown
## 実験結果

実験結果は以下の通りである：

- サンプル1の結果は良好だった
- 温度が高めだったため、問題がある可能性がある
```

## Directory-Specific Guidelines

### Lab Notebooks (`0_LabNotebook/`)

- Use structured experimental format
- Include clear methods, results, and analysis sections
- Add protocol references using wikilinks
- Use tables for data presentation

### Meetings (`1_Meeting/`)

- Start with meeting metadata (date, attendees, location)
- Use action items with checkboxes
- Reference related notes with wikilinks
- Include decisions and next steps

### Surveys (`2_Survey/`)

- Cite sources appropriately
- Summarize key findings
- Use headings to organize topics
- Add tags for subject areas

### Tech Memos (`3_TechMemo/`)

- Focus on technical accuracy
- Include code examples where relevant
- Reference related technical docs
- Document troubleshooting steps

### Quick Notes (`5_Quick Notes/`)

- Temporary holding area for ideas
- **Important**: These notes need additional research and refinement
- Should eventually be moved to appropriate directories
- May have relaxed formatting initially but should be cleaned up

## Quality Checklist

Before finalizing any document, verify:

- [ ] File named according to conventions
- [ ] YAML frontmatter present and complete
- [ ] Language usage follows guidelines (Japanese primary, English for technical/biology terms)
- [ ] Headings do not use bold
- [ ] Appropriate use of emphasis (bold, highlighting)
- [ ] Callouts used sparingly (if at all)
- [ ] Wikilinks added for key concepts (~30 links)
- [ ] Complete sentences (no telegraphic style)
- [ ] Clear subject-predicate relationships
- [ ] Appropriate use of lists and tables
- [ ] Content readable and understandable 6 months later

## Common Mistakes to Avoid

1. **Overusing Callouts**: Callouts should be rare, not in every section
2. **Incomplete Sentences**: Avoid noun-only phrases
3. **Missing Context**: Always provide enough context for future understanding
4. **Inconsistent Naming**: Follow file naming conventions strictly
5. **Excessive Abbreviation**: Write full explanations rather than cryptic shorthand
6. **Wrong Language for Terms**: Biology terms must be in English
7. **Bold in Headings**: Never add bold formatting to heading text
8. **No Wikilinks**: Remember to link related concepts
9. **Flat Structure**: Use heading hierarchy, don't put everything under H1
10. **Tables as Lists**: Use proper tables for structured data, not fake ASCII tables

## Examples

### Good Example: Lab Note (Standard Format)

```markdown
---
created: 2025-01-25
tags:
  - experiment
  - CRISPR
status: completed
author: Hiro
---

# CRISPRa Screening - Round 1

## Background

この実験では[[CRISPRa]]を使用してtarget genesの発現を活性化し、細胞のphenotypic changesを観察した。

## Methods

実験は以下の手順で実施した：

1. [[iPSC]]を96-well plateに播種した（詳細は[[protocol_Seeding iPS cells into 96 well plate]]を参照）
2. CRISPRa libraryをtransfectionした
3. 7日間cultureした

## Results

### Cell Viability

| Condition | Day 3 | Day 7 | Notes           |
| --------- | ----- | ----- | --------------- |
| Control   | 95%   | 92%   | 正常            |
| Guide A   | 88%   | 45%   | 顕著な減少      |
| Guide B   | 93%   | 89%   | Controlと同等   |

### Key Findings

実験から以下の知見が得られた：

- Guide Aはcell viabilityに大きな影響を与えた
- Guide Bは目立った影響を示さなかった
- Day 7でのviability低下が観察された

> [!important]
> Guide Aのtoxicityについては追加検証が必要である。

## Next Steps

- [ ] Guide Aのdose-response curveを作成する
- [ ] Alternative guidesをテストする
- [ ] [[Western blotting]]でtarget protein levelを確認する
```

### Good Example: Lab Note (Using Callout Section Headings)

```markdown
---
created: 2025-01-25
tags:
  - experiment
  - differentiation
status: in-progress
author: 大嶽
---

# iPSC Differentiation - Pancreatic Lineage

>[!Todo] Background
>- [[iPSC]]から[[pancreatic progenitor cells]]への分化を試みる
>- 先行研究では[[activin A]]と[[FGF]]を用いたstage-specificなprotocolが報告されている
>- 目標はstage 4 pancreatic progenitor cellsの獲得

>[!Works] Purpose
>- 既存protocolを最適化し、効率的な分化を達成する
>- [[PDX1]]と[[NKX6.1]]のco-expressionを確認する

>[!Works] Methods

### Stage 1: Definitive Endoderm (Day 0-3)

| Component | Concentration | Notes |
|-----------|---------------|-------|
| Activin A | 100 ng/mL | [[RPMI 1640]] + 0.2% FBS |
| Wnt3a | 25 ng/mL | Day 0のみ |

### Stage 2: Primitive Gut Tube (Day 4-6)

培地を[[DMEM/F12]]に変更し、以下を添加：
- FGF10: 50 ng/mL
- KAAD-cyclopamine: 0.25 μM

>[!Done] Results

### Gene Expression Analysis

| Gene | Day 0 | Day 3 | Day 6 | Target |
|------|-------|-------|-------|--------|
| SOX17 | 1.0 | 45.2 | 12.3 | >30 (Day 3) |
| FOXA2 | 1.0 | 38.7 | 28.1 | >20 (Day 3) |
| PDX1 | 1.0 | 2.1 | 18.9 | >10 (Day 6) |

結果として以下が確認された：

- Stage 1でのdefinitive endoderm markersの発現は良好だった
- Stage 2への移行は成功したが、PDX1の発現がやや低かった

>[!Important]
>- Day 6のPDX1発現が目標値を下回っている
>- FGF10の濃度を75 ng/mLに増やすことを検討
>- 次回は[[qPCR]]に加えて[[immunostaining]]でprotein levelも確認する

## Next Experiments

- [ ] FGF10濃度を最適化（50, 75, 100 ng/mL）
- [ ] Stage 3への分化を継続
- [ ] [[Western blotting]]でPDX1 protein levelを確認
```

### Good Example: Meeting Note (Simple Format)

```markdown
---
date: 2025-01-25
cdate: 2025-01-25
mdate: 2025-01-25
tags: [meeting, bizdev]
meeting_type: bizdev
---

# 20250125_weekly-bizdev

日時: 2025-01-25

Lx: [[OdakeHiro]], [[TanakaTaro]], [[SatoKen]]

## 議事

### 先週のFollow-up

[[Vendor A]]とのmeetingは成功だった：

- Technical capabilitiesは要求を満たしている
- Pricingは予算内に収まる見込み
- Next stepとして[[trial agreement]]を進める

### 新規Partner候補

以下の候補をレビューした：

| Company    | Focus Area      | Priority | Next Action    |
| ---------- | --------------- | -------- | -------------- |
| Company X  | Cell Culture    | High     | Schedule call  |
| Company Y  | Sequencing      | Medium   | Request quote  |
| Company Z  | Bioinformatics  | Low      | Monitor        |

### Contract Negotiation

[[Contract with Vendor B]]のnegotiationが進行中である：

- Payment termsについて合意に達した
- IP rightsの条項を調整中
- 来週中の契約締結を目指す

## Action Items

- [ ] [[OdakeHiro]]: Company Xにmeeting requestを送る - Due: 2025-01-27
- [ ] [[TanakaTaro]]: Vendor BのIP条項を法務と確認 - Due: 2025-01-30
- [ ] [[SatoKen]]: Company YからquoteをfollowUp - Due: 2025-02-01

---

> [!Info]
> 追加情報やメモ
```

### Good Example: Meeting Note (Structured Format for Strategic Meetings)

```markdown
---
date: 2025-01-25
cdate: 2025-01-25
mdate: 2025-01-25
tags: [meeting, pl]
meeting_type: pl
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
- 次のマイルストーン: Q1終了までにPoC完成

#### [[Project Beta]]
- 進捗: 順調、予定通り
- 課題: なし
- 次のマイルストーン: 2月中旬にvendor evaluation完了

### 3. リソース配分

現在のリソース状況をreviewし、以下を決定した：

- Project Alphaに新規メンバー2名をアサイン
- Project Betaは現状維持

### 4. 戦略的議論

[[Cell therapy market]]の動向について議論した：

- 競合他社の動きが活発化している
- 早期の市場参入が重要
- Technology partnershipを検討すべき

### 5. 意思決定事項

## 決定事項

| 項目 | 決定内容 | 実行責任者 |
|------|----------|------------|
| Project Alpha staffing | 新規メンバー2名を2月から投入 | [[OdakeHiro]] |
| Partnership strategy | Technology partner候補を3社リストアップ | [[TanakaTaro]] |

## Action Items

| タスク | 担当者 | 期限 | 優先度 |
|--------|--------|------|--------|
| リソース採用計画の作成 | [[OdakeHiro]] | 2025-02-05 | High |
| Partner候補リストの作成 | [[TanakaTaro]] | 2025-02-10 | High |
| Market analysis reportの完成 | [[PartnerCompany/SatoKen]] | 2025-02-15 | Medium |

## 次回会議予定
- 日時: 2025-02-08
- 主要議題: Partnership strategy review

## メモ

- [[Regulatory compliance]]についても次回議論が必要
- [[Budget planning]]を3月までに完了させる

---

> [!Info]
> 追加情報やメモ
```
