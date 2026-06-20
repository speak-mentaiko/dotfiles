return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
  },
  config = function()
    local servers = {
      "ts_ls",
      "html",
      "cssls",
      "solargraph",
      "lua_ls",
      "astro",
      "jsonls",
      "typos_lsp",
    }

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = servers,
    })

    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local opts = {
        capabilities = capabilities
      }

    for _, server in ipairs(servers) do
      if server == "solargraph" then
        opts.settings = {
          solargraph = {
            diagnostics = true, -- RuboCopのエラー警告を出す
            formatting = true,  -- RuboCopの自動整形を有効にする
          }
        }
      end

      vim.lsp.config(server, opts)
      vim.lsp.enable(server)
    end
  end,
}
