# Laws
- Answer in Japanese.
- Codes and comments in codes should be in English.
- 変更は必ず入念に意味と構文を検証してください。
- ツール呼び出し回数は無制限ですし、ユーザーは待つことにおいて非常に寛容です。速度より正確さを重視してください。
- 推測や捏造は現金です。むしろ曖昧な記述で困惑させられることを非常に嫌います。終了前に100%の確信を持ってください。
- 確信が持てない事項がある場合はコメントやプレースホルダーをうまく使いながら、ユーザーに確認を求めてください。

## Commands

### gemini
You can use the `gemini` command to perform a web search.

Use the `gemini` command when you need to implement something using a specific framework, or when you encounter an error that you cannot solve after three attempts. Ask gemini to use its search function.

```bash
gemini -p "{prompt}"
```

## gemini CLI Integration Guide

### Objective
When a user instructs to **"Proceed while consulting with gemini"** (or a synonym), Claude will proceed with subsequent tasks in coordination with the **gemini CLI**.
The response obtained from gemini will be presented as is, and Claude will also add its own explanation and integration, thereby merging the knowledge of both agents.

---

### Triggers
- **Cooperative Work**: Regular Expression: `/gemini.*相談しながら/`
  - Examples: "Proceed while consulting with gemini," "Let's work on this while talking with gemini."
- **Web Search**: Regular Expression: `/gemini.*(探して|検索して)/`
  - Examples: "Find this with gemini," "Search for this with gemini."

---

### Basic Flow

#### Cooperative Work Flow
1.  **Generate PROMPT**
    Claude summarizes the user's requirements into a single text and stores it in the environment variable `$PROMPT`.
2.  **Call gemini CLI**
    ```bash
    gemini -p "$PROMPT"
    ```

#### Web Search Flow
Extract the search keywords and execute gemini Websearch:
```bash
gemini -p "WebSearch: [Search Keywords]"
```

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

### Quick Reference
After creating an implementation plan, record your ideas and TODOs in `CLAUDE.md`. All implementation must follow the implementation steps.

### Implementation Step
0.  Initialize a `.git` repo if it does not exist.
1.  Fetch or pull the remote git repo.
2.  Create and switch to a new git branch.
3.  Make changes and report them to the user.
4.  If the user approves your changes, commit them, push to the remote repo, and create a Pull Request.

## Workflow

### New Feature Implementation
1.  Create an implementation plan and document it in `CLAUDE.md`.
2.  Create a new branch.
3.  Create tests (if they don't exist).
4.  Implement the code.
5.  Run tests.
6.  Deliver the final product to the user.
7.  Create a Pull Request upon confirmation.

### Existing Code Improvement
1.  Check `CLAUDE.md` to review the specifications.
2.  Verify if the existing implementation meets the specifications. If not, issue a warning and propose a correction.
3.  If there are new elements, follow the New Feature Implementation workflow.

### Data Analysis Task
1.  Conduct analysis using a modularized codebase.
2.  When creating reports, create a wrapper for the modularized code.
3.  Report the analysis results to the user.
4.  When proposing improvements, keep the existing results and retry in a separate setup for comparative evaluation.

### Small Tool Development
1.  Git management can be informal.
2.  Take ample time to think, then implement.
3.  After completion, record the thought process, trials and errors, results, and lessons learned in `CLAUDE.md`.

## Technical Specifications

### Python
-   Always use `uv` to manage Python packages and libraries.
-   Code should be modular, with execution code acting as a wrapper.
-   Use the `typer` library to create CLI commands.
