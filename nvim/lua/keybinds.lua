-- 画面分割
vim.keymap.set("n", "<C-`>", ":split<CR>", { desc = "画面を上下に分割" })
vim.keymap.set("n", "<C-\\>", ":vsplit<CR>", { desc = "画面を左右に分割" })
vim.keymap.set("n", "<C-w>q", ":close<CR>", { desc = "現在のウィンドウを閉じる" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "左のウィンドウへ移動" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "下のウィンドウへ移動" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "上のウィンドウへ移動" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "右のウィンドウへ移動" })

-- 選択範囲を上下に移動（かなり便利）
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "選択行を下に移動" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "選択行を上に移動" })

-- インデント後も選択を維持（デフォルトだと選択が解除されて不便）
vim.keymap.set("v", "<", "<gv", { desc = "インデントを下げて再選択" })
vim.keymap.set("v", ">", ">gv", { desc = "インデントを上げて再選択" })

-- ペースト時にレジスタを上書きしない（選択→貼り付けで元のコピー内容を保持）
vim.keymap.set("v", "p", '"_dP', { desc = "貼り付け時にレジスタを保持" })
