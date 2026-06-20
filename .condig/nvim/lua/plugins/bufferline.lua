return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers", -- タブではなく「開いているファイル(バッファ)」を並べる
        numbers = "none",
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        show_buffer_close_icons = true,
        show_close_icon = true,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer", -- ツリーの上の空間に表示するタイトル（お好みで変更可能）
            text_align = "center",  -- タイトルを中央揃えにする
            separator = true        -- ツリーとエディタの間に縦の区切り線を引く
          }
        }
      }
    })

    vim.keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "前のタブへ" })
    vim.keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "次のタブへ" })
    vim.keymap.set(
      "n",
      "<leader>c",
      function()
        -- 1. 未保存なら保存する
        if vim.bo.buftype == "" and vim.bo.modified then
          local success = pcall(function() vim.cmd("write") end)
          if not success then
            vim.notify("保存に失敗しました", vim.log.levels.WARN)
            return
          end
        end

        -- 2. 現在の「普通のエディタ画面（分割）」の数を数える
        local normal_wins = 0
        for _, w in ipairs(vim.api.nvim_list_wins()) do
          local b = vim.api.nvim_win_get_buf(w)
          local ft = vim.bo[b].filetype
          local config = vim.api.nvim_win_get_config(w)
          -- Neo-treeやポップアップウィンドウは除外してカウント
          if ft ~= "neo-tree" and config.zindex == nil then
            normal_wins = normal_wins + 1
          end
        end

        local is_last_buffer = #vim.fn.getbufinfo({ buflisted = 1 }) <= 1
        local current_win = vim.api.nvim_get_current_win()

        -- 3. バッファを削除（タブから消す）
        Snacks.bufdelete()

        -- 4. 画面が分割されていたら、現在の「窓」を閉じる（VSCodeの挙動）
        if normal_wins > 1 then
          pcall(vim.api.nvim_win_close, current_win, false)
          return
        end

        -- 5. 分割されていなくて、最後のファイルだった場合（レイアウト維持）
        if is_last_buffer then
          vim.cmd("enew")
          vim.cmd("Neotree focus")
        end
      end,
      { desc = "タブを閉じる" }
    )
  end
}
