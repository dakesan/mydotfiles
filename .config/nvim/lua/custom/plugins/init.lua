-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
local neotree_keymaps = {
  {
    '<leader>tt', '<cmd>Neotree toggle<cr>', desc = 'Toggle NeoTree'
  }
}

local term = vim.fn.exists('g:vscode') == 0

return {
  {
    "catppuccin/nvim", name = 'catppucin',
  },
  {
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
    event = "BufRead",
    keys = {
      {"<leader>mp", "<Plug>MarkdownPreview", desc = "Markdown Preview"}
    },
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end,
    cond = term
  },
  {
    'petertriho/nvim-scrollbar',
    config = function()
      local colors = require('catppuccin').setup()
      require('scrollbar').setup({
        handle = {color = '#CDD6F4'}
      })
    end,
    cond = term
  },
  {
    'kylechui/nvim-surround',
    event = "VeryLazy",
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
    end,
  },
  {
    'abecodes/tabout.nvim',
    config = function ()
      require('tabout').setup{
        tabkey = '<Tab>',
        backwards_tabkey = '<S-Tab>',
        act_as_tab = true,
      }
    end
  },
  {
    'chaoren/vim-wordmotion',
    enable = false,
    config = function ()
      vim.g.wordmotion_nomap = true
    end,
    keys = {
      {"<leader>aw", "<Plug>WordMotion_aw", desc = "Camel case motion[a]"},
      {"<leader>iw", "<Plug>WordMotion_iw", desc = "Camel case motion[i]"},
    }
  },
  {
    'bkad/CamelCaseMotion',
    keys = {
      {"<leader>aw", "<Plug>CamelCaseMotion_iw", desc = "Camel case motion[a]"},
      {"<leader>iw", "<Plug>CamelCaseMotion_aw", desc = "Camel case motion[i]"},
    }
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function ()
      require("hop").setup {
        keys = 'etovxqpdygfblzhckisuran'
      }
    end,
    keys = {
      {"<leader>e", "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", desc = "Hop hint words"},
      {"<leader>hj", "<cmd>HopLineStartAC<cr>", desc = "Hop down"},
      {"<leader>hk", "<cmd>HopLineStartBC<cr>", desc = "Hop up"},
      {"<leader>hl", "<cmd>HopWordCurrentLineAC<cr>", desc = "Hop right"},
      {"<leader>hh", "<cmd>HopWordCurrentLineBC<cr>", desc = "Hop left"},
      {"<leader>he", "<cmd>HopWordAC<cr>", desc = "Hop forward"},
      {"<leader>hb", "<cmd>HopWordBC<cr>", desc = "Hop backward"},
      {"<leader>hw", "<cmd>HopChar1<cr>", desc = "Hop one char"},
    }
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    config = function ()
      require('neo-tree').setup({
        close_if_last_window = true,
        window = {
          width = 30,
        }
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    setup = vim.cmd(
      [[ let g:neo_tree_remove_legacy_commands = 1 ]]
    ),
    keys = neotree_keymaps,
    cond = term
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function ()
      require('toggleterm').setup{ }
    end,
    keys = {
      {'<leader>;', "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal"}
    },
    cond = term
  },
  {
    'mrjones2014/nvim-ts-rainbow',
  },
  {
    'mechatroner/rainbow_csv'
  },
  {
    'gennaro-tedesco/nvim-possession',
    dependencies = { "ibhagwan/fzf-lua" },
    config = true,
    init = function()
      local possession = require("nvim-possession")
      vim.keymap.set("n", "<leader>ll", function()
        possession.list()
      end)
      vim.keymap.set("n", "<leader>ln", function()
        possession.new()
      end)
      vim.keymap.set("n", "<leader>lu", function()
        possession.update()
      end)
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function ()
      require("lspsaga").setup({})
    end,
    dependencies = {
      {"nvim-tree/nvim-web-devicons"}
    },
    keys = {
      {"<leader>rn", "<cmd>Lspsaga rename<cr>", "[R]e[n]ame"},
      {"K", "<cmd>Lspsaga hover_doc<cr>", "Hover documentation"},
      {"<leader>ca", "<cmd>Lspsaga code_action<cr>", "[C]ode [A]ction"},
      {"<leader>gd", "<cmd>Lspsaga goto_definition<cr>", "[G]oto [D]efinition"},
      {"<leader>gr", "<cmd>Lspsaga lsp_finder<cr>", "[G]oto [R]eference"},
      {"<leader>gt", "<cmd>Lspsaga goto_type_definition<cr>", "[G]oto [T]ype definition"},
      {"<leader>so", "<cmd>Lspsaga outline<cr>", "[S]how [O]utline"}
    }
  },
  {
    'onsails/lspkind-nvim',
    config = function ()
      require('lspkind').init({
        -- DEPRECATED (use mode instead): enables text annotations
        --
        -- default: true
        -- with_text = true,

        -- defines how annotations are shown
        -- default: symbol
        -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
        mode = 'symbol_text',

        -- default symbol map
        -- can be either 'default' (requires nerd-fonts font) or
        -- 'codicons' for codicon preset (requires vscode-codicons font)
        --
        -- default: 'default'
        preset = 'codicons',

        -- override preset symbols
        --
        -- default: {}
        symbol_map = {
          Text = "",
          Method = "",
          Function = "",
          Constructor = "",
          Field = "ﰠ",
          Variable = "",
          Class = "ﴯ",
          Interface = "",
          Module = "",
          Property = "ﰠ",
          Unit = "塞",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "פּ",
          Event = "",
          Operator = "",
          TypeParameter = ""
        },
      })
    end
  },
  -- {
  --   'jalvesaq/Nvim-R',
  --   ft = { "R", "r", "Rmd", "rmd", "qmd" },
  --   -- enabled = false,
  --   branch = "stable",
  --   config = function ()
  --     vim.cmd(
  --       [[ let R_external_term = 'radian']]
  --     )
  --   end
  -- }
}
