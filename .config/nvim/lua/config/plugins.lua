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

return require('packer').startup(function(use)
    local vscode = "vim.fn.exists('g:vscode') ~= 0"
    local term = "vim.fn.exists('g:vscode') == 0"
    use ({ 'wbthomason/packer.nvim' })
    use ({ 'nvim-lua/plenary.nvim' })
    use ({
        "windwp/nvim-autopairs",
        config = function ()
            require("nvim-autopairs").setup({ map_cr = false})
        end,
        cond = term
    })
    use ({
        'nvim-treesitter/nvim-treesitter' ,
        config = function ()
            require("config.treesitter")
        end,
        -- cond = term,
    })
    --
    use ({
        'David-Kunz/treesitter-unit',
        after = 'nvim-treesitter',
        cond = term,
    })
    --
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
    use ({
        "nvim-lualine/lualine.nvim",
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function ()
            require("config.lualine_setting")
        end,
        cond = term,
    })
    use ({
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
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
    -- use {
    --     'kyazdani42/nvim-tree.lua',
    --     requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    --     config = [[require('config.nvim_tree')]],
    --     cond = term
    -- }
    use {
        'chaoren/vim-wordmotion',
        config = function()
            vim.g.wordmotion_nomap = true,
            vim.keymap.set({ 'n', 'x', 'o' }, '<leader>w', '<Plug>WordMotion_w')
            -- vim.keymap.set({ 'n', 'x', 'o' }, 'W', '<Plug>WordMotion_W')
            vim.keymap.set({ 'n', 'x', 'o' }, '<leader>b', '<Plug>WordMotion_b')
            -- vim.keymap.set({ 'n', 'x', 'o' }, 'B', '<Plug>WordMotion_B')
            vim.keymap.set({ 'n', 'x', 'o' }, '<leader>e', '<Plug>WordMotion_e')
            -- vim.keymap.set({ 'n', 'x', 'o' }, 'F', '<Plug>WordMotion_E')
            -- vim.keymap.set({ 'n', 'x', 'o' }, 'gf', '<Plug>WordMotion_ge')
            -- vim.keymap.set({ 'n', 'x', 'o' }, 'gF', '<Plug>WordMotion_gE')
            vim.keymap.set({ 'x', 'o' }, '<leader>aw', '<Plug>WordMotion_aw')
            -- vim.keymap.set({ 'x', 'o' }, 'aW', '<Plug>WordMotion_aW')
            vim.keymap.set({ 'x', 'o' }, '<leader>iw', '<Plug>WordMotion_iw')
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
		cond = term
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
        config = function ()
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
        config = function ()
            require"bufferline".setup{}
        end,
    }
    use {
        'lewis6991/impatient.nvim',
        config = function ()
            require("config.impatient")
        end,
    }
    use {
        'akinsho/toggleterm.nvim',
        config = function ()
            require("config.toggleterm")
        end,
        cond = term,
    }
    use {
        'nguyenvukhang/nvim-toggler',
        config = function ()
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
        config = function ()
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
    -- -- -- lsp
  --   use ({
  --       "L3MON4D3/LuaSnip"
  --   })
  --   use ({
  --       'hrsh7th/nvim-cmp',
  --       requires = {
  --           { "L3MON4D3/LuaSnip", opt = true, event = "VimEnter" },
		-- 	{ "windwp/nvim-autopairs", opt = true, event = "VimEnter" },
  --       },
  --       after = { "LuaSnip", "nvim-autopairs" },
		-- config = function()
		-- 	require("config.nvim-cmp")
		-- end,
  --       cond = term
  --   })
 --    use({
	-- 	"onsails/lspkind-nvim",
	-- 	module = "lspkind",
	-- 	config = function()
	-- 		require("config.lspkind")
	-- 	end,
 --        cond = term
	-- })
    -- use {
    --     "neovim/nvim-lspconfig",
    --     cond = term,
    --     config = function ()
    --         local status, nvim_lsp = pcall(require, "lspconfig")
    --             if (not status) then return end
    --
    --         local protocol = require('vim.lsp.protocol')
    --
    --         local on_attach = function(client, bufnr)
    --           -- format on save
    --           if client.server_capabilities.documentFormattingProvider then
    --             vim.api.nvim_create_autocmd("BufWritePre", {
    --               group = vim.api.nvim_create_augroup("Format", { clear = true }),
    --               buffer = bufnr,
    --               callback = function() vim.lsp.buf.formatting_seq_sync() end
    --             })
    --           end
    --         end
    --
    --         local lsp_flags = {
    --             debounce_text_changes = 150,
    --         }
    --
    --         require'lspconfig'["pyright"].setup{
    --             on_attach = on_attach,
    --             flags = lsp_flags
    --         }
    --     end
    -- }
    -- use { 'onsails/lspkind-nvim', cond = term, }
    -- use { 'hrsh7th/cmp-buffer', cond = term, }
    -- use { 'hrsh7th/cmp-path', cond = term, }
    -- use { 'hrsh7th/cmp-nvim-lsp', cond = term, }
    -- use { 'hrsh7th/cmp-cmdline', cond = term }
    -- use { 'jose-elias-alvarez/null-ls.nvim', cond = term, }
    -- use { 'MunifTanjim/prettier.nvim', cond = term, }
    -- use { 'williamboman/mason.nvim', cond = term, }
    -- use { 'williamboman/mason-lspconfig.nvim', cond = term, }
    -- use { 'glepnir/lspsaga.nvim', cond = term, }
end)

