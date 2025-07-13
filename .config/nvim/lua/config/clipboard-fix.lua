-- OS別のクリップボード設定
local function setup_clipboard()
  local os_name = vim.loop.os_uname().sysname
  
  if os_name == "Darwin" then
    -- macOS: 明示的にpbcopy/pbpasteを使用
    vim.g.clipboard = {
      name = 'macOS-clipboard',
      copy = {
        ['+'] = 'pbcopy',
        ['*'] = 'pbcopy',
      },
      paste = {
        ['+'] = 'pbpaste',
        ['*'] = 'pbpaste',
      },
      cache_enabled = 0,
    }
  elseif os_name == "Linux" then
    -- Linux: xclipまたはxselを自動検出させる
    -- 特に設定しない場合、Neovimがxclip/xselを自動検出
    -- 必要に応じて明示的な設定を追加可能
  end
  
  -- 全OS共通: unnamedplusを有効にする
  vim.opt.clipboard:append('unnamedplus')
end

setup_clipboard()