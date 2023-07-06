local kmap = vim.keymap.set

kmap("n", "<leader>n", "<cmd>noh<cr>")
kmap("n", "<C-s>", ":w<cr>")
kmap("i", "<C-s>", "<Esc>:w<cr>a")

-- レジスタを汚さないxやx
kmap("n", "<leader><CR>", "a<CR><Esc>")

-- settings
vim.api.nvim_set_hl(0, "Comment", { italic = false })
