local utils = require('utils')

-- keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.api.nvim_set_keymap("n", "<leader>re", ":source ~/.config/nvim/init.lua", { noremap = true })

-- keymappings
vim.api.nvim_set_keymap('n', '<C-l>', '<cmd>noh<CR>', {noremap = true}) -- Clear highlights
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {noremap = true})           -- jk to escape
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>i", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true })

-- VSCode which key
-- vim.cmd [[nnoremap <space> <Cmd>call VSCodeNotify('whichkey.show')<CR>]]
-- substitute
vim.api.nvim_set_keymap("n", "<leader><leader>p", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><leader>P", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><leader>p", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
vim.api.nvim_set_keymap("x", "<leader><leader>p", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })

-- visual移動
vim.api.nvim_set_keymap("n", "j", 'gj', {noremap=false})
vim.api.nvim_set_keymap("n", "k", 'gk', {noremap=false})
vim.api.nvim_set_keymap("n", "<Down>", 'gj', {noremap=false})
vim.api.nvim_set_keymap("n", "<Up>", 'gk', {noremap=false})


-- レジスタを汚さないxやs
vim.api.nvim_set_keymap("n", "s", '"_s', {noremap=true})
vim.api.nvim_set_keymap("v", "s", '"_s', {noremap=true})
vim.api.nvim_set_keymap("n", "S", '"_S', {noremap=true})
vim.api.nvim_set_keymap("v", "S", '"_S', {noremap=true})
vim.api.nvim_set_keymap("n", "x", '"_x', {noremap=true})
vim.api.nvim_set_keymap("v", "x", '"_x', {noremap=true})
vim.api.nvim_set_keymap("n", "X", '"_X', {noremap=true})
vim.api.nvim_set_keymap("v", "X", '"_X', {noremap=true})
vim.api.nvim_set_keymap("n", "c", '"_c', {noremap=true})
vim.api.nvim_set_keymap("v", "c", '"_c', {noremap=true})
vim.api.nvim_set_keymap("n", "C", '"_C', {noremap=true})
vim.api.nvim_set_keymap("v", "C", '"_C', {noremap=true})


local opts = {noremap = false, silent = true}
vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
vim.api.nvim_set_keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
vim.api.nvim_set_keymap('n', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('n', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('n', '<leader><leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", {})
vim.api.nvim_set_keymap('v', '<leader><leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", {})
vim.api.nvim_set_keymap('o', '<leader><leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, inclusive_jump = true })<cr>", {})

vim.api.nvim_set_keymap('n', '<leader><leader>j', "<cmd>HopLineStartAC<cr>", {})
vim.api.nvim_set_keymap('v', '<leader><leader>j', "<cmd>HopLineStartAC<cr>", {})

vim.api.nvim_set_keymap('n', '<leader><leader>k', "<cmd>HopLineStartBC<cr>", {})
vim.api.nvim_set_keymap('v', '<leader><leader>k', "<cmd>HopLineStartBC<cr>", {})

vim.api.nvim_set_keymap('n', '<leader><leader>h', "<cmd>HopWordCurrentLineBC<cr>", {})
vim.api.nvim_set_keymap('v', '<leader><leader>h', "<cmd>HopWordCurrentLineBC<cr>", {})

vim.api.nvim_set_keymap('n', '<leader><leader>l', "<cmd>HopWordCurrentLineAC<cr>", {})
vim.api.nvim_set_keymap('v', '<leader><leader>l', "<cmd>HopWordCurrentLineAC<cr>", {})


vim.api.nvim_set_keymap('n', '<leader><leader>s', "<cmd>ISwap<cr>", {})
-- nvim tree

utils.map('n', '<C-n>', ':NvimTreeToggle<CR>')            -- open/close
utils.map('n', '<leader><leader>f', ':NvimTreeRefresh<CR>')       -- refresh
utils.map('n', '<leader><leader>n', ':NvimTreeFindFile<CR>')      -- search file

utils.map('n', '<leader><leader>g', ':bnext<CR>')       -- refresh
utils.map('n', '<leader><leader>G', ':bprevious<CR>')       -- refresh

-- Reload configuration without restart nvim
utils.map('n', '<leader><leader>r', ':so %<CR>')

-- terminal
utils.map('n', '<leader><leader>@', ':terminal<CR>')

-- window
-- Move around splits using Ctrl + {h,j,k,l}
utils.map('n', '<C-h>', '<C-w>h')
utils.map('n', '<C-j>', '<C-w>j')
utils.map('n', '<C-k>', '<C-w>k')
utils.map('n', '<C-l>', '<C-w>l')


-- move
vim.api.nvim_set_keymap('n', '<A-j>', ":MoveLine(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', ":MoveLine(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-j>', ":MoveBlock(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-k>', ":MoveBlock(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-l>', ":MoveHChar(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-h>', ":MoveHChar(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-l>', ":MoveHBlock(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-h>', ":MoveBlock(-1)<CR>", { noremap = true, silent = true })


-- treesitter unit
vim.api.nvim_set_keymap('x', 'iu', ':lua require"treesitter-unit".select()<CR>', {noremap=true})
vim.api.nvim_set_keymap('x', 'au', ':lua require"treesitter-unit".select(true)<CR>', {noremap=true})
vim.api.nvim_set_keymap('o', 'iu', ':<c-u>lua require"treesitter-unit".select()<CR>', {noremap=true})
vim.api.nvim_set_keymap('o', 'au', ':<c-u>lua require"treesitter-unit".select(true)<CR>', {noremap=true})

-- vim.api.nvim_set_keymap('o', 'm', ':<C-u>lua require("tsht").nodes()<CR>', {noremap=true})
-- vim.api.nvim_set_keymap('x', 'm', ':lua require("tsht").nodes()<CR>', {noremap=true})
