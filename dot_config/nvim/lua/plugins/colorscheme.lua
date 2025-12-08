return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        background = {
          light = "latte",
          dark = "macchiato",
        },
        transparent_background = true,
        show_end_of_buffer = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
        },
        color_overrides = {},
        custom_highlights = function(colors)
          return {
            -- Line number colors (cyan for visibility on transparent background)
            LineNr = { fg = "#56b6c2" },           -- Non-current line numbers
            CursorLineNr = { fg = "#00ffff", bold = true },  -- Current line number (brighter cyan)
          }
        end,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          -- render-markdown統合を有効化
          render_markdown = true,
        },
      })
      
      -- カラースキームを適用
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}