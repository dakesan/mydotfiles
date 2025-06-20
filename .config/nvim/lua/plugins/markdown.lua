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

  -- DISABLED: render-markdown.nvim (performance issues with syntax files)
  --[[
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 
      'nvim-treesitter/nvim-treesitter', 
      'echasnovski/mini.nvim',
      'catppuccin/nvim', -- catppuccin統合のため追加
    },
    ft = { 'markdown' },
    keys = {
      { '<leader>mr', '<cmd>RenderMarkdown toggle<cr>', desc = 'Toggle Markdown Rendering' },
    },
    config = function()
      require('render-markdown').setup({
        enabled = true,
        max_file_size = 10.0,
        debounce = 100,
        render_modes = { 'n', 'c' },
        anti_conceal = {
          enabled = true,
        },
        heading = {
          enabled = true,
          sign = false,
          position = 'overlay',
          icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
          width = 'full',
          left_pad = 0,
          right_pad = 0,
          min_width = 0,
        },
        code = {
          enabled = true,
          sign = false,
          style = 'full',
          position = 'left',
          language_pad = 0,
          disable_background = { 'diff' },
          width = 'full',
          left_pad = 0,
          right_pad = 0,
          min_width = 0,
        },
        dash = {
          enabled = true,
          icon = '─',
          width = 'full',
        },
        bullet = {
          enabled = true,
          icons = { '●', '○', '◆', '◇' },
          left_pad = 0,
          right_pad = 0,
        },
        checkbox = {
          enabled = true,
          position = 'inline',
          unchecked = {
            icon = '󰄱 ',
          },
          checked = {
            icon = '󰱒 ',
          },
          custom = {
            todo = { raw = '[-]', rendered = '󰥔 ' },
          },
        },
        quote = {
          enabled = true,
          icon = '▋',
          repeat_linebreak = false,
        },
        pipe_table = {
          enabled = true,
          preset = 'none',
          style = 'full',
          cell = 'padded',
          min_width = 0,
          border = {
            '┌', '┬', '┐',
            '├', '┼', '┤',
            '└', '┴', '┘',
            '│', '─',
          },
          alignment_indicator = '━',
        },
        callout = {
          note = { raw = '[!NOTE]', rendered = '󰋽 Note' },
          tip = { raw = '[!TIP]', rendered = '󰌶 Tip' },
          important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important' },
          warning = { raw = '[!WARNING]', rendered = '󰀪 Warning' },
          caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution' },
        },
        link = {
          enabled = true,
          image = '󰥶 ',
          email = '󰀓 ',
          hyperlink = '󰌹 ',
        },
        sign = {
          enabled = false,
        },
        indent = {
          enabled = false,
          per_level = 2,
          skip_level = 1,
          skip_heading = false,
        },
      })
    end,
  },
  --]]

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