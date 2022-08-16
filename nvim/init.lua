
require('config.plugins')
require('config.colorscheme')
require('config.vimsettings')
require('config.keysettings')
require'config.quickscope'
-- local vim = vim
-- api.nvim_set_option('clipboard', 'unnamedplus')
-- vim.o.clipboard = "unnamedplus"

-- ctrl+s save on insertmode
vim.api.nvim_set_keymap("i", "<c-s>", "<esc>:w<cr>i", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-s>", ":w<cr>", { noremap = true })

-- quick-scopeをvscodeに反映させる
-- vim.cmd[[highlight quickscopeprimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline]]
-- vim.cmd[[highlight quickscopesecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline]]
-- vim.cmd[[ let g:qs_highlight_on_keys = ['f', 'f', 't', 't'] ]]

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
