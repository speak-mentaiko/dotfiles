return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      -- 左端に出る線のデザイン（VSCode風のシンプルな縦線）
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },

      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- ショートカットキーの設定
        -- ]h と [h で、変更箇所（ハンク）を順番にジャンプする
        map("n", "]h", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "次の変更箇所へ" })

        map("n", "[h", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "前の変更箇所へ" })

        -- カーソル位置の変更前のコードをポップアップで確認する
        map("n", "<leader>gh", gs.preview_hunk, { desc = "変更内容をプレビュー" })

        -- VSCodeのGitLensのように、現在の行を誰がいつ書いたか表示する（トグル）
        map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Git Blameの表示切替" })
      end
    })
  end
}
