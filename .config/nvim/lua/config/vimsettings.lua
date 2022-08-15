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

vim.o.mouse = "nvi"

-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

vim.cmd [[
    set clipboard&
    set clipboard^=unnamedplus
]]

vim.cmd "let g:python3_host_prog = '/home/oodake/miniconda3/envs/py310/bin/python3'"