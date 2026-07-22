-- 不要なプラグインを読み込まない
local default_plugins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "tutor",
}
for _, plugin in ipairs(default_plugins) do
  vim.g["loaded_" .. plugin] = 1
end

-- クリップボード
vim.opt.clipboard = "unnamedplus"

-- tab
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- 行番号
vim.opt.number = true

-- 不要なスペースを表示
vim.opt.list = true
vim.opt.listchars = {
  trail = "*",
}
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function ()
    vim.api.nvim_set_hl(0, "ZenkakuSpace", { link = "Search" })
  end,
})
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  pattern = "*",
  callback = function()
    vim.schedule(
      function ()
        if vim.bo.buftype == "" then
          -- 通常のファイルならハイライトを適用する
          vim.cmd([[match ZenkakuSpace /\s\+$\|　/]])
        else
          -- それ以外（ダッシュボード、ツリー、ターミナルなど）は一律でハイライトを消す
          pcall(vim.cmd, "match none")
        end
      end
    )
  end,
})

-- インサートモードでも警告を出す
vim.diagnostic.config({
  update_in_insert = true,
})
