-- 基本設定を読み込み
require("settings")
require("keymaps")
require("config.clipboard-fix") -- macOS clipboard fix

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
      reset = true,        -- runtimepathをリセット
      paths = {},          -- 追加runtimeパス
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- clipboard 設定
vim.api.nvim_command('set t_BE=')
