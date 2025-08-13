local function setup_clipboard_on_demand()
  -- まだ設定されていなければ設定する
  local clipboard = vim.opt.clipboard:get()
  if not vim.tbl_contains(clipboard, "unnamedplus") then
    vim.opt.clipboard:append('unnamedplus')
    vim.notify("Clipboard 'unnamedplus' has been enabled.", vim.log.levels.INFO, { title = "On-Demand Setup" })
  end
end

-- ヤンクやペーストのキーマッピングにフックする
-- ノーマルモードでのヤンク
vim.keymap.set('n', 'y', function()
  setup_clipboard_on_demand()
  return 'y' -- 元の 'y' の動作を継続
end, { expr = true, noremap = true })

-- -- ノーマルモードでのペースト
-- vim.keymap.set('n', 'p', function()
--   setup_clipboard_on_demand()
--   return 'p'
-- end, { expr = true, noremap = true })
--
-- vim.keymap.set('n', 'P', function()
--   setup_clipboard_on_demand()
--   return 'P'
-- end, { expr = true, noremap = true })

-- ビジュアルモードでのヤンク・ペーストも同様に設定
vim.keymap.set('v', 'y', function()
  setup_clipboard_on_demand()
  return 'y'
end, { expr = true, noremap = true })
--
-- vim.keymap.set('v', 'p', function()
--   setup_clipboard_on_demand()
--   return 'p'
-- end, { expr = true, noremap = true })
