-- Leader key設定
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable OSC 52 clipboard (use native clipboard provider)
vim.o.clipboard = 'unnamedplus'
vim.g.clipboard = false

-- Markdown最適化: HTMLとその依存関係の読み込みを防ぐ
vim.g.markdown_recommended_style = 0  -- デフォルトのスタイル設定を無効化
vim.g.markdown_enable_insert_mode_mappings = 0  -- 挿入モードマッピングを無効化
vim.g.markdown_enable_spell_checking = 0  -- スペルチェックを無効化

-- Markdownの不要な言語構文を無効化（高速化のため）
vim.g.markdown_fenced_languages = {
  'python=python',
  'bash=sh',
  'lua=lua',
  'vim=vim',
  -- HTML, CSS, JavaScriptは除外して読み込みを防ぐ
}

-- Markdown関連の設定
vim.g.markdown_recommended_style = 0  -- 推奨スタイルを無効化
vim.g.vim_markdown_folding_disabled = 1  -- 折りたたみを無効化

-- マークダウンファイルでHTML構文の読み込みを完全に無効化
vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = "*.md,*.markdown",
  callback = function()
    -- HTML構文を読み込まないようにする
    vim.b.html_no_rendering = 1
    vim.g.html_no_rendering = 1
    vim.b.markdown_includeHtml = 0
  end,
})

-- MDXファイルをMarkdownとして扱う
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.mdx",
  callback = function()
    vim.bo.filetype = "markdown"
    -- Markdownと同様にHTMLレンダリングを無効化
    vim.b.html_no_rendering = 1
    vim.g.html_no_rendering = 1
    vim.b.markdown_includeHtml = 0
  end,
})

-- デフォルトはconceallevel=0（すべて表示）
vim.opt.conceallevel = 0

-- Markdown/Obsidianファイルのみconceallevelを設定
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.conceallevel = 1
  end,
})

-- 基本設定
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'extend'
vim.opt.autoread = true
vim.opt.signcolumn = 'auto'  -- サインがある時だけサインカラムを表示
vim.opt.list = false      -- 不可視文字を非表示

-- インデント設定
vim.opt.tabstop = 4        -- タブ文字の表示幅
vim.opt.softtabstop = 4    -- タブキーを押した時のインデント幅
vim.opt.shiftwidth = 4     -- 自動インデントの幅
vim.opt.expandtab = true   -- タブをスペースに変換
vim.opt.autoindent = true  -- 自動インデント
vim.opt.smartindent = true -- スマートインデント

-- ファイルタイプ別のインデント設定
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "javascript", "typescript", "json", "yaml", "html", "css", "scss" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- 外部でファイルが変更されたときの自動リロード
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter", "CursorHold", "CursorHoldI"}, {
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- 保存前にディレクトリがなければ作成
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(event)
    local file = event.match
    local dir = vim.fn.fnamemodify(file, ":p:h")

    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})
