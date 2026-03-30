local plugins = {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000, -- 他のプラグインより先にロード
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function() require "extensions.nightfox" end,
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function() require "extensions.dashboard" end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },
  {
    "ahmedkhalf/project.nvim",
    config = function() require "extensions.project" end,
  },
  {
    "github/copilot.vim",
    lazy = false,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    lazy = false,
    priority = 1000,
    branch = "master",
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "go", "java", "ruby",
        "lua", "bash", "json", "yaml", "markdown",
        "typescript", "javascript", "rust", "python",
        "html", "css", "vue", "gomod", "gowork", "gosum", "tsx", "vim", "dockerfile", "sql", "kotlin", "markdown_inline"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'CursorMoved',
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function() require "extensions.bufferline" end,
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    "kylechui/nvim-surround",
    version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    -- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
    -- config = function()
    --     require("nvim-surround").setup({
    --         -- Put your configuration here
    --     })
    -- end
  },
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim", -- required

      -- Only one of these is needed.
      "sindrets/diffview.nvim",   -- optional
      "esmuellert/codediff.nvim", -- optional

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
      "nvim-mini/mini.pick",           -- optional
      "folke/snacks.nvim",             -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    }
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    opts = {
      terminal_cmd = vim.fn.expand("~/.local/bin/claude"),
      terminal = {
        split_side             = "right",
        split_width_percentage = 0.35,
        provider               = "snacks",
        auto_close             = true,

        -- ★ snacks_win_opts で背景透過を設定
        snacks_win_opts        = {
          -- フロートウィンドウにする場合
          -- position = "float",
          -- width    = 0.9,
          -- height   = 0.9,

          border   = "rounded",

          -- ★ backdrop を 100 にすることでWezTermの背景と同じになる
          -- 0=完全透明 〜 100=完全不透明（デフォルトは60程度）
          backdrop = 100,

          wo       = {
            -- ★ winblend を0にして透過を無効化
            winblend = 0,

            -- ★ ハイライトグループをNormalに合わせる
            winhighlight = table.concat({
              "Normal:Normal",
              "NormalNC:NormalNC",
              "NormalFloat:Normal",
              "FloatBorder:FloatBorder",
            }, ","),
          },
        },
      },
    },
    keys = {
      { "<leader>a",  nil,                              desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  {
    'nvim-lualine/lualine.nvim',
    event = { 'VimEnter' },
    config = function() require 'extensions.lualine' end,
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash Jump" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<C-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
    config = function() require 'extensions.flash' end,
  },
  {
    "MagicDuck/grug-far.nvim",
    cmd  = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function() require("grug-far").open() end,
        desc = "Search and Replace (grug-far)",
      },
      {
        "<leader>sw",
        function()
          require("grug-far").open({
            prefills = { search = vim.fn.expand("<cword>") }
          })
        end,
        desc = "Search current word",
      },
      {
        "<leader>sr",
        function()
          require("grug-far").with_visual_selection()
        end,
        mode = "v",
        desc = "Search selection",
      },
    },
    opts = {
      headerMaxWidth = 80,
    },
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
    "pechorin/any-jump.vim",
    cmd = { "AnyJump", "AnyJumpVisual", "AnyJumpBack", "AnyJumpLastResults" },
    keys = {
      { "<leader>j",  "<Cmd>AnyJump<CR>",            mode = "n", desc = "Any Jump" },
      { "<leader>j",  "<Cmd>AnyJumpVisual<CR>",      mode = "x", desc = "Any Jump Visual" },
      { "<leader>ab", "<Cmd>AnyJumpBack<CR>",        mode = "n", desc = "Any Jump Back" },
      { "<leader>al", "<Cmd>AnyJumpLastResults<CR>", mode = "n", desc = "Any Jump Last Results" },
    },
    init = function()
      -- デフォルトキーバインドを無効化（上記keysで管理するため）
      vim.g.any_jump_disable_default_keybindings  = 1
      -- 検索エンジン（ripgrepを優先）
      vim.g.any_jump_search_prefered_engine       = "rg"
      -- 検索結果の表示件数
      vim.g.any_jump_max_search_results           = 10
      -- プレビュー行数
      vim.g.any_jump_preview_lines_count          = 5
      -- 行番号を表示
      vim.g.any_jump_list_numbers                 = 1
      -- 参照を自動検索
      vim.g.any_jump_references_enabled           = 1
      -- ファイルごとにグループ化
      vim.g.any_jump_grouping_enabled             = 0
      -- ウィンドウサイズ
      vim.g.any_jump_window_width_ratio           = 0.6
      vim.g.any_jump_window_height_ratio          = 0.6
      vim.g.any_jump_window_top_offset            = 4
      -- コメント行を除外
      vim.g.any_jump_remove_comments_from_results = 1
      -- 無視するファイル
      vim.g.any_jump_ignored_files                = { "*.tmp", "*.temp" }
      -- ジャンプ後に画面を中央に
      vim.g.any_jump_center_screen_after_jump     = true
      -- 結果UIスタイル
      vim.g.any_jump_results_ui_style             = "filename_first"
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        -- ★ 全ファイルタイプで有効化
        "*",
        -- ファイルタイプごとの個別設定
        css = {
          rgb_fn   = true, -- rgb(), rgba() を有効化
          hsl_fn   = true, -- hsl(), hsla() を有効化
          css      = true, -- CSS全機能を有効化
          css_fn   = true,
          RRGGBBAA = true,
        },
        scss = {
          rgb_fn = true,
          hsl_fn = true,
          css    = true,
        },
        html = {
          mode  = "foreground", -- 文字色で表示
          names = true,
        },
        javascript = {
          rgb_fn = true,
        },
        typescript = {
          rgb_fn = true,
        },
        vue = {
          rgb_fn = true,
          css    = true,
        },
        lua = {
          RGB    = true,
          RRGGBB = true,
        },
      }, {
        -- デフォルトオプション（全ファイルタイプに適用）
        RGB      = true,         -- #RGB
        RRGGBB   = true,         -- #RRGGBB
        names    = true,         -- "Blue" などの名前
        RRGGBBAA = false,        -- #RRGGBBAA
        rgb_fn   = false,        -- rgb(), rgba()
        hsl_fn   = false,        -- hsl(), hsla()
        mode     = "background", -- 背景色で表示
      })
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
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  -- mason-tool-installer: LSP以外のツール（formatter/linter/dap）を自動インストール
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "goimports", "gofumpt", "gomodifytags", "impl",
        "golangci-lint", "delve",
        "erb-formatter", "erb-lint",
        "rubocop",
        "stylua", "prettier",
      },
    },
  },
  -- Java専用LSPプラグイン（nvim-java: batteries included）
  {
    "nvim-java/nvim-java",
    ft = "java",
    config = function()
      require("java").setup()
      vim.lsp.enable("jdtls")
    end,
  },
  {
    "leoluz/nvim-dap-go",
    dependencies = {
      "mfussenegger/nvim-dap", -- ★ 明示的にdapに依存させる
    },
    opts = {},
    config = function()
      require("dap-go").setup()
    end,
  },
  {
    "fredrikaverpil/neotest-golang",
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
          local dap, dapui = require("dap"), require("dapui")
          dapui.setup()
          -- デバッグ開始/終了時にUIを自動開閉
          dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
          dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
          dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end
        end,
      },
      -- インライン変数表示
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      -- Go DAP
      { "leoluz/nvim-dap-go", opts = {} },
    },
    config = function()
      local dap = require("dap")

      -- Ruby: rdbg (debug gem)
      dap.adapters.ruby = function(callback, config)
        callback({
          type    = "server",
          host    = "127.0.0.1",
          port    = "${port}",
          executable = {
            command = "bundle",
            args    = { "exec", "rdbg", "-n", "--open", "--port", "${port}",
                        "-c", "--", config.command, config.script },
          },
        })
      end

      dap.configurations.ruby = {
        {
          type    = "ruby",
          name    = "Debug current file",
          request = "attach",
          command = "ruby",
          script  = "${file}",
        },
        {
          type    = "ruby",
          name    = "Rails server",
          request = "attach",
          command = "bundle",
          script  = "bin/rails server",
        },
      }

      -- キーマップ
      local map = vim.keymap.set
      map("n", "<F5>",       function() require("dap").continue() end,          { desc = "DAP Continue" })
      map("n", "<F10>",      function() require("dap").step_over() end,         { desc = "DAP Step Over" })
      map("n", "<F11>",      function() require("dap").step_into() end,         { desc = "DAP Step Into" })
      map("n", "<F12>",      function() require("dap").step_out() end,          { desc = "DAP Step Out" })
      map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
      map("n", "<leader>du", function() require("dapui").toggle() end,          { desc = "Toggle DAP UI" })
    end,
  },
  -- masonとlspconfigの橋渡し
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Ruby
          "ruby_lsp",
          -- Go
          "gopls",
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
      "mason-org/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lsp = vim.g.lazyvim_ruby_lsp or "ruby-lsp"
      local formatter = vim.g.lazyvim_ruby_formatter or "rubocop"

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

      -- 各LSPの設定（gopls/ruby_lsp は下で個別設定）
      local servers = {
        "rust_analyzer", -- Rust
        "ts_ls",         -- JS / TS / React / Next.js
        "html",          -- HTML
        "tailwindcss",   -- TailwindCSS
        "dockerls",      -- Docker
        "lua_ls",        -- Lua
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({ on_attach = on_attach, capabilities = capabilities })
      end

      -- Ruby: vim.g.lazyvim_ruby_lsp に従って起動
      if lsp == "ruby-lsp" then
        lspconfig.ruby_lsp.setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      elseif lsp == "solargraph" then
        lspconfig.solargraph.setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end

      -- Java: nvim-javaが vim.lsp.enable("jdtls") で管理
      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        cmd = { "gopls" },
        settings = {
          gopls = {
            gofumpt            = true,
            staticcheck        = true,
            analyses           = {
              nilness        = true,
              unusedparams   = true,
              unusedwrite    = true,
              unusedvariable = true,
              shadow         = true,
            },
            hints              = {
              assignVariableTypes    = true,
              compositeLiteralFields = true,
              constantValues         = true,
              functionTypeParameters = true,
              parameterNames         = true,
              rangeVariableTypes     = true,
            },
            completeUnimported = true,
            usePlaceholders    = true,
            semanticTokens     = true,
            directoryFilters   = {
              "-.git", "-.vscode", "-.idea", "-node_modules"
            },
          },
        },
      })
      -- Kotlin
      lspconfig.kotlin_language_server.setup({ on_attach = on_attach, capabilities = capabilities })
    end,
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({})
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    }
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-b>']     = cmp.mapping.scroll_docs(-4),
          ['<C-f>']     = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>']     = cmp.mapping.abort(),
          ['<CR>']      = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
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
  { 'hrsh7th/cmp-nvim-lsp' },
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
          eruby      = { "erb-format" },
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
  {
    "fredrikaverpil/neotest-golang",
  },
  {
    'nvim-neotest/neotest',
    tag = 'v5.6.1',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-go',
      "olimorris/neotest-rspec",
      "nvim-neotest/neotest-go",
      "rouge8/neotest-rust",
      "rcasia/neotest-java",
      "nvim-neotest/neotest-python",
      "fredrikaverpil/neotest-golang",
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-go')({
            experimental = {
              test_table = true,
            },
            args = { '-count=1', '-timeout=60s', '-coverprofile=coverage.out' },
          }),

          require("neotest-rspec"),

          require("neotest-rust"),

          require("neotest-java"),

          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "pytest", -- "unittest" に変更も可
          }),
          ["neotest-golang"] = {
            -- Here we can set options for neotest-golang, e.g.
            -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
            dap_go_enabled = true, -- requires leoluz/nvim-dap-go
          },
        },
      })

      local map = vim.keymap.set
      map("n", "<leader>rt", function() require("neotest").run.run() end, { desc = "Run nearest test" })
      map("n", "<leader>rf", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run current file" })
      map("n", "<leader>rs", function() require("neotest").summary.toggle() end, { desc = "Toggle test summary" })
      map("n", "<leader>ro", function() require("neotest").output.open({ enter = true }) end,
        { desc = "Open test output" })
      map("n", "<leader>rS", function() require("neotest").run.stop() end, { desc = "Stop test" })
    end,
  },
}

local opts = {
  checker = {
    enabled = true,
  },
  install = {
    -- colorscheme = { "nightfox" }
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
