return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = false },
      image = { enabled = false },
      input = { enabled = true },
      indent = {
        enabled = true,
        animate = {
          enabled = false,
        },
      },
      picker = {
        enabled = true,
        ui_select = true,
        matcher = {
          fuzzy = false,
        },
        sources = {
          files = {
            hidden = true,
            cmd = "fd",
          },
          grep = {
            hidden = true,
            cmd = "rg",
            regex = true,
          },
        },
      },
      notifier = { enabled = true },
      quickfile = { enabled = false },
      scope = { enabled = true },
      statuscolumn = { enabled = false },
      words = { enabled = true },
    },
    keys = {
      { "<Leader>l", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<Leader>f", function() Snacks.picker.files() end, desc = "find files" },
      { "<Leader>/", function() Snacks.picker.grep() end, desc = "grep" },
      { "<Leader>m", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<Leader>u", function() Snacks.picker.undo() end, desc = "Undo History" },
      { "<C-_>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
      { "<Leader>d", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<Leader>s", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<Leader>ss", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    },
    config = function(_, opts)
      require("snacks").setup(opts)
      vim.api.nvim_create_user_command("Info", function() Snacks.notifier.show_history() end, { desc = "Show Notification History" })
    end,
  },
}
