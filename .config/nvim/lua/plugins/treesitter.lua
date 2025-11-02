return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'VeryLazy' },  -- より遅延させる
  config = function()
    local configs = require('nvim-treesitter.configs')
    
    -- 大きなファイルでTreesitterを無効化
    vim.api.nvim_create_autocmd({ 'BufReadPre', 'FileReadPre' }, {
      callback = function()
        local max_filesize = 100 * 1024 -- 100KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
        if ok and stats and stats.size > max_filesize then
          vim.cmd('TSBufDisable highlight')
          vim.notify('Treesitter disabled for large file', vim.log.levels.INFO)
        end
      end,
    })
    
    -- 大きなファイルでTreesitterを無効化（パフォーマンス対策）
    vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
      callback = function()
        local line_count = vim.api.nvim_buf_line_count(0)
        -- Markdownファイルは1000行まで許可、他は500行まで
        local max_lines = vim.bo.filetype == 'markdown' and 1000 or 500
        if line_count > max_lines then
          vim.cmd('TSBufDisable highlight')
          vim.notify('Treesitter disabled for file with ' .. line_count .. ' lines', vim.log.levels.INFO)
        end
      end,
    })
    
    configs.setup({
      ensure_installed = {
        'lua',
        'vim',
        'vimdoc',
        'markdown',
        'markdown_inline',
        'python',
        'bash',
        'json',
        'yaml',
        'toml',
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        -- Obsidian構文のためにMarkdownでは追加のハイライトを有効化
        additional_vim_regex_highlighting = { 'markdown' },
        -- パフォーマンスのために無効化するファイルタイプ
        disable = function(lang, buf)
          -- 大きなファイルでは無効化
          local max_filesize = 100 * 1024 -- 100KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end

          -- 行数による無効化（Markdownは1000行、他は500行）
          local line_count = vim.api.nvim_buf_line_count(buf)
          local max_lines = lang == 'markdown' and 1000 or 500
          if line_count > max_lines then
            return true
          end

          return false
        end,
      },
      -- インデント機能は無効化（パフォーマンスのため）
      indent = {
        enable = false,
      },
      -- インクリメンタル選択も無効化
      incremental_selection = {
        enable = false,
      },
    })
  end,
}