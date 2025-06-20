return {
  -- Markdown Preview (external preview tool)
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

  -- Lightweight pattern highlighting
  {
    'echasnovski/mini.hipatterns',
    version = '*',
    ft = { 'markdown', 'text' },
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- Highlight TODO, FIXME, NOTE, etc.
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
          
          -- Highlight markdown headings with background
          heading1 = { pattern = '^# .*', group = 'MiniHipatternsHeading1' },
          heading2 = { pattern = '^## .*', group = 'MiniHipatternsHeading2' },
          heading3 = { pattern = '^### .*', group = 'MiniHipatternsHeading3' },
          
          -- Highlight markdown code blocks
          code_block = { pattern = '```.-```', group = 'MiniHipatternsCodeBlock' },
          
          -- Highlight hex color codes (useful in configs)
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
      
      -- Define custom highlight groups
      vim.cmd [[
        highlight MiniHipatternsFixme guibg=#ff6c6b guifg=#282828 gui=bold
        highlight MiniHipatternsHack guibg=#ff9f1a guifg=#282828 gui=bold
        highlight MiniHipatternsTodo guibg=#46d9ff guifg=#282828 gui=bold
        highlight MiniHipatternsNote guibg=#10b981 guifg=#282828 gui=bold
        
        highlight MiniHipatternsHeading1 guibg=#2e3440 gui=bold
        highlight MiniHipatternsHeading2 guibg=#3b4252
        highlight MiniHipatternsHeading3 guibg=#434c5e
        
        highlight MiniHipatternsCodeBlock guibg=#1e1e1e
      ]]
    end,
  },

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