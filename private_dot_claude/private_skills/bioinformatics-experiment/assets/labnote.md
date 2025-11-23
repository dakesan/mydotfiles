---
cdate: [DATE]
mdate: [DATE]
tags: [bioinformatics, [EXP_NUMBER]]
status: in-progress
author: [AUTHOR]
---

# Exp[EXP_NUMBER]: [TITLE]

**記入必須**: [EXP_NUMBER] (ゼロパディング、例：01, 02)、[TITLE]、[DATE] (YYYY-MM-DD形式)、[AUTHOR]を記入してください。

>[!Todo] Background
>**記入必須**: 研究背景とコンテキストを記述してください。
>
>- 研究背景または実験コンテキスト
>- テストID（該当する場合）: [TEST_ID]
>- 全体目的: [OBJECTIVE]

>[!Works] Purpose
>**記入必須**: 具体的な実験目的を記述してください。
>
>- この実験の具体的な目的
>- 検証する仮説または条件
>- 期待される結果

>[!Done] Results Summary
>**記入必須**: すべてのTrialを完了した後に記入。主要な結果を要約してください。
>
>**主要な発見:**
>1. [FINDING1]
>2. [FINDING2]
>3. [FINDING3]

>[!Important] Key Points
>**記入必須**: 重要な技術的考慮事項を記載してください。
>
>**技術的注意事項:**
>- 重要な実験上の考慮事項
>- 重要なプロトコルポイント
>- 安全装置や機器設定

## Experimental Timeline

**記入必須**: Trialの進行に応じてこの表を更新してください。

| Trial | 日付 | 説明 | 主要結果 |
|-------|------|------|---------|
| Trial 1 | [DATE] | [SUBTITLE] | [RESULT_SUMMARY] |
| Trial 2 | [DATE] | [SUBTITLE] | [RESULT_SUMMARY] |

---

## Configuration

**記入必須**: 該当する場合は設定ファイルへの参照を記入。形式: config/YYYYMMDD_Exp[NN]_[description].yaml

- **Config**: config/[DATE]_Exp[EXP_NUMBER]_[DESCRIPTION].yaml (オプション)
- **Tools & Versions**: (各TrialのMaterials & Toolsセクションを参照)
- **Data Paths**: (各TrialのMaterials & Toolsセクションを参照)

---

## Trial 1 - [SUBTITLE]

**記入必須**: [SUBTITLE]をこのTrialの簡潔な説明に置き換えてください（例：「初期パラメータ探索」、「SAMベース疑似ラベリング」）。

### Plan

**記入必須**: このTrialのアプローチを簡潔に箇条書き（3-5項目）で記述してください。

- [STEP1]
- [STEP2]
- [STEP3]

### Materials & Tools

**記入必須**: このTrialで使用したすべてのツール、データセット、スクリプトをリストしてください。

**Tools/Software:**
- [TOOL1]: [VERSION]
- [TOOL2]: [VERSION]

**Datasets:**
- [DATASET1]
  - Path: [INPUT_PATH]
  - Size: [SIZE]
  - Description: [DESCRIPTION]
- [DATASET2]
  - Path: [INPUT_PATH]
  - Size: [SIZE]

**Scripts/Pipelines:**
- [SCRIPT1]: [PATH/TO/SCRIPT]
- [PIPELINE1]: [PATH/TO/PIPELINE]

**Output Directory:**
- results/Exp[EXP_NUMBER]_[DESCRIPTION]/trial1/

### Methods

**記入必須**: 実際に実行した内容を記録してください。必要に応じてステップを追加・削除してください。ここには完全なPythonコードは記載せず、src/scriptディレクトリに保存してください。ここに記載すべきは、それらのコードを呼び出す実行コマンドです。

**Preparation:**
- [PREP_STEP1]
- [PREP_STEP2]

**Execution Steps:**

#### Step 1: [ACTION]

**Why**: [RATIONALE - このアプローチを選択した理由、または計画と異なる理由]

```bash
[ACTUAL_COMMAND]
```

**Parameters**:
- [PARAM1]: [VALUE] - [EXPLANATION]
- [PARAM2]: [VALUE] - [EXPLANATION]

**Execution Time**: [TIME]

#### Step 2: [ACTION]

**Why**: [RATIONALE]

```bash
[ACTUAL_COMMAND]
```

**Parameters**:
- [PARAM1]: [VALUE] - [EXPLANATION]

**Execution Time**: [TIME]

### Results

**記入必須**: このTrialの主要な発見を箇条書き（3-5項目）で記載してください。数値と観察に焦点を当ててください。

**Measurements (Date/Time: [DATETIME]):**

| Sample | Metric1 | Metric2 | Metric3 |
|--------|---------|---------|---------|
| Sample1 | [VALUE] | [VALUE] | [VALUE] |
| Sample2 | [VALUE] | [VALUE] | [VALUE] |

**Observations:**
- [FINDING1]
- [FINDING2]
- [FINDING3]

**Key Figures:**

![Figure 1: [DESCRIPTION]](results/Exp[EXP_NUMBER]_[DESCRIPTION]/trial1_[figure1.png])

**Output Files:**
- [OUTPUT_FILE1]: results/Exp[EXP_NUMBER]_[DESCRIPTION]/trial1/[filename]
- [OUTPUT_FILE2]: results/Exp[EXP_NUMBER]_[DESCRIPTION]/trial1/[filename]

### Discussion

#### Interpretation

**記入必須**: 結果をどのように解釈しますか？何がうまくいきましたか？何がうまくいきませんでしたか？

[INTERPRETATION]

#### Problems & Limitations

**記入必須**: どのような問題に遭遇しましたか？何を改善できますか？

- [PROBLEM1] → [IMPROVEMENT1]
- [PROBLEM2] → [IMPROVEMENT2]

#### Next Steps

- [NEXT_STEP1]
- [NEXT_STEP2]

---

## Trial 2 - [SUBTITLE]

**記入必須**: 追加のTrialには上記のTrialテンプレートをコピーしてください。各Trialは独自のPlan/Materials & Tools/Methods/Results/Discussionを持つ必要があります。

### Plan

- [STEP1]
- [STEP2]

### Materials & Tools

**Tools/Software:**
- [TOOL1]: [VERSION]

**Datasets:**
- [DATASET1]
  - Path: [INPUT_PATH]

**Output Directory:**
- results/Exp[EXP_NUMBER]_[DESCRIPTION]/trial2/

### Methods

#### Step 1: [ACTION]

**Why**: [RATIONALE]

```bash
[ACTUAL_COMMAND]
```

**Parameters**:
- [PARAM1]: [VALUE]

### Results

**Measurements:**

| Sample | Metric1 | Metric2 |
|--------|---------|---------|
| Sample1 | [VALUE] | [VALUE] |

**Observations:**
- [FINDING1]
- [FINDING2]

### Discussion

#### Interpretation

[INTERPRETATION]

#### Problems & Limitations

- [PROBLEM1] → [IMPROVEMENT1]

#### Next Steps

- [NEXT_STEP1]

---

## 総合考察と結論

**記入必須**: すべてのTrialを完了した後に記入してください。すべてのTrialから得られた学びを統合してください。

### 主要な発見

**記入必須**: すべてのTrialから得られた主要な発見を要約してください。

1. **[DISCOVERY1_TITLE]**
   - [DETAILED_DESCRIPTION]
   - サポートデータ: [REFERENCE_TO_TRIAL/FIGURE]

2. **[DISCOVERY2_TITLE]**
   - [DETAILED_DESCRIPTION]
   - サポートデータ: [REFERENCE_TO_TRIAL/FIGURE]

3. **[DISCOVERY3_TITLE]**
   - [DETAILED_DESCRIPTION]
   - サポートデータ: [REFERENCE_TO_TRIAL/FIGURE]

### 今後の方向性

**記入必須**: 現在の発見に基づいて今後の作業を計画してください。

**最優先課題:**
1. [PRIORITY1]
2. [PRIORITY2]

**短期的課題（1-3ヶ月）:**
1. [SHORT_TERM1]
2. [SHORT_TERM2]

**中長期的展望（3ヶ月以上）:**
1. [LONG_TERM1]
2. [LONG_TERM2]

### 最終推奨事項

**記入必須**: すべての実験結果に基づいて明確な推奨事項を提供してください。

**現時点での推奨:**
- [RECOMMENDATION1]
- [RECOMMENDATION2]
- [RECOMMENDATION3]

**避けるべき方法:**
- [AVOID1] - 理由: [REASON]
- [AVOID2] - 理由: [REASON]

### Recommended Next Experiment

**記入必須**: Exp[NEXT_NUMBER]では何に焦点を当てるべきですか？

[NEXT_EXPERIMENT_DESCRIPTION]

---

## Notes

**記入必須**: 追加の観察、予期しない発見、または技術的詳細を記載してください。このセクションはオプションです。

[NOTES]
