return {
  -- Markdown Preview
  {
    'iamcco/markdown-preview.nvim',
    run = function()
      vim.fn['mkdp#util#install']()
    end,
    ft = { 'markdown' },
    keys = {
      { '<leader>mp', '<Plug>MarkdownPreview', desc = 'Markdown Preview' },
      { '<leader>ms', '<Plug>MarkdownPreviewStop', desc = 'Markdown Preview Stop' },
      { '<leader>mt', '<Plug>MarkdownPreviewToggle', desc = 'Markdown Preview Toggle' },
    },
    config = function()
      -- プレビューの設定
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ''
      vim.g.mkdp_browser = ''
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ''
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {}
      }
      vim.g.mkdp_markdown_css = ''
      vim.g.mkdp_highlight_css = ''
      vim.g.mkdp_port = ''
      vim.g.mkdp_page_title = '「${name}」'
      vim.g.mkdp_filetypes = {'markdown'}
    end,
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  -- Enhanced Markdown Rendering
  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  --   ft = { 'markdown' },
  --   keys = {
  --     { '<leader>mr', '<cmd>RenderMarkdown toggle<cr>', desc = 'Toggle Markdown Rendering' },
  --   },
  --   config = function()
  --     require('render-markdown').setup({
  --       heading = {
  --         enabled = true,
  --         sign = true,
  --         position = 'overlay',
  --         icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
  --         signs = { 'RenderMarkdownH1', 'RenderMarkdownH2', 'RenderMarkdownH3', 'RenderMarkdownH4', 'RenderMarkdownH5', 'RenderMarkdownH6' },
  --         width = 'full',
  --         left_margin = 0,
  --         left_pad = 0,
  --         right_pad = 0,
  --         min_width = 0,
  --         border = false,
  --         border_prefix = false,
  --         above = '▄',
  --         below = '▀',
  --       },
  --       paragraph = {
  --         enabled = true,
  --         left_margin = 0,
  --         min_width = 0,
  --       },
  --       code = {
  --         enabled = true,
  --         sign = false,
  --         style = 'full',
  --         position = 'left',
  --         language_pad = 0,
  --         left_margin = 0,
  --         left_pad = 1,
  --         right_pad = 1,
  --         width = 'full',
  --         min_width = 0,
  --         border = 'thin',
  --         above = '',
  --         below = '',
  --         highlight = 'RenderMarkdownCode',
  --         highlight_inline = 'RenderMarkdownCodeInline',
  --       },
  --       dash = {
  --         enabled = true,
  --         icon = '─',
  --         width = 'full',
  --         highlight = 'RenderMarkdownDash',
  --       },
  --       bullet = {
  --         enabled = true,
  --         icons = { '●', '○', '◆', '◇' },
  --         left_pad = 0,
  --         right_pad = 0,
  --         highlight = 'RenderMarkdownBullet',
  --       },
  --       checkbox = {
  --         enabled = true,
  --         position = 'inline',
  --         unchecked = {
  --           icon = '󰄱 ',
  --           highlight = 'RenderMarkdownUnchecked',
  --         },
  --         checked = {
  --           icon = '󰱒 ',
  --           highlight = 'RenderMarkdownChecked',
  --         },
  --         custom = {
  --           todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo' },
  --         },
  --       },
  --       quote = {
  --         enabled = true,
  --         icon = '▋',
  --         repeat_linebreak = false,
  --         highlight = 'RenderMarkdownQuote',
  --       },
  --       pipe_table = {
  --         enabled = true,
  --         preset = 'none',
  --         style = 'full',
  --         cell = 'padded',
  --         min_width = 0,
  --         border = {
  --           '┌', '┬', '┐',
  --           '├', '┼', '┤',
  --           '└', '┴', '┘',
  --           '│', '─',
  --         },
  --         alignment_indicator = '━',
  --         head = 'RenderMarkdownTableHead',
  --         row = 'RenderMarkdownTableRow',
  --         filler = 'RenderMarkdownTableFill',
  --       },
  --       callout = {
  --         note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'RenderMarkdownInfo' },
  --         tip = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'RenderMarkdownSuccess' },
  --         important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint' },
  --         warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'RenderMarkdownWarn' },
  --         caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'RenderMarkdownError' },
  --       },
  --       link = {
  --         enabled = true,
  --         image = '󰥶 ',
  --         email = '󰀓 ',
  --         hyperlink = '󰌹 ',
  --         highlight = 'RenderMarkdownLink',
  --       },
  --       sign = {
  --         enabled = true,
  --         highlight = 'RenderMarkdownSign',
  --       },
  --       indent = {
  --         enabled = true,
  --         per_level = 2,
  --         skip_level = 1,
  --         skip_heading = false,
  --       },
  --     })
  --   end,
  -- },

  -- Auto bullet list completion
  {
    'gaoDean/autolist.nvim',
    ft = { 'markdown', 'text', 'tex', 'plaintex' },
    config = function()
      require('autolist').setup()
      
      -- キーマッピング設定
      vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
      vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
      vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
    end,
  },
}
