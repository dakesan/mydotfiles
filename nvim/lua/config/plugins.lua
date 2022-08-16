local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end

local nocode = function()
    return vim.fn.exists('g:vscode') == 0
end
local utils = require('utils')

require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    local vscode = "vim.fn.exists('g:vscode') ~= 0"
    local term = "vim.fn.exists('g:vscode') == 0"

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require 'nvim-treesitter.configs'.setup {
                highlight = {
                    enable = false,
                    additional_vim_regex_highlighting = false
                },
                indent = {
                    enable = true
                },
                matchup = {
                    enable = true
                }
            }
        end
    }
    use({
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup()
        end,
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        cond = term,
    })
    use({
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })
    use {
        'unblevable/quick-scope',
        setup = [[require('config.quickscope')]],
        keys = { 'f', 'F', 't', 'T' }
    }
    -- use {"tpope/vim-bommentary"}
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end,
        cond = term
    }
    -- use {'rhysd/clever-f.vim'}
    -- use {"haya14busa/vim-edgemotion"}
    -- use {"yutkat/wb-only-current-line.vim"}
    use { "kana/vim-niceblock" }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        tag = 'nightly',
        config = [[require('config.nvim_tree')]],
        cond = term
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
    -- vim-expand-region
    -- +で拡大, _で縮小
    use { "terryma/vim-expand-region" }

    -- substitute.nvim
    -- yiw->gs"などで　ヤンク->置換
    use({
        "gbprod/substitute.nvim",
        config = function()
            require("substitute").setup({
                on_substitute = nil,
                yank_substitued_text = false,
                range = {
                    prefix = "s",
                    prompt_current_text = false,
                    confirm = false,
                    complete_word = false,
                    motion1 = false,
                    motion2 = false
                },
                exchange = {
                    motion = false
                }
            })
        end
    })

    -- Lazy loading:
    -- Load on specific commands
    use {
        'tpope/vim-dispatch',
        opt = true,
        cmd = { 'Dispatch', 'Make', 'Focus', 'Start' }
    }

    -- use {
    --     'ojroques/nvim-osc52'
    -- }

    -- Plugins can have post-install/update hooks
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

    -- move
    use {
        'fedepujol/move.nvim',
        cond = term
    }

    use {
        'catppuccin/nvim',
        as = 'catppucin'
    }

    use { 'David-Kunz/treesitter-unit' }

    use {
        'mfussenegger/nvim-treehopper',
        after = 'nvim-treesitter',
        config = function()
            vim.cmd([[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]])
            vim.cmd([[vnoremap <silent> m :lua require('tsht').nodes()<CR>]])
            require('tsht').config.hint_keys = { 'j', 'k', 'l', 'f', 'd', 's', 'h', 'g', 'm' }
        end
    }

    use { 'mizlan/iswap.nvim' }

    use { 'gpanders/editorconfig.nvim' }
    -- use {'editorconfig/editorconfig-vim'}

    use { 'goerz/jupytext.vim' }

    use {
        'akinsho/nvim-bufferline.lua',
        cond = term,
        config = function ()
            require"bufferline".setup{}
        end
    }
    --   use {
    --    'bkad/CamelCaseMotion',
    --    setup = function()
    --     vim.cmd[[let g:camelcasemotion_key = '<leader>']]
    -- end,
    --   }

    -- -- lsp
    use {
        "neovim/nvim-lspconfig",
        cond = term,
        config = function ()
            local status, nvim_lsp = pcall(require, "lspconfig")
            if (not status) then return end

            local protocol = require('vim.lsp.protocol')

            local on_attach = function(client, bufnr)
                -- format on save
                if client.server_capabilities.documentFormattingProvider then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = vim.api.nvim_create_augroup("Format", { clear = true }),
                        buffer = bufnr,
                        callback = function() vim.lsp.buf.formatting_seq_sync() end
                    })
                end
            end

            local lsp_flags = {
                debounce_text_changes = 150,
            }

            require'lspconfig'["pyright"].setup{
                on_attach = on_attach,
                flags = lsp_flags
            }
        end
    }
    use { 'onsails/lspkind-nvim', cond = term, }
    use { 'hrsh7th/cmp-buffer', cond = term, }
    use { 'hrsh7th/cmp-path', cond = term, }
    use { 'hrsh7th/cmp-nvim-lsp', cond = term, }
    use { 'hrsh7th/cmp-cmdline', cond = term }
    use { 'hrsh7th/nvim-cmp' }
    use { 'jose-elias-alvarez/null-ls.nvim', cond = term, }
    use { 'MunifTanjim/prettier.nvim', cond = term, }
    use { 'williamboman/mason.nvim', cond = term, }
    use { 'williamboman/mason-lspconfig.nvim', cond = term, }
    use { 'glepnir/lspsaga.nvim', cond = term, }

    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }
end)

require('Comment').setup()
require('config.quickscope')
-- require('config.osc52')
require('config.lualine_setting')
require('config.lspsettings')
require('config.bufferline_settings')
