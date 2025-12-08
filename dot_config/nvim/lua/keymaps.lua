-- Keymaps
-- clipboard is already set in settings.lua (vim.opt.clipboard = 'unnamedplus')

-- Save with Command+S (works in GUI Neovim like Neovide)
vim.keymap.set({ 'n', 'i', 'v' }, '<D-s>', '<Cmd>w<CR>', { desc = 'Save file' })
