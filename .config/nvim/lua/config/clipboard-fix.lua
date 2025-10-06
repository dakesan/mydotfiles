-- OS別のクリップボード設定
local function setup_clipboard()
  local os_name = vim.loop.os_uname().sysname

  if os_name == "Darwin" then
    -- iTerm2の検出
    local term_program = vim.env.TERM_PROGRAM
    
    if term_program == "iTerm.app" then
      -- iTerm2用の明示的な設定
      -- pbcopy/pbpasteをバッファ配列形式で指定
      vim.g.clipboard = {
        name = 'iTerm2-clipboard',
        copy = {
          ['+'] = { 'pbcopy' },
          ['*'] = { 'pbcopy' },
        },
        paste = {
          ['+'] = { 'pbpaste' },
          ['*'] = { 'pbpaste' },
        },
        cache_enabled = 0,  -- キャッシュを無効化
      }
    else
      -- Terminal.appや他のターミナル用のデフォルト設定
      -- Neovimが自動でpbcopy/pbpasteを検出
    end
  elseif os_name == "Linux" then
    -- Linux: xclipまたはxselを自動検出させる
  end

  -- 全OS共通: unnamedplusを有効にする
  vim.opt.clipboard = 'unnamedplus'
  
  -- iTerm2の場合、追加の設定
  if vim.env.TERM_PROGRAM == "iTerm.app" then
    -- 行単位のヤンクを改善するためのオートコマンド
    vim.api.nvim_create_autocmd("TextYankPost", {
      pattern = "*",
      callback = function()
        local event = vim.v.event
        if event.operator == 'y' and event.regtype == 'V' then
          -- 行単位のヤンクの場合、レジスタの内容を調整
          local reg_content = vim.fn.getreg(event.regname)
          if not reg_content:match('\n$') then
            vim.fn.setreg(event.regname, reg_content .. '\n', 'V')
          end
        end
      end
    })
  end
end

setup_clipboard()