vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.relativenumber = true
vim.opt.clipboard:append('unnamedplus,unnamed')
vim.opt.backspace = "indent,eol,start"
vim.opt.ambiwidth = "single"
vim.opt.wildmenu = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.ambiwidth = "single"
vim.opt.winblend = 20
vim.opt.pumblend = 20
vim.opt.termguicolors = true
-- タブ・インデント設定
vim.opt.tabstop = 2        -- タブ文字の表示幅
vim.opt.shiftwidth = 2     -- 自動インデントの幅
vim.opt.softtabstop = 2    -- Tab キー押下時の幅
vim.opt.expandtab = true   -- タブをスペースに変換
vim.opt.smartindent = true -- 波括弧の改行後に自動インデント
vim.opt.autoindent = true  -- 前の行のインデントを維持

-- global
vim.api.nvim_set_option('scrolloff', 2)
vim.api.nvim_set_option('ignorecase', true)
vim.api.nvim_set_option('smartcase', true)
vim.api.nvim_set_option('inccommand', 'split')

-- 
vim.api.nvim_create_user_command('InitLua', function() vim.cmd.edit(vim.fn.stdpath('config') .. '/init.lua') end, {})

