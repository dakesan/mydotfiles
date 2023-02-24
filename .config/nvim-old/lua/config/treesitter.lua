local term = "vim.fn.exists('g:vscode') == 0"

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup {
    sync_install = false,
    autopairs = {
        enable = false,
        additional_vim_regex_highlighting = true,
    },
    highlight = {
        enable = (not vim.g.vscode),
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
    },
    rainbow = {
        enable = (not vim.g.vscode)
    },
    indent = { enable = true, disable = { "yaml" } },
    matchup = { enable = (not vim.g.vscode) },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',

                ['aC'] = '@class.outer',
                ['iC'] = '@class.inner',
                ['ak'] = '@class.outer',
                ['ik'] = '@class.inner',

                ['al'] = '@loop.outer',
                ['il'] = '@loop.inner',

                ['ac'] = '@conditional.outer',
                ['ic'] = '@conditional.inner',

                ['ie'] = '@call.inner',
                ['ae'] = '@call.outer',

                ['a<Leader>a'] = '@parameter.outer',
                ['i<Leader>a'] = '@parameter.inner',
                -- latex textobjects
                ['<LocalLeader>f'] = '@frame.outer',
                ['<LocalLeader>s'] = '@statement.outer',
                ['<LocalLeader>b'] = '@block.outer',
                ['<localLeader>c'] = '@class.outer',
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']f'] = '@function.outer',
                [']<Leader>c'] = '@class.outer',
                [']k'] = '@class.outer',
                [']l'] = '@loop.outer',
                [']c'] = '@conditional.outer',
                [']e'] = '@call.outer',
                [']a'] = '@parameter.outer',
                -- latex motions
                [']<LocalLeader>f'] = '@frame.outer',
                [']<LocalLeader>s'] = '@statement.outer',
                [']<LocalLeader>b'] = '@block.outer',
                [']<localLeader>c'] = '@class.outer',
            },

            goto_next_end = {
                [']F'] = '@function.outer',
                [']<Leader>C'] = '@class.outer',
                [']K'] = '@class.outer',
                [']L'] = '@loop.outer',
                [']C'] = '@conditional.outer',
                [']E'] = '@call.outer',
                [']A'] = '@parameter.outer',
                -- latex motions
                [']<LocalLeader>F'] = '@frame.outer',
                [']<LocalLeader>S'] = '@statement.outer',
                [']<LocalLeader>B'] = '@block.outer',
                [']<localLeader>C'] = '@class.outer',
            },

            goto_previous_start = {
                ['[f'] = '@function.outer',
                ['[<Leader>c'] = '@class.outer',
                ['[k'] = '@class.outer',
                ['[l'] = '@loop.outer',
                ['[c'] = '@conditional.outer',
                ['[e'] = '@call.outer',
                ['[a'] = '@parameter.outer',
                -- latex motions
                ['[<LocalLeader>f'] = '@frame.outer',
                ['[<LocalLeader>s'] = '@statement.outer',
                ['[<LocalLeader>b'] = '@block.outer',
                ['[<localLeader>c'] = '@class.outer',
            },

            goto_previous_end = {

                ['[F'] = '@function.outer',
                ['[<Leader>C'] = '@class.outer',
                ['[K'] = '@class.outer',
                ['[L'] = '@loop.outer',
                ['[C'] = '@conditional.outer',
                ['[E'] = '@call.outer',
                ['[A'] = '@parameter.outer',
                -- latex motions
                ['[<LocalLeader>F'] = '@frame.outer',
                ['[<LocalLeader>S'] = '@statement.outer',
                ['[<LocalLeader>B'] = '@block.outer',
                ['[<localLeader>C'] = '@class.outer',
            },
        },
    },
}

