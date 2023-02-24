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

return {
  {
    "catppuccin/nvim", as = 'catppucin',
  },
  {
    'iamcco/markdown-preview.nvim',
    build = function() vim.fn['mkdp#util#install']() end
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end
  },
  {
    'petertriho/nvim-scrollbar',
    config = function()
      local colors = require('catppuccin').setup()
      require('scrollbar').setup({
        handle = {color = '#CDD6F4'}
      })
    end
  },
  {
    'kylechui/nvim-surround',
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
  },
  {
    'abecodes/tabout.nvim',
    config = function ()
      require('tabout').setup{
        tabkey = '<Tab>',
        backwards_tabkey = 'S-<Tab>',
        act_as_tab = true,
      }
    end
  },
  {
    'chaoren/vim-wordmotion',
    config = function ()
      vim.g.wordmotion_nomap = true
    end,
    keys = {
      {"<leader>aw", "<Plug>WordMotion_aw", desc = "Camel case motion[a]"},
      {"<leader>iw", "<Plug>WordMotion_iw", desc = "Camel case motion[i]"},
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
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    setup = vim.cmd(
      [[ let g:neo_tree_remove_legacy_commands = 1 ]]
    ),
    keys = neotree_keymaps,
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function ()
      require('toggleterm').setup{ }
    end,
    keys = {
      '<leader>;', "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal"
    },
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
    end,}
}
