local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    }
    print "Installing packer and reopening Neovim!!"
    vim.cmd [[packadd packer.nvim]]
end

-- Automatically reload packer whenwver I save this plugins.lua file.
vim.cmd [[
    augroup pakcer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Check if packer is installed
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Check if we are now in VSCode
local utils = require('utils')
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

return require('packer').startup(
    function(use)
        local vscode = "vim.fn.exists('g:vscode') ~= 0"
        local term = "vim.fn.exists('g:vscode') == 0"
        use({ 'wbthomason/packer.nvim' })
        use({ 'nvim-lua/plenary.nvim' })
        use({
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup({})
            end,
            cond = term
        })
        use({
            "petertriho/nvim-scrollbar",
            config = function()
                local colors = require("catppuccin").setup()
                require("scrollbar").setup({
                    handle = {
                        color = "#CDD6F4",
                    }
                })
            end,
            cond = term
        })
        use({
            'rmagatti/auto-session',
            config = function()
                require("auto-session").setup {
                    log_level = "error",
                    auto_session_suppress_dirs = { "/" }
                }
                -- vim.keymap.set({ 'n', 'x', 'o' }, 'W', '<Plug>WordMotion_W')
            end,
            cond = term
        })
        use({
            'nvim-treesitter/nvim-treesitter',
            config = function()
                require("config.treesitter")
            end,
        })
        use({
            'nvim-treesitter/playground',
            config = function()
                require "nvim-treesitter.configs".setup {
                    playground = {
                        enable = true,
                        disable = {},
                        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                        persist_queries = false, -- Whether the query persists across vim sessions
                        keybindings = {
                            toggle_query_editor = 'o',
                            toggle_hl_groups = 'i',
                            toggle_injected_languages = 't',
                            toggle_anonymous_nodes = 'a',
                            toggle_language_display = 'I',
                            focus_language = 'f',
                            unfocus_language = 'F',
                            update = 'R',
                            goto_node = '<cr>',
                            show_help = '?',
                        },
                    }
                }
            end,
            cond = term
        })
        use({
            'nvim-treesitter/nvim-treesitter-textobjects',
            config = function()
                require'nvim-treesitter.configs'.setup {
                    textobjects = {
                        select = {
                            enable = true,

                            -- Automatically jump forward to textobj, similar to targets.vim
                            lookahead = true,

                            keymaps = {
                                -- You can use the capture groups defined in textobjects.scm
                                ["af"] = "@function.outer",
                                ["if"] = "@function.inner",
                                ["ac"] = "@class.outer",
                                -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
                                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            },
                            -- You can choose the select mode (default is charwise 'v')
                            selection_modes = {
                                ['@parameter.outer'] = 'v', -- charwise
                                ['@function.outer'] = 'V', -- linewise
                                ['@class.outer'] = '<c-v>', -- blockwise
                            },
                            -- If you set this to `true` (default is `false`) then any textobject is
                            -- extended to include preceding xor succeeding whitespace. Succeeding
                            -- whitespace has priority in order to act similarly to eg the built-in
                            -- `ap`.
                            include_surrounding_whitespace = true,
                        },
                    },
                }
            end
        })
        -- use({
        --     'David-Kunz/treesitter-unit',
        --     after = 'nvim-treesitter',
        --     cond = term,
        -- })
        use {
            'mfussenegger/nvim-treehopper',
            after = 'nvim-treesitter',
            config = function()
                vim.cmd([[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]])
                vim.cmd([[vnoremap <silent> m :lua require('tsht').nodes()<CR>]])
                require('tsht').config.hint_keys = { 'j', 'k', 'l', 'f', 'd', 's', 'h', 'g', 'm' }
            end,
            cond = term
        }
        use({
            "nvim-lualine/lualine.nvim",
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            config = function()
                require("config.lualine_setting")
            end,
            cond = term,
        })
        use({
            "kylechui/nvim-surround",
            config = function()
                require("nvim-surround").setup({
                    keymaps = {
                        insert = "<C-g>s",
                        insert_line = "<C-g>S",
                        normal = "sa",
                        normal_cur = "yss",
                        normal_line = "yS",
                        normal_cur_line = "ySS",
                        visual = "s",
                        visual_line = "gS",
                        delete = "ds",
                        change = "cs",
                    }
                })
            end
        })
        -- use ({
        --     'unblevable/quick-scope',
        --     config = function ()
        --         require("config.quickscope")
        --     end,
        --     keys = { 'f', 'F', 't', 'T' }
        -- })
        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end,
            -- cond = term
        }
        -- use {"yutkat/wb-only-current-line.vim"}
        -- use { "kana/vim-niceblock" }
        use {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            config = function()
                require("config.neo-tree")
            end,
            requires = {
                "nvim-lua/plenary.nvim",
                "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
            },
            setup = vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]]),
            cond = term
        }
        use ({
            "nvim-telescope/telescope.nvim", tag = "0.1.0",
            config = function()
                require("telescope").setup{
                    pickers = {
                        live_grep = {
                            glob_pattern = "!.git/",
                            additional_args = function(opts)
                                return {"--hidden"}
                            end
                        }
                    }
                }
                vim.keymap.set(
                    { 'n' }, '<C-p>',
                    "<cmd>Telescope live_grep<cr>"
                    )
            end
        })
        use {
            'chaoren/vim-wordmotion',
            config = function()
                vim.g.wordmotion_nomap = true,
                -- vim.keymap.set({ 'n', 'x', 'o' }, '<leader>w', '<Plug>WordMotion_w')
                -- vim.keymap.set({ 'n', 'x', 'o' }, 'W', '<Plug>WordMotion_W')
                -- vim.keymap.set({ 'n', 'x', 'o' }, '<leader>b', '<Plug>WordMotion_b')
                -- vim.keymap.set({ 'n', 'x', 'o' }, 'B', '<Plug>WordMotion_B')
                -- vim.keymap.set({ 'n', 'x', 'o' }, '<leader>e', '<Plug>WordMotion_e')
                -- vim.keymap.set({ 'n', 'x', 'o' }, 'F', '<Plug>WordMotion_E')
                -- vim.keymap.set({ 'n', 'x', 'o' }, 'gf', '<Plug>WordMotion_ge')
                -- vim.keymap.set({ 'n', 'x', 'o' }, 'gF', '<Plug>WordMotion_gE')
                vim.keymap.set({ 'n', 'x', 'o' }, '<leader>aw', '<Plug>WordMotion_aw')
                -- vim.keymap.set({ 'x', 'o' }, 'aW', '<Plug>WordMotion_aW')
                vim.keymap.set({ 'n', 'x', 'o' }, '<leader>iw', '<Plug>WordMotion_iw')
                -- vim.keymap.set({ 'x', 'o' }, 'iW', '<Plug>WordMotion_iW')
            end
        }
        use {
            'phaazon/hop.nvim',
            branch = 'v2', -- optional but strongly recommended
            config = function()
                -- you can configure Hop the way you like here; see :h hop-config
                require 'hop'.setup {
                    keys = 'etovxqpdygfblzhckisuran'
                }
            end
        }
        use { "lewis6991/gitsigns.nvim",
            cond = term,
            config = function()
                require('gitsigns').setup()
            end
        }
        -- -- vim-expand-region
        -- -- +で拡大, _で縮小
        -- use { "terryma/vim-expand-region" }
        --
        -- -- substitute.nvim
        -- -- yiw->gs"などで　ヤンク->置換
        -- use({
        --     "gbprod/substitute.nvim",
        --     config = function()
        --         require("substitute").setup({ })
        --     end
        -- })
        --
        -- -- use {
        -- --     'ojroques/nvim-osc52'
        -- -- }
        --
        -- -- Plugins can have post-install/update hooks
        use {
            'iamcco/markdown-preview.nvim',
            run = 'cd app && yarn install',
            cmd = 'MarkdownPreview',
            setup = function()
                vim.g.mkdp_filetypes = { "markdown" }
            end,
            ft = { "markdown" },
            cond = term
        }
        --
        -- -- move
        use {
            'fedepujol/move.nvim',
        }
        --
        use { 'catppuccin/nvim', as = 'catppucin' }
        --
        use { 'mizlan/iswap.nvim' }
        --
        use { 'gpanders/editorconfig.nvim' }
        --
        use {
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                require("indent_blankline").setup {
                    -- for example, context is off by default, use this to turn it on
                    show_current_context = true,
                    show_current_context_start = true,
                    show_end_of_line = true,
                    char_highlight_list = {
                        "IndentBlanklineIndent1",
                        "IndentBlanklineIndent2",
                        "IndentBlanklineIndent3",
                        "IndentBlanklineIndent4",
                        "IndentBlanklineIndent5",
                        "IndentBlanklineIndent6",
                    },
                }
            end
        }
        use { 'goerz/jupytext.vim' }
        --
        use {
            'akinsho/nvim-bufferline.lua',
            cond = term,
            config = function()
                require "bufferline".setup {}
            end,
        }
        use {
            'lewis6991/impatient.nvim',
            config = function()
                require("config.impatient")
            end,
        }
        use {
            'akinsho/toggleterm.nvim',
            config = function()
                require("config.toggleterm")
            end,
            cond = term,
        }
        use {
            'nguyenvukhang/nvim-toggler',
            config = function()
                require('nvim-toggler').setup({
                    inverses = {
                        ['True'] = 'False',
                        ['TRUE'] = 'FALSE',
                        ['!='] = '==',
                    },
                    -- remove_default_keybinds = true,
                })
                -- vim.keymap.set(
                --     {'n', 'v'}, '<leader>cl',
                --     require('nvim-toggler').toggle
                --     )
            end
        }
        -- use {
        --     'Decodetalkers/csv-tools.lua',
        --     config = function ()
        --         require("csvtools").setup({
        --             before = 10,
        --             after = 10,
        --             clearafter = true,
        --             showoverflow = true,
        --             titleflow = true
        --         })
        --     end
        -- }
        use {
            'mechatroner/rainbow_csv',
            -- ft = {'csv', 'tsv'}
        }
        use {
            'xiyaowong/nvim-transparent',
            config = function()
                require("transparent").setup({
                    enable = true, -- boolean: enable transparent
                    extra_groups = { -- table/string: additional groups that should be cleared
                        -- In particular, when you set it to 'all', that means all available groups

                        -- example of akinsho/nvim-bufferline.lua
                        "BufferLineTabClose",
                        "BufferlineBufferSelected",
                        "BufferLineFill",
                        "BufferLineBackground",
                        "BufferLineSeparator",
                        "BufferLineIndicatorSelected",
                    },
                    exclude = {}, -- table: groups you don't want to clear
                })
            end
        }
        -- lsp
        use({
            "neovim/nvim-lspconfig",
            cond = term,
            -- config = require("config.lsp-settings"),
            config = function()
                vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
                )
                -- 2. build-in LSP function
                -- keyboard shortcut
                vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {})
                vim.api.nvim_set_keymap('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', {})
                vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {})
                vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {})
                vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {})
                vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {})
                vim.api.nvim_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {})
                vim.api.nvim_set_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', {})
                vim.api.nvim_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', {})
                vim.api.nvim_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', {})
                vim.api.nvim_set_keymap('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>', {})
                vim.api.nvim_set_keymap('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {})
                -- LSP handlers

                vim.cmd [[
set updatetime=500
highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
augroup lsp_document_highlight
  autocmd!
  autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
  autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
augroup END
]]

            end
        })
        use({
            "williamboman/mason.nvim",
            cond = term,
            config = function()
                require("mason").setup()
            end
        })
        use({
            "williamboman/mason-lspconfig.nvim",
            cond = term,
            config = function()
                require("mason-lspconfig").setup_handlers({
                    function(server)
                        local opt = {
                            on_attach = function(client, bufnr)
                                local opts = { noremap = true, silent = true }
                                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                                vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
                            end,
                            capabilities = require("cmp_nvim_lsp").update_capabilities(
                                vim.lsp.protocol.make_client_capabilities()
                            )
                        }
                        require("lspconfig")[server].setup(opt)
                    end
                })
            end
        })
        use({
            "hrsh7th/nvim-cmp",
            cond = term,
            config = function()
                local cmp = require("cmp")
                cmp.setup({
                    snippet = {
                        expand = function(args)
                            vim.fn["vsnip#anonymous"](args.body)
                        end,
                    },
                    sources = {
                        { name = "nvim_lsp" },
                        { name = "buffer" },
                        { name = "path" },
                    },
                    mapping = cmp.mapping.preset.insert({
                        ["<C-p>"] = cmp.mapping.select_prev_item(),
                        ["<C-n>"] = cmp.mapping.select_next_item(),
                        ['<C-l>'] = cmp.mapping.complete(),
                        ['<C-e>'] = cmp.mapping.abort(),
                        ["<CR>"] = cmp.mapping.confirm { select = true },
                    }),
                    experimental = {
                        ghost_text = true,
                    },
                })
                cmp.setup.cmdline('/', {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        { name = 'b}uffer' }
                    }
                })
                cmp.setup.cmdline(":", {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        { name = "path" },
                        { name = "cmdline" },
                    },
                })
            end
        })
        use({
            "hrsh7th/cmp-nvim-lsp",
            cond = term,
        })
        use({
            "hrsh7th/vim-vsnip",
            cond = term,
        })
        use({
            "hrsh7th/cmp-path",
            cond = term,
        })
        use({
            "hrsh7th/cmp-buffer",
            cond = term,
        })
        use({
            "hrsh7th/cmp-cmdline",
            cond = term,
        })
    end)
