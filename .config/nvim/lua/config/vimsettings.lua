-- local utils = require('utils')
local cmd = vim.cmd
local indent = 2
vim.api.nvim_set_option('filetype', 'on')
vim.bo.expandtab = true
vim.bo.shiftwidth = indent
vim.bo.smartindent = true
vim.bo.tabstop = indent
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.scrolloff = 4
vim.o.shiftround = true
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.wildmode = 'list:longest'
vim.wo.number = true
vim.wo.relativenumber = true

-- vim.cmd [[let g:python3_host_prog = expand("${HOME}/.pyenv/shims/python")]]
-- vim.cmd [[let g:python_host_prog = expand("${HOME}/.pyenv/shims/python")]]
vim.cmd [[let g:loaded_python3_provider = 0]]

vim.o.mouse = "nvi"

vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

vim.cmd [[
    set clipboard&
    set clipboard^=unnamedplus
]]

vim.cmd "let g:python3_host_prog = '/home/oodake/mambaforge/envs/py310/bin/python3'"

vim.filetype.add {
    pattern = {
        ['.*%.ipynb.*'] = 'python',
        -- uses lua pattern matching
        -- rathen than naive matching
    },
}
