return {
  -- プラグインの指定
  'ojroques/nvim-osc52',

  -- 即座に読み込む設定
  lazy = false,

  -- プラグイン読み込み後に実行する設定
  config = function()
    -- プラグイン自体のセットアップ
    require('osc52').setup({
      -- 通知を非表示にするなど、お好みで設定
      silent = false,
      ssh_only = false,
      tmux_passthrough = true,
    })

    -- ヤンク時にOSC52でクリップボードにも送信するオートコマンド
    vim.api.nvim_create_autocmd('TextYankPost', {
      callback = function()
        if vim.v.event.operator == 'y' then
          require('osc52').copy(table.concat(vim.v.event.regcontents, '\n'))
        end
      end,
    })
  end,
}
