# [TITLE]

**Action required**: Fill in [TITLE], [EXP_RANGE] (e.g., Exp01-03), [DATE] (YYYY-MM-DD), and [AUTHOR].

Experiments: [EXP_RANGE]
Date: [DATE]
Author: [AUTHOR]

---

**Note**: Use citations [^1], [^2], etc. throughout this report to reference:
- Specific lines in labnote files (e.g., notebook/labnote/Exp01_qc.md:45)
- Analysis results (e.g., results/Exp01_qc/summary.csv)
- Figures (e.g., results/Exp01_qc/figure1.png)
- Knowledge base entries (e.g., notebook/knowledge/01_method-background.md)
- Web resources (save to notebook/knowledge/ first, then cite)

All figures from analysis notebooks should be referenced using their PNG file paths.

---

## Objective

**Action required**: Describe the overall research objective (2-4 sentences).

[OBJECTIVE]

## Methods

### Data

**Action required**: Describe the data used in this analysis. Cite the labnote where data characteristics were documented.

[DATA_DESCRIPTION] [^1]

### Analysis Pipeline

**Action required**: Summarize the analysis steps (3-7 items). Reference specific labnote files for details.

1. [STEP1] [^2]
2. [STEP2] [^3]
3. [STEP3] [^4]

### Software Versions

**Action required**: List all major tools and their versions. Cite the labnote where these were first used.

- [TOOL1]: [VERSION] [^5]
- [TOOL2]: [VERSION] [^6]
- polars: [VERSION]
- seaborn: [VERSION]

---

**Note**: The Results and Discussion sections should focus on interpretation and biological meaning, not just facts. This is the 40% human-readable content. Always cite the source of your claims using [^N] notation.

Include figures using markdown image syntax: `![Figure description](path/to/figure.png)`

---

## Results

### [FINDING_TITLE]

**Action required**: Replace [FINDING_TITLE] with a descriptive title. Cite specific result files and include relevant figures.

[FINDINGS] [^7]

![Figure 1: [FIGURE_DESCRIPTION]](results/Exp[NN]_[name]/[figure1.png]) [^8]

Interpretation: [INTERPRETATION] [^9]

### [FINDING_TITLE_2]

**Action required**: Add more result subsections as needed. Each subsection should include findings, figures, and interpretation.

[FINDINGS] [^10]

![Figure 2: [FIGURE_DESCRIPTION]](results/Exp[NN]_[name]/[figure2.png]) [^11]

Interpretation: [INTERPRETATION] [^12]

## Discussion

### Main Findings

**Action required**: Summarize the key discoveries (3-5 bullet points) and their significance (1-2 paragraphs). Cite background knowledge if needed.

- [MAIN_FINDING1] [^13]
- [MAIN_FINDING2] [^14]
- [MAIN_FINDING3] [^15]

[SIGNIFICANCE_DISCUSSION]

### Biological Implications

**Action required**: Discuss what these findings mean biologically (2-4 paragraphs). If you reference literature or web resources, save them to notebook/knowledge/ first.

[IMPLICATIONS] [^16]

### Unexpected Results

**Action required**: Describe any surprising findings (1-2 paragraphs) and possible explanations. Cite background knowledge for context. Remove this section if no unexpected results.

[UNEXPECTED] [^17]

### Limitations

**Action required**: Discuss limitations of the analysis (3-5 bullet points) and potential sources of bias. Cite methodological papers if relevant.

- [LIMITATION1] [^18]
- [LIMITATION2] [^19]
- [LIMITATION3]

## Conclusions

**Action required**: List concrete conclusions drawn from this analysis (3-5 items).

- [CONCLUSION1] [^20]
- [CONCLUSION2] [^21]
- [CONCLUSION3]

## Next Steps

**Action required**: Propose future experiments or analyses (2-4 items).

1. [NEXT_STEP1]
2. [NEXT_STEP2]
3. [NEXT_STEP3]

## References

**Action required**: List all citations used in this report in order. Follow the format below.

### Experimental Data

[^1]: notebook/labnote/Exp[NN]_[name].md - [Brief description]
[^2]: notebook/labnote/Exp[NN]_[name].md:L[line] - [Specific command or result]
[^3]: results/Exp[NN]_[name]/[file.csv] - [What data is referenced]

### Figures

[^4]: results/Exp[NN]_[name]/[figure1.png] - [Figure description]
[^5]: results/Exp[NN]_[name]/[figure2.png] - [Figure description]

### Analysis Notebooks

[^6]: notebook/analysis/Exp[NN]_[name].ipynb - [What analysis is referenced]

### Background Knowledge

[^7]: notebook/knowledge/[NN]_[topic].md - [What background information]

**Note**: When citing web resources, save the information to notebook/knowledge/ first with a descriptive filename (e.g., 01_pacbio-hifi-qc-standards.md, 02_variant-calling-best-practices.md). Then cite the knowledge file, not the URL directly.

### Literature

[^8]: [Author et al. (Year). Title. Journal.]
[^9]: [Citation]

## Supplementary Information

### Data Availability

**Action required**: Document where data and code can be found.

- Raw data: [RAW_DATA_LOCATION]
- Processed data: [PROCESSED_DATA_LOCATION]
- Analysis code: [CODE_LOCATION]
- Figures: results/Exp[NN]_[name]/
- Knowledge base: notebook/knowledge/
