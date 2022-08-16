if vim.fn.exists('g:vscode') == 0 then
    vim.api.nvim_set_option('termguicolors', true)
    vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
    vim.cmd [[colorscheme catppuccin]]
    vim.cmd 'syntax enable'
end

if vim.fn.exists('g:vscode') ~= 0 then
    vim.cmd 'set t_Co=0'
    vim.cmd 'syntax off'
    vim.cmd 'filetype off'
end

---Disables built in matchparen plugin
local function disable_builtin()
    vim.g.loaded_matchparen = 1
    if fn.exists(':NoMatchParen') ~= 0 then
        vim.api.nvim_command('NoMatchParen')
    end
end
