
vim.g.mapleader = "<Space>"
vim.g.maplocalleader = "<Space>"

options = {}

vim.api.nvim_set_keymap('n', '<Leader><Leader>j', "<cmd>HopLineStartAC<cr>", options)
vim.api.nvim_set_keymap('v', '<leader><leader>j', "<cmd>HopLineStartAC<cr>", options)

vim.api.nvim_set_keymap('n', '<leader>k', "<cmd>HopLineStartBC<cr>", options)
vim.api.nvim_set_keymap('v', '<leader>k', "<cmd>HopLineStartBC<cr>", options)

vim.api.nvim_set_keymap('n', '<leader>h', "<cmd>HopWordCurrentLineBC<cr>", options)
vim.api.nvim_set_keymap('v', '<leader>h', "<cmd>HopWordCurrentLineBC<cr>", options)

vim.api.nvim_set_keymap('n', '<leader>l', "<cmd>HopWordCurrentLineAC<cr>", options)
vim.api.nvim_set_keymap('v', '<leader>l', "<cmd>HopWordCurrentLineAC<cr>", options)

vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>HopWord<cr>', options)


local map = require('utils').map
map('n', '<leader>s', '<cmd>HopChar1<cr>')
