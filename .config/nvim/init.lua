
require('config.plugins')
require('config.autopairs')
-- require('config.treesitter')
require('config.gitsigns')
require('config.colorscheme')
require('config.vimsettings')
require('config.keysettings')
require('config.vscodesetting')
-- local vim = vim
-- api.nvim_set_option('clipboard', 'unnamedplus')
-- vim.o.clipboard = "unnamedplus"

-- ctrl+s save on insertmode
vim.api.nvim_set_keymap("i", "<c-s>", "<esc>:w<cr>i", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-s>", ":w<cr>", { noremap = true })
-- vim.api.nvim_set_keymap("i", "<c-d><c-d>", ":q<cr>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<c-d><c-d>", ":q<cr>", { noremap = true })

-- if vim.fn.exists('g:vscode') == 0 then
--     require('config.lsp-settings')
-- end

vim.cmd[[
    let g:clipboard = {
        \   'name': 'win32yank-wsl',
        \   'copy': {
        \      '+': 'clip.exe',
        \      '*': 'clip.exe',
        \    },
        \   'cache_enabled': 0,
        \ }
]]

vim.cmd[[
    if system('uname -a | grep microsoft') != ''
  augroup myYank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe', @")
  augroup END
endif"
]]


