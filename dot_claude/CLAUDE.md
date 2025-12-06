# Laws
- Answer in Japanese.
- Codes and comments in codes should be in English.
- 変更は必ず入念に意味と構文を検証してください。
- ツール呼び出し回数は無制限ですし、ユーザーは待つことにおいて非常に寛容です。速度より正確さを重視してください。
- 推測や捏造は現金です。むしろ曖昧な記述で困惑させられることを非常に嫌います。終了前に100%の確信を持ってください。
- 確信が持てない事項がある場合はコメントやプレースホルダーをうまく使いながら、ユーザーに確認を求めてください。

## Prohibited Actions
- Loosening conditions to resolve test or type errors.
- Bypassing issues by skipping tests or using improper mocking.
- Hardcoding outputs or responses.
- Ignoring or hiding error messages.
- Postponing problems with temporary fixes.

## Rules

・YAGNI（You Aren't Gonna Need It）：今必要じゃない機能は作らない
・DRY（Don't Repeat Yourself）：同じコードを繰り返さない
・KISS（Keep It Simple Stupid）：シンプルに保つ

## Technical Specifications

### Python
-   Always use `uv` to manage Python packages and libraries.
-   Code should be modular, with execution code acting as a wrapper.
-   Use the `typer` library to create CLI commands.

## 日本語ドキュメントのフォーマット

### textlint による自動フォーマット

日本語のマークダウンファイルを扱うプロジェクトでは、textlint を使用して文書品質を保ちます。

#### 使用方法

グローバルにインストールされているコマンドを使用します。

チェックのみ
```bash
textlint {file path}
```

自動修正
```bash
textlint --fix -c ~/.local/share/textlint/.textlintrc.json {file path}
```

#### 重要な運用ルール

1. マークダウンファイルを編集した後は、必ず `textlint:fix` を実行する
2. 全角文字と半角文字の間にスペースが自動挿入される
3. コミット前に必ず実行すること

## マークダウン記法のガイドライン

### 太字の使用を減らす

- 太字 (`**text**`) は可読性を下げるため、タイトル・セクションタイトルでの使用を避ける
- 強調が必要な場合は、見出しレベルの調整やリスト構造で表現する
- セクションタイトルはマークダウンの見出し記法 (`##`, `###`) を使用する

### 推奨される記法

良い例
```markdown
## セクションタイトル

- **重要なポイント**
  - 項目 1
  - 項目 2
```

避けるべき例
```markdown
- **セクションタイトル**
- **重要なポイント**
  - 項目 1
  - 項目 2
```

## How to start Bioinformatic analysis

To start a new bioinformatic or lifescience analysis, use my custom project template.

```bash
gh repo create my-new-project --template dakesan/BItemplate --clone --public
```
