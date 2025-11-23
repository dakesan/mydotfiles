local lfs = require("lfs")

-- エラーメッセージ通知用関数
local function notify_error(message, urgency)
  ya.notify({
    title = "rmv",
    content = message,
    level = urgency,
    timeout = 5,
  })
end

-- 現在選択中（またはホバー中）の項目のパスを取得する
local function get_selected_path()
  local tab = cx.active
  if #tab.selected > 0 then
    ya.dbg("Selected item found")
    return tostring(tab.selected[1].url)
  elseif tab.current.hovered then
    ya.dbg("Hovered item found")
    return tostring(tab.current.hovered.url)
  else
    ya.dbg("No selection or hover detected")
    return nil
  end
end

-- 指定パスがディレクトリかどうか判定
local function is_dir(path)
  local attr = lfs.attributes(path)
  return attr and attr.mode == "directory"
end

return {
  entry = function(self, job)
    ya.dbg("rmvプラグインエントリが呼ばれました")
    local args = job.args
    local op = args[1]
    if not op then
      ya.err("No operation specified. Use 'rm' or 'mv'")
      return
    end

    local path = get_selected_path()
    if not path then
      ya.err("No file or directory selected")
      return
    end

    if op == "rm" then
      ya.dbg("rm操作開始: " .. path)
      local input, event = ya.input({
        title = "Remove " .. path .. "? (y/N)",
        position = {"top-center", y = 3, w = 40},
      })
      if event ~= 1 or input:lower() ~= "y" then
        ya.dbg("削除操作キャンセル")
        ya.notify({
          title = "rmv",
          content = "Operation cancelled",
          level = "warn",
          timeout = 5,
        })
        return
      end

      local ok, err
      if is_dir(path) then
        ya.dbg("ディレクトリ削除実行")
        ok, err = os.execute("rm -rf " .. path)
      else
        ya.dbg("ファイル削除実行")
        ok, err = os.remove(path)
      end

      if not ok then
        notify_error("Failed to remove " .. path .. ": " .. tostring(err), "error")
      else
        ya.dbg("削除完了")
        ya.notify({
          title = "rmv",
          content = "Removed: " .. path,
          level = "info",
          timeout = 5,
        })
      end

    elseif op == "mv" then
      ya.dbg("mv操作開始: " .. path)
      local dest = args[2]
      if not dest then
        dest, event = ya.input({
          title = "Enter destination path:",
          position = {"top-center", y = 3, w = 40},
        })
        ya.dbg("ユーザー入力で移動先: " .. tostring(dest))
        if event ~= 1 or dest == "" then
          ya.dbg("移動先入力無効")
          ya.notify({
            title = "rmv",
            content = "No destination provided. Operation cancelled.",
            level = "warn",
            timeout = 5,
          })
          return
        end
      end

      local input, event = ya.input({
        title = "Move " .. path .. " to " .. dest .. "? (y/N)",
        position = {"top-center", y = 3, w = 40},
      })
      if event ~= 1 or input:lower() ~= "y" then
        ya.dbg("mv操作キャンセル")
        ya.notify({
          title = "rmv",
          content = "Operation cancelled",
          level = "warn",
          timeout = 5,
        })
        return
      end

      ya.dbg("os.rename実行")
      local ok, err = os.rename(path, dest)
      if not ok then
        notify_error("Failed to move " .. path .. " to " .. dest .. ": " .. tostring(err), "error")
      else
        ya.dbg("移動完了")
        ya.notify({
          title = "rmv",
          content = "Moved: " .. path .. " -> " .. dest,
          level = "info",
          timeout = 5,
        })
      end

    else
      ya.err("Unknown operation: " .. tostring(op))
      ya.notify({
        title = "rmv",
        content = "Unknown operation: " .. tostring(op),
        level = "error",
        timeout = 5,
      })
    end
  end,
}

