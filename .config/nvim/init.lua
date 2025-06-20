-- Leader key設定
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Markdownではvim syntaxを無効化（Treesitterが自動的に有効になる）
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.cmd('syntax off')
    -- Treesitterハイライトは自動的に有効になるため明示的な呼び出しは不要
  end,
})

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

-- 基本設定
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'extend'
vim.opt.clipboard:append('unnamedplus')
vim.opt.signcolumn = 'no'  -- サインカラムを無効化
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

-- lazy.nvimをインストールする場所
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- もしlazy.nvimがなければ、GitHubからcloneする
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- lazy.nvimの安定版を使う
    lazypath,
  })
end

-- 'lazy.nvim'をvimのruntimepathに追加して、読み込めるようにする
vim.opt.rtp:prepend(lazypath)

-- lazy.nvimのセットアップ
-- ここで、'lua/plugins'ディレクトリ以下にあるLuaファイル（プラグイン設定）を
-- 自動で読み込むように設定します。
require("lazy").setup("plugins", {
  -- パフォーマンス最適化設定
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- packpathをリセットして高速化
    rtp = {
      reset = true, -- runtimepathをリセット
      paths = {}, -- 追加のruntimeパス
      disabled_plugins = {
        -- 必要なプラグインは残す
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

