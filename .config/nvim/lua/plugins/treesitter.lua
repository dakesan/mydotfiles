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
    
    -- 500行以上のファイルでもTreesitterを無効化
    vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
      callback = function()
        local line_count = vim.api.nvim_buf_line_count(0)
        if line_count > 500 then
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
        -- vim syntaxを無効化（Markdownで特に重要）
        additional_vim_regex_highlighting = false,
        -- パフォーマンスのために無効化するファイルタイプ
        disable = function(lang, buf)
          -- 大きなファイルでは無効化
          local max_filesize = 100 * 1024 -- 100KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
          
          -- 500行以上のファイルでも無効化
          local line_count = vim.api.nvim_buf_line_count(buf)
          if line_count > 500 then
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