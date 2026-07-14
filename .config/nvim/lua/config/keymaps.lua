vim.keymap.set("n", "<Leader>ee", "<cmd>Neotree toggle<CR>")
vim.keymap.set("i", "jj", "<Esc>", { silent = true})
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

-- 画面の分割と閉じる操作
vim.keymap.set("n", "<Leader>v", "<C-w>v", { desc = "垂直分割" })
vim.keymap.set("n", "<Leader>h", "<C-w>s", { desc = "水平分割" })
vim.keymap.set("n", "<Leader>q", "<cmd>close<CR>", { desc = "現在の画面を閉じる" })

-- 分割した画面間の移動
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "左の画面へ移動" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "下の画面へ移動" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "上の画面へ移動" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "右の画面へ移動" })

-- 画面サイズの変更
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "高さを増やす" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "高さを減らす" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize +2<CR>", { desc = "幅を減らす" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize -2<CR>", { desc = "幅を増やす" })

-- VSCodeと同じように Tab / Shift+Tab でも動かせるようにする
vim.keymap.set("v", "<Tab>", ">gv", { desc = "インデントを深くする" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "インデントを浅くする" })

-- エラーや警告の詳細を表示
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "エラーメッセージを表示" })
-- 関数やクラスのドキュメントをホバー表示する
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "ドキュメントを表示" })
