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

  -- Render markdown with custom configuration
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      -- Headings: hash symbols with background color
      heading = {
        enabled = true,
        sign = false,  -- サインカラムにアイコンを表示しない
        icons = { '# ', '## ', '### ', '#### ', '##### ', '###### ' },  -- hashをそのまま表示
        backgrounds = {
          'RenderMarkdownH1Bg',
          'RenderMarkdownH2Bg',
          'RenderMarkdownH3Bg',
          'RenderMarkdownH4Bg',
          'RenderMarkdownH5Bg',
          'RenderMarkdownH6Bg',
        },
      },

      -- Code blocks: background color only, no language icons
      code = {
        enabled = true,
        sign = false,
        style = 'full',  -- コードブロック全体に背景色
        left_pad = 2,
        right_pad = 2,
        width = 'block',
        border = 'thin',
      },

      -- Inline code: hide backticks, with background
      inline_code = {
        enabled = true,
      },

      -- Bullets: small icons by level
      bullet = {
        enabled = true,
        icons = { '•', '◦', '▪', '▫' },  -- 小さいアイコン
      },

      -- Checkboxes: default style
      checkbox = {
        enabled = true,
        unchecked = {
          icon = '󰄱 ',
          highlight = 'RenderMarkdownUnchecked',
        },
        checked = {
          icon = '󰱒 ',
          highlight = 'RenderMarkdownChecked',
        },
      },

      -- Quote: vertical line with background
      quote = {
        enabled = true,
        icon = '▎',
        highlight = 'RenderMarkdownQuote',
      },

      -- Tables: formatted with borders
      pipe_table = {
        enabled = true,
        style = 'full',
        border = {
          '┌', '┬', '┐',
          '├', '┼', '┤',
          '└', '┴', '┘',
          '│', '─',
        },
      },

      -- Links: icons and underline
      link = {
        enabled = true,
        icon = ' ',
        highlight = 'RenderMarkdownLink',
      },

      -- Horizontal rule: custom decoration
      dash = {
        enabled = true,
        icon = '─',
        width = 'full',
        highlight = 'RenderMarkdownDash',
      },

      -- Callouts: icon + title + background
      callout = {
        note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'RenderMarkdownInfo' },
        tip = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'RenderMarkdownSuccess' },
        important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint' },
        warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'RenderMarkdownWarn' },
        caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'RenderMarkdownError' },
        -- Obsidian specific callouts
        abstract = { raw = '[!ABSTRACT]', rendered = '󰨸 Abstract', highlight = 'RenderMarkdownInfo' },
        todo = { raw = '[!TODO]', rendered = '󰗡 Todo', highlight = 'RenderMarkdownInfo' },
        success = { raw = '[!SUCCESS]', rendered = '󰄬 Success', highlight = 'RenderMarkdownSuccess' },
        question = { raw = '[!QUESTION]', rendered = '󰘥 Question', highlight = 'RenderMarkdownWarn' },
        failure = { raw = '[!FAILURE]', rendered = '󰅖 Failure', highlight = 'RenderMarkdownError' },
        danger = { raw = '[!DANGER]', rendered = '󱐌 Danger', highlight = 'RenderMarkdownError' },
        bug = { raw = '[!BUG]', rendered = '󰨰 Bug', highlight = 'RenderMarkdownError' },
        example = { raw = '[!EXAMPLE]', rendered = '󰉹 Example', highlight = 'RenderMarkdownHint' },
        quote = { raw = '[!QUOTE]', rendered = '󱆨 Quote', highlight = 'RenderMarkdownQuote' },
      },
    },
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

  -- Obsidian vault integration
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = function()
      -- Load personal configuration if it exists
      local ok, personal = pcall(require, 'personal')
      local workspaces = {
        {
          name = "notes",
          path = "~/Documents/ObsidianVault",  -- Default fallback
        },
      }

      if ok and personal.obsidian and personal.obsidian.workspaces then
        workspaces = personal.obsidian.workspaces
      end

      return {
        workspaces = workspaces,

        -- Completion settings
        completion = {
          nvim_cmp = false,  -- nvim-cmpがインストールされていないので無効化
          min_chars = 2,
        },

        -- UI settings for Obsidian syntax
        -- render-markdown.nvimと併用するため一部機能を制限
        ui = {
          enable = true,
          update_debounce = 200,
          max_file_length = 5000,

          -- render-markdown.nvimに任せるのでcalloutは無効化
          -- checkboxes, bullets, external_linkなどのみ有効

          -- Checkboxes
          checkboxes = {
            [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
            ["x"] = { char = "", hl_group = "ObsidianDone" },
            [">"] = { char = "", hl_group = "ObsidianRightArrow" },
            ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
            ["!"] = { char = "", hl_group = "ObsidianImportant" },
          },

          -- Bullets
          bullets = { char = "•", hl_group = "ObsidianBullet" },
          external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
          reference_text = { hl_group = "ObsidianRefText" },

          -- Highlight syntax (==text==)
          highlight_text = { hl_group = "ObsidianHighlightText" },

          -- Tags
          tags = { hl_group = "ObsidianTag" },
          block_ids = { hl_group = "ObsidianBlockID" },

          -- Highlight groups
          hl_groups = {
            ObsidianTodo = { bold = true, fg = "#f78c6c" },
            ObsidianDone = { bold = true, fg = "#89ddff" },
            ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
            ObsidianTilde = { bold = true, fg = "#ff5370" },
            ObsidianImportant = { bold = true, fg = "#d73128" },
            ObsidianBullet = { bold = true, fg = "#80cbc4" },
            ObsidianRefText = { underline = true, fg = "#c792ea" },
            ObsidianExtLinkIcon = { fg = "#c792ea" },
            ObsidianTag = { italic = true, fg = "#89ddff" },
            ObsidianBlockID = { italic = true, fg = "#89ddff" },
            ObsidianHighlightText = { bg = "#75662e" },
          },
        },

        -- Note configuration
        note_id_func = function(title)
          local suffix = ""
          if title ~= nil then
            suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
          else
            for _ = 1, 4 do
              suffix = suffix .. string.char(math.random(65, 90))
            end
          end
          return tostring(os.time()) .. "-" .. suffix
        end,
      }
    end,

    keys = {
      { '<leader>on', '<cmd>ObsidianNew<cr>', desc = 'Obsidian New Note' },
      { '<leader>oo', '<cmd>ObsidianOpen<cr>', desc = 'Obsidian Open in App' },
      { '<leader>ob', '<cmd>ObsidianBacklinks<cr>', desc = 'Obsidian Backlinks' },
      { '<leader>ot', '<cmd>ObsidianTags<cr>', desc = 'Obsidian Tags' },
      { '<leader>os', '<cmd>ObsidianSearch<cr>', desc = 'Obsidian Search' },
      { '<leader>oq', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Obsidian Quick Switch' },
      { '<leader>ol', '<cmd>ObsidianLinks<cr>', desc = 'Obsidian Links' },
    },
  },
}