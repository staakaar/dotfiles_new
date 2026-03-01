local map = vim.keymap.set

-- 画面分割
map("n", "<C-`>", ":split<CR>", { desc = "画面を上下に分割" })
map("n", "<C-\\>", ":vsplit<CR>", { desc = "画面を左右に分割" })
map("n", "<C-w>q", ":close<CR>", { desc = "現在のウィンドウを閉じる" })
map("n", "<C-h>", "<C-w>h", { desc = "左のウィンドウへ移動" })
map("n", "<C-j>", "<C-w>j", { desc = "下のウィンドウへ移動" })
map("n", "<C-k>", "<C-w>k", { desc = "上のウィンドウへ移動" })
map("n", "<C-l>", "<C-w>l", { desc = "右のウィンドウへ移動" })

-- 選択範囲を上下に移動（かなり便利）
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "選択行を下に移動" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "選択行を上に移動" })

-- インデント後も選択を維持（デフォルトだと選択が解除されて不便）
map("v", "<", "<gv", { desc = "インデントを下げて再選択" })
map("v", ">", ">gv", { desc = "インデントを上げて再選択" })

-- ペースト時にレジスタを上書きしない（選択→貼り付けで元のコピー内容を保持）
map("v", "p", '"_dP', { desc = "貼り付け時にレジスタを保持" })

-- カーソル移動
map("i", "<C-a>", "<Home>", { desc = "Move to beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move to end of line" })
map("i", "<C-f>", "<Right>", { desc = "Move forward one char" })
map("i", "<C-b>", "<Left>", { desc = "Move backward one char" })
map("i", "<C-n>", "<Down>", { desc = "Move to next line" })
map("i", "<C-p>", "<Up>", { desc = "Move to previous line" })

-- 単語単位移動
map("i", "<M-f>", "<C-Right>", { desc = "Move forward one word" })
map("i", "<M-b>", "<C-Left>", { desc = "Move backward one word" })

-- 削除
map("i", "<C-d>", "<Del>", { desc = "Delete char forward" })
map("i", "<C-h>", "<BS>", { desc = "Delete char backward" })
map("i", "<M-d>", "<C-o>de", { desc = "Delete word forward" })
map("i", "<M-BS>", "<C-w>", { desc = "Delete word backward" })

-- 行削除
map("i", "<C-k>", "<C-o>D", { desc = "Kill line (delete to end)" })
map("i", "<C-u>", "<C-o>d0", { desc = "Delete to beginning of line" })

-- その他
map("i", "<C-y>", "<C-r>\"", { desc = "Yank (paste last deleted)" })
map("i", "<C-t>", "<C-o>xp", { desc = "Transpose chars" })

-- nvim-tree
map("n", "<leader>tt", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })
map("n", "<leader>tf", "<cmd>NvimTreeFindFile<CR>", { desc = "Find current file in nvim-tree" })

-- Oil.vim
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- gopls
map('n', 'K', vim.lsp.buf.hover, { desc = 'Show hover' })
map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
map('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
map('n', 'gr', vim.lsp.buf.references, bufopts, { desc = 'Show references' })

-- neotest-go
map('n', '<Leader>rt', ':lua require("neotest").run.run()<CR>', { desc = 'Run test' })

-- ペースト後に自動インデント整形
map("n", "p", "p=`]", { desc = "Paste and auto-indent" })
map("n", "P", "P=`[", { desc = "Paste above and auto-indent" })
