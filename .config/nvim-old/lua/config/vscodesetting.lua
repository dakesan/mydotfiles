if (not vim.g.vscode) then
    -- New tab
    vim.api.nvim_set_keymap('n', 'te', ':tabedit<Return>', { silent = true })
    -- Move between window
    vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {})
    vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {})
    vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {})
    vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {})
end

if vim.g.vscode then
    vim.api.nvim_set_keymap('o', 'gc', '<Plug>VSCodeCommentary', {})
    vim.api.nvim_set_keymap('n', 'gc', '<Plug>VSCodeCommentary', {})
    vim.api.nvim_set_keymap('x', 'gc', '<Plug>VSCodeCommentary', {})
    vim.api.nvim_set_keymap('n', 'gcc', '<Plug>VSCodeCommentaryLine', {})
end
