-- Leader key設定
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 基本設定
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'extend'
vim.opt.clipboard:append('unnamedplus')

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
  -- ここにオプションを記述できますが、まずは空でOK
})

