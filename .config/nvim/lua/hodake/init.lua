local kmap = vim.keymap.set

kmap("n", "<leader>n", "<cmd>noh<cr>")
kmap("n", "<C-s>", ":w<cr>")
kmap("i", "<C-s>", "<Esc>:w<cr>i")

kmap("n", "<C-d>", "<C-d>zz")
kmap("n", "<C-u>", "<C-u>zz")

kmap("n", "<leader><CR>", "a<CR><Esc>")
kmap("i", "<C-z>", "<Esc>ua")

-- レジスタを汚さないxやx
kmap({"n", "v"}, "s", '"_s')
kmap({"n", "v"}, "S", '"_S')
kmap({"n", "v"}, "x", '"_x')
kmap({"n", "v"}, "X", '"_X')
kmap({"n", "v"}, "c", '"_c')
kmap({"n", "v"}, "C", '"_C')

require("hodake.colorscheme")

local hlset = vim.api.nvim_set_hl

hlset(0, 'LineNr', {fg = '#FFFFFF'})
hlset(0, 'CursorLineNr', {fg = '#e5ff00'})

-- clipboard

-- if vim.fn.has("wsl") == 1 then
--   vim.cmd [[
--     set clipboard=unnamedplus
--     let g:clipboard = {
--           \   'name': 'myClipboard',
--           \   'copy': {
--           \      '+': 'win32yank.exe -i',
--           \      '*': 'win32yank.exe -i',
--           \    },
--           \   'paste': {
--           \      '+': 'win32yank.exe -o',
--           \      '*': 'win32yank.exe -o',
--           \   },
--           \   'cache_enabled': 0,
--           \ }
--
--   ]]
-- end

-- nextflow
vim.cmd('autocmd BufNewFile,BufRead *.nf set filetype=groovy')
