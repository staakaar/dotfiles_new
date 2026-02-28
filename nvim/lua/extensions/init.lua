local plugins = {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000, -- 他のプラグインより先にロード
    config = function()
      require("nightfox").setup({
        options = {
          transparent = false,
          terminal_colors = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            functions = "NONE",
            types = "italic,bold",
          },
        },
      })
      vim.cmd("colorscheme nightfox") -- テーマ選択
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    tag = 'v0.9.3',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'go', 'ruby', 'java', 'lua', 'typescript', 'javascript', 'json', 'yaml', 'html', 'css', 'bash', 'python', 'markdown', 'scala' },
        highlight = {
          enabled = true,
        },
      })
    end,
    event = { 'BufNewFile', 'BufReadPre' },
  },
  {
    'rmehri01/onenord.nvim',
    event = { 'VimEnter' },
    priority = 1000,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = { 'VimEnter' },
    config = function() require 'extensions.lualine' end,
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'kevinhwang91/nvim-hlslens',
    event = { 'FilterWritePre' },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre' },
  },
  {
    'petertriho/nvim-scrollbar',
    event = { 'BufNewFile', 'BufReadPre' },
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    config = function() require 'extensions.oil' end,
    lazy = false,
  },
  {
    "A7Lavinraj/fyler.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    branch = "stable",
    lazy = false,
    opts = {
      integrations = {
        icon = "nvim_web_devicons",
      }
    },
    keys = {
      { "<leader>e", "<Cmd>Fyler<Cr>", desc = "Open Fyler View" },
    }
  },
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    keys = {
      '<leader>ff', '<leader>fg', '<leader>fb', '<leader>fh'
    },
    config = function() require 'extensions.telescope' end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- optional but recommended
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'sharkdp/fd',                               build = 'make' },
      { "nvim-tree/nvim-web-devicons",              opts = {},     build = 'make' },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Uncomment whichever supported plugin(s) you use
      -- "nvim-tree/nvim-tree.lua",
      -- "nvim-neo-tree/neo-tree.nvim",
      -- "simonmclean/triptych.nvim"
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      {
        'b0o/nvim-tree-preview.lua',
        dependencies = {
          'nvim-lua/plenary.nvim',
          '3rd/image.nvim', -- Optional, for previewing images
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    config = function() require 'extensions.mason' end,
  },
  -- masonとlspconfigの橋渡し
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Ruby
          "solargraph",
          -- Go
          -- "gopls",
          -- Rust
          "rust_analyzer",
          -- Elixir
          -- "elixirls",
          -- JavaScript / TypeScript (React / Next.js)
          "ts_ls",
          -- Vue / Nuxt.js
          -- "vue_ls",
          -- Java
          "jdtls",
          -- Kotlin
          "kotlin_language_server",
          -- HTML
          "html",
          -- TailwindCSS
          "tailwindcss",
          -- Docker
          "dockerls",
          -- Lua (Neovim設定用)
          "lua_ls",
        },
        automatic_installation = true,
      })
    end,
  },
  -- LSP本体の設定
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig").clangd

      -- 共通のキーマップ
      local on_attach = function(_, bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr, silent = true }

        map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
        map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
        map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
        map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
        map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
        map("n", "<leader>f", vim.lsp.buf.format, vim.tbl_extend("force", opts, { desc = "Format" }))
        map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Prev diagnostic" }))
        map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
      end

      -- 各LSPの設定
      local servers = {
        "solargraph",    -- Ruby
        -- "gopls",        -- Go
        "rust_analyzer", -- Rust
        -- "elixirls",     -- Elixir
        "ts_ls",         -- JS / TS / React / Next.js
        -- "vue_ls",        -- Vue / Nuxt.js
        "html",          -- HTML
        "tailwindcss",   -- TailwindCSS
        "dockerls",      -- Docker
        "lua_ls",        -- Lua
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({ on_attach = on_attach })
      end

      -- Java（jdtlsは専用設定が必要）
      lspconfig.jdtls.setup({ on_attach = on_attach })
      lspconfig.gopls.setup({
        on_attach = on_attach,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,           -- 未使用パラメータの警告
              shadow = true,                 -- 変数シャドウの警告
              unusedvariable = true,         -- 未使用変数の警告
            },
            staticcheck = true,              -- staticcheckによる静的解析
            gofumpt = true,                  -- gofumptによるフォーマット
            hints = {
              assignVariableTypes = true,    -- 変数の型ヒント表示
              compositeLiteralFields = true, -- 構造体フィールドヒント
              constantValues = true,         -- 定数値ヒント
              functionTypeParameters = true, -- 関数型パラメータヒント
              parameterNames = true,         -- パラメータ名ヒント
              rangeVariableTypes = true,     -- range変数の型ヒント
            },
          },
        },
      })
      -- Kotlin
      lspconfig.kotlin_language_server.setup({ on_attach = on_attach })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'nvim-lsp' },
          { name = 'buffer' },
          { name = 'path' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
      })
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    config = function()
      require 'cmp'.setup {
        sources = {
          { name = 'nvim_lsp' }
        }
      }
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('lspconfig').clangd.setup {
        capabilities = capabilities,
      }
    end
  },
  {
    'hrsh7th/cmp-buffer',
  },
  {
    'hrsh7th/cmp-path',
  },
  {
    'hrsh7th/cmp-cmdline',
  },
  { "nvimdev/lspsaga.nvim" },
  { "j-hui/fidget.nvim",     opts = {} },
  { "folke/trouble.nvim",    opts = {} },
  -- Linter
  { "mfussenegger/nvim-lint" },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          go         = { "gofumpt", "goimports" },
          ruby       = { "rubocop" },
          rust       = { "rustfmt" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          vue        = { "prettier" },
          html       = { "prettier" },
          css        = { "prettier" },
          json       = { "prettier" },
          lua        = { "stylua" },
          java       = { "google-java-format" },
          kotlin     = { "ktlint" },
        },
        -- 保存時に自動フォーマット
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true, -- フォーマッターがなければLSPにフォールバック
        },
      })

      -- 手動フォーマットのキーマップ
      vim.keymap.set({ "n", "v" }, "<leader>cf", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "Format file" })
    end,
  },
}

local opts = {
  checker = {
    enabled = true,
  },
  install = {
    colorscheme = { "nightfox" }
  },
  preformance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = {},
      disabled_plugins = {
        "gzip",
        "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins, opts)
