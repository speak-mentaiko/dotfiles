return {
  "isakbm/gitgraph.nvim",
  opts = {
    -- グラフの見た目の設定
    symbols = {
      merge_commit = 'M',
      commit = '*',
    },
    format = {
      timestamp = '%Y-%m-%d %H:%M',
      fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
    },
    hooks = {
      -- グラフ上のコミットでEnterを押した時の動作（今回はシンプルにメッセージだけ表示）
      on_select_commit = function(commit)
        vim.notify("Commit: " .. commit.message)
      end,
      -- ブランチ名でEnterを押した時の動作
      on_select_reference = function(reference)
        vim.notify("Reference: " .. reference.name)
      end,
    },
  },
  keys = {
    {
      "<leader>gl", -- Git Log / Graph の略
      function()
        vim.cmd("vsplit")
        require('gitgraph').draw({}, { all = true, max_count = 5000 })
      end,
      desc = "Git Graphを表示",
    },
  },
}
