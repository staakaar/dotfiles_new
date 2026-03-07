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

vim.treesitter.start = (function(wrapped)
  return function(bufnr, lang)
    lang = lang or vim.fn.getbufvar(bufnr or '', '&filetype')
    pcall(wrapped, bufnr, lang)
  end
end)(vim.treesitter.start)

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end
})
