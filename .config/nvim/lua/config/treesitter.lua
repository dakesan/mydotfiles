local term = "vim.fn.exists('g:vscode') == 0"

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

if term then
    configs.setup {
        sync_install = false,
        ignore_install = { "" },
        autopairs = {
            enable = false,
            additional_vim_regex_highlighting = true,
        },
        highlight = {
            enable = true, -- false will disable the whole extension
            disable = { "" }, -- list of language that will be disabled
            additional_vim_regex_highlighting = true,
        },
        indent = { enable = true, disable = { "yaml" } },
        matchup = { enable = true },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
    }
else
    configs.setup {
        sync_install = false,
        ignore_install = { "" },
        autopairs = {
            enable = false,
            additional_vim_regex_highlighting = false,
        },
        highlight = {
            enable = false,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = false, disable = { "yaml" } },
        matchup = { enable = false },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
    }
end

