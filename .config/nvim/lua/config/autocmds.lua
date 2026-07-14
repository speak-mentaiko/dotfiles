-- ファイルの自動保存
local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

-- インサートモードを抜けた時に実行
vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
  group = autosave_group,
  pattern = "*",
  callback = function()
    -- 保存してはいけない特殊なファイル名なら処理をストップ
    if vim.fn.expand("%:t") == "GitGraph" then
      return
    end
    -- ファイルに変更があり、かつ名前がついている通常のファイルの場合のみ保存
    if vim.bo.modified and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! update")
    end
  end,
})

-- 不要な空バッファを自動削除
local cleanup_group = vim.api.nvim_create_augroup("BufferCleanup", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  group = cleanup_group,
  desc = "不要な空バッファを自動削除",
  callback = function()
    local current_buf = vim.api.nvim_get_current_buf()
    local current_name = vim.api.nvim_buf_get_name(current_buf)
    local current_buftype = vim.bo[current_buf].buftype

    -- 今開いているのが「名前のある普通のファイル」じゃないなら何もしない
    if current_name == "" or current_buftype ~= "" then
      return
    end

    -- 存在する全バッファを巡回して、条件に合うものを消去
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      -- 削除の条件：今のバッファではなく、名前がなく、未編集で、タブに表示されているもの
      if buf ~= current_buf
         and vim.api.nvim_buf_get_name(buf) == ""
         and vim.bo[buf].buftype == ""
         and not vim.bo[buf].modified
         and vim.bo[buf].buflisted then

        vim.api.nvim_buf_delete(buf, { force = false })
      end
    end
  end,
})

-- 変更されたファイルを自動で再読み込み
local autoread_group = vim.api.nvim_create_augroup("AutoRead", { clear = true })

-- Neovimの自動再読み込み機能を明示的にオンにする
vim.opt.autoread = true

-- Neovimにフォーカスが戻った時、ターミナルを閉じた時、または少し操作を止めた時にファイルの変更をチェック
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave", "CursorHold" }, {
  group = autoread_group,
  pattern = "*",
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

--[[
-- ファイルが自動で再読み込みされた時に通知を出す
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = autoread_group,
  pattern = "*",
  callback = function()
    vim.notify("外部での変更を検知し、ファイルを再読み込みしました", vim.log.levels.INFO)
  end,
})
]]
