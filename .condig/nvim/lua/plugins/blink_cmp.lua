return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  build = "cargo build --release",

  opts = {
    keymap = {
      preset = "default",
      ["<Tab>"] = { "accept", "snippet_forward", "fallback" },
      ["<CR>"] = { "fallback" },
    },
    appearance = {
      -- アイコンなどをモダンなUIにする
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    -- どこから補完を持ってくるか
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        lsp = {
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              if item.textEdit then
                item.insertText = item.textEdit.newText
                item.textEdit = nil
              end
            end
            return items
          end,
        },
      },
    },
  },
}
