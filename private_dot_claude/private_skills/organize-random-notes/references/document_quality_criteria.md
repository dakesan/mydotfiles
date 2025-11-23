# Document Quality Criteria

This document defines what constitutes a "complete" document versus an "incomplete" document in the context of organizing the `random/` folder.

## Complete Document Characteristics

A document is considered **complete** when it meets all of the following criteria:

### 1. Proper Frontmatter

The document must have valid YAML frontmatter with:
- `cdate` - Creation date in YYYY-MM-DD format
- `mdate` - Modification date in YYYY-MM-DD format
- `tags` - Array of appropriate tags (see Tag Completion Guide)
- `author` - Author name (typically "Hiro")
- `draft: false` - Indicating the document is not a draft

For meeting notes, additional fields:
- `meetingType` - Type of meeting
- `attendees` - List of attendees

Example:
```yaml
---
cdate: 2025-11-10
mdate: 2025-11-10
tags: [meeting, bizdev, insitro]
draft: false
meetingType: "bizdev"
attendees: ["[[HiroyukiOdake]]", "[[YasuhiroIwabuchi]]"]
author: Hiro
---
```

### 2. Substantive Content

The document must contain meaningful content in its main sections:

#### For Meeting Notes:
- **日時** (Date/Time) - When the meeting occurred
- **参加者** (Participants) - Who attended (can be in Lx field or attendees list)
- **議事** (Agenda/Discussion) - What was discussed (not empty)
- **Tasks** or **決定事項** (Action Items/Decisions) - Outcomes and next steps

#### For Lab Notebooks:
- **目的** (Objective) - Why the experiment was conducted
- **方法** (Methods) - How it was done
- **結果** (Results) - What was observed
- **考察** (Discussion) - Analysis and interpretation

#### For Other Document Types:
- Clear title and introduction
- Body content with substance
- Logical structure and organization

### 3. Proper Formatting

- Headers are properly nested (H1 for title, H2 for sections)
- Lists and bullet points are correctly formatted
- Links to people use Obsidian wiki-link format: `[[PersonName]]`
- Code blocks, tables, or other special formatting is correctly applied

### 4. Complete Tags

- Has all required tags (document type, meeting type if applicable)
- Has 2-5 relevant content tags
- No deprecated or placeholder tags
- All tags exist in tags.yaml

## Incomplete Document Characteristics

A document is considered **incomplete** if it has one or more of these issues:

### 1. Missing or Minimal Content

- Empty sections (e.g., `## 議事` with no content underneath)
- Only placeholders or boilerplate text
- Fragmentary notes that lack context
- Rough drafts or stream-of-consciousness notes

### 2. Insufficient Tags

- Only has `random` tag
- Missing document type tag
- Meeting notes without meeting type tag
- Has deprecated or placeholder tags

### 3. Poor Structure

- No clear sections or headers
- Unformatted wall of text
- Missing critical metadata (date, participants)

### 4. Quality Issues

- Unclear or ambiguous content
- Missing context (what project? what was decided?)
- Incomplete sentences or fragments
- Raw transcription without cleanup

## Completion Strategies

When an incomplete document is identified, use these strategies:

### Strategy 1: Content Enhancement

For documents with minimal content:
1. **Check related files**: Look for related meeting notes or lab notebooks
2. **Infer from title**: Use the filename and title to infer what the document should contain
3. **Ask user**: If content cannot be inferred, ask user to provide more information or clarify

### Strategy 2: AI-Assisted Enhancement

For rough notes or transcriptions:
1. **Structure**: Organize scattered notes into proper sections
2. **Clarify**: Rewrite unclear fragments into complete sentences
3. **Format**: Apply proper markdown formatting
4. **Preserve**: Keep all original information intact

**IMPORTANT**: Never delete or substantially change the meaning of content. Only enhance clarity and structure.

### Strategy 3: Tag Completion

For documents with insufficient tags:
1. Read the content to identify document type
2. Extract keywords and topics
3. Map to tags from tags.yaml
4. Add appropriate tags to frontmatter

### Strategy 4: User Consultation

When completion is not possible without user input:
1. Present the document to user
2. Explain what's missing or unclear
3. Ask specific questions to fill gaps
4. Offer to enhance based on user's answers

## Quality Thresholds

### Minimal Threshold for Organization

A document must meet this minimal threshold before being moved from `random/`:
- Has proper frontmatter with valid tags
- Has non-empty main content section
- Is properly formatted markdown

### Ideal Threshold

A document ideally should:
- Meet all "Complete Document" criteria above
- Be readable and understandable 6 months later
- Be suitable for sharing with colleagues
- Follow all Obsidian documentation standards

## Special Cases

### Quick Notes and Ideas

Quick notes (`quicknote` tag) and ideas (`idea` tag) have lower completion requirements:
- May be brief and fragmentary
- May lack formal structure
- Should still have proper tags and frontmatter

### Private Notes

Private notes (`private` tag):
- May have less formal structure
- Content completeness is at user's discretion
- Should still be tagged and formatted

### Work in Progress

Documents marked `draft: true`:
- Are acknowledged as incomplete
- Should eventually be completed or deleted
- May remain in `random/` until completed

## Validation Checklist

Use this checklist to validate document completeness:

- [ ] Valid YAML frontmatter present
- [ ] `cdate` and `mdate` fields populated
- [ ] `tags` field has appropriate tags (no `random` tag)
- [ ] `draft` field is set to `false`
- [ ] Document type tag is present
- [ ] Meeting type tag present (if meeting)
- [ ] At least 2 content tags present
- [ ] All tags exist in tags.yaml
- [ ] Title is clear and follows naming convention
- [ ] Main content sections are non-empty
- [ ] Proper markdown formatting applied
- [ ] Links formatted correctly
- [ ] No placeholder text remaining
