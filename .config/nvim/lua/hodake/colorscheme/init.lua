require("catppuccin").setup({
  flavour = "mocha",
  styles = {
    comments = {}
  },
  transparent_background = true,
  custom_highlights = function(colors)
        return {
            Comment = { fg = colors.flamingo },
            ["@constant.builtin"] = { fg = colors.peach, style = {} },
            ["@comment"] = { fg = colors.surface2, style = { "italic" } },
        }
    end
})

vim.cmd.colorscheme("catppuccin")

