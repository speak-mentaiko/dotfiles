return {
  "EdenEast/nightfox.nvim",
  priority = 1000, -- 起動時に最優先で読み込む
  lazy = false,    -- 遅延読み込みさせない
  config = function()
    require("nightfox").setup({
      options = {}
    })

    vim.cmd("colorscheme duskfox")
  end
}
