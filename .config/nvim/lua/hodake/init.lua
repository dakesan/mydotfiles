local kmap = vim.keymap.set

kmap("n", "<leader>n", "<cmd>noh<cr>")
kmap("n", "<C-s>", ":w<cr>")
kmap("i", "<C-s>", "<Esc>:w<cr>i")

kmap("n", "<C-d>", "<C-d>zz")
kmap("n", "<C-u>", "<C-u>zz")


kmap("i", "<C-z>", "<Esc>ua")

-- レジスタを汚さないxやx
kmap({"n", "v"}, "s", '"_s')
kmap({"n", "v"}, "S", '"_S')
kmap({"n", "v"}, "x", '"_x')
kmap({"n", "v"}, "X", '"_X')
kmap({"n", "v"}, "c", '"_c')
kmap({"n", "v"}, "C", '"_C')

require("hodake.colorscheme")

