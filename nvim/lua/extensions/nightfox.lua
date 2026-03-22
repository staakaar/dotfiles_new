require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = true,                -- Disable setting background
    terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,              -- Non focused panes set to alternative background
    module_default = true,             -- Default enable value for modules
    colorblind = {
      enable = false,                  -- Enable colorblind support
      simulate_only = false,           -- Only show simulated colorblind colors and not diff shifted
      severity = {
        protan = 0,                    -- Severity [0,1] for protan (red)
        deutan = 0,                    -- Severity [0,1] for deutan (green)
        tritan = 0,                    -- Severity [0,1] for tritan (blue)
      },
    },
    styles = {             -- Style to be applied to different syntax groups
      comments = "italic", -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "NONE",
      keywords = "bold",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "bold",
      variables = "bold",
    },
    inverse = { -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = { -- List of various plugins and additional options
      treesitter = true,
      native_lsp = {
        enable     = true,
        background = true,
      },
      lazy_nvim = {
        enable = true,
      },
      diagnostic = {
        enable     = true,
        background = true,
      },
    },
  },
  palettes = {},
  specs = {
    nightfox = {
      syntax = {
        keyword = "orange",
        variable = "magenta"
      }
    }
  },
  groups = {
    all = {
      ["@keyword"]                              = { fg = "palette.orange" },
      ["@keyword.function"]                     = { fg = "palette.orange" },
      ["@keyword.operator"]                     = { fg = "palette.orange" },
      ["@keyword.return"]                       = { fg = "palette.orange" },
      ["@keyword.import"]                       = { fg = "palette.orange" },
      ["@keyword.type"]                         = { fg = "palette.orange" },
      ["@variable"]                             = { fg = "palette.magenta" },
      ["@variable.builtin"]                     = { fg = "palette.magenta" },
      ["@variable.parameter"]                   = { fg = "palette.magenta" },
      ["@variable.member"]                      = { fg = "palette.magenta" },
      -- ★ LSP Semantic Tokens（Go向け）
      -- @lsp.type.variable.go → @lsp.type.variable にリンクしているので両方設定
      ["@lsp.type.variable"]                    = { fg = "palette.magenta" },
      ["@lsp.type.variable.go"]                 = { fg = "palette.magenta" },

      -- chan修飾子（チャネル変数）
      ["@lsp.mod.chan.go"]                      = { fg = "palette.magenta" },
      ["@lsp.typemod.variable.chan.go"]         = { fg = "palette.magenta" },

      -- definition修飾子（変数定義）
      ["@lsp.mod.definition.go"]                = { fg = "palette.magenta" },
      ["@lsp.typemod.variable.definition.go"]   = { fg = "palette.magenta" },

      -- ★ Go全般のLSP Semantic Tokens追加設定
      ["@lsp.type.parameter.go"]                = { fg = "palette.magenta" },
      ["@lsp.type.property.go"]                 = { fg = "palette.magenta" },
      ["@lsp.type.function.go"]                 = { fg = "palette.blue" },
      ["@lsp.type.method.go"]                   = { fg = "palette.blue" },
      ["@lsp.type.type.go"]                     = { fg = "palette.cyan" },
      ["@lsp.type.interface.go"]                = { fg = "palette.cyan" },
      ["@lsp.type.struct.go"]                   = { fg = "palette.cyan", bold = 'true' },
      ["@lsp.type.keyword.go"]                  = { fg = "palette.orange", bold = 'true' },
      ["@lsp.type.namespace.go"]                = { fg = "palette.yellow" },
      ["@lsp.type.number.go"]                   = { fg = "palette.yellow" },
      ["@lsp.type.string.go"]                   = { fg = "palette.green" },
      ["@lsp.type.comment.go"]                  = { fg = "palette.comment" },
      ["@lsp.type.operator.go"]                 = { fg = "palette.cyan" },
      -- ★ Markdown ハイライト設定
      ["@markup.heading.1.markdown"]            = { fg = "palette.red", bold = 'true' },
      ["@markup.heading.2.markdown"]            = { fg = "palette.orange", bold = 'true' },
      ["@markup.heading.3.markdown"]            = { fg = "palette.yellow", bold = 'true' },
      ["@markup.heading.4.markdown"]            = { fg = "palette.green", bold = 'true' },
      ["@markup.heading.5.markdown"]            = { fg = "palette.blue", bold = 'true' },
      ["@markup.heading.6.markdown"]            = { fg = "palette.magenta", bold = 'true' },
      -- 区切り線（---）
      ["@punctuation.special.markdown"]         = { fg = "palette.cyan" },
      ["@markup.strong.markdown_inline"]        = { fg = "palette.fg1", bold = 'true' },
      ["@markup.italic.markdown_inline"]        = { fg = "palette.fg1" },
      ["@markup.strikethrough.markdown_inline"] = { fg = "palette.comment", strikethrough = 'true' },
      ["@markup.raw.markdown_inline"]           = { fg = "palette.green", bg = "palette.bg2" },
      ["@markup.raw.block.markdown"]            = { fg = "palette.green" },
      ["@markup.link.label.markdown_inline"]    = { fg = "palette.blue", underline = 'true' },
      ["@markup.link.url.markdown_inline"]      = { fg = "palette.cyan", underline = 'true' },
      ["@markup.list.markdown"]                 = { fg = "palette.orange" },
      ["@markup.list.checked.markdown"]         = { fg = "palette.green" },
      ["@markup.list.unchecked.markdown"]       = { fg = "palette.comment" },
      ["@markup.quote.markdown"]                = { fg = "palette.comment" },
      ["@variable.markdown"]                    = { fg = "palette.magenta" },
      ["@keyword.markdown"]                     = { fg = "palette.orange" },
      ["@tag.markdown"]                         = { fg = "palette.blue" },
    },
    nightfox = {
      -- treesitter ハイライトグループを明示的に上書き
      ["@keyword"]  = { fg = "palette.orange" },
      -- ["@keyword.function"]   = { fg = "palette.orange" },
      -- ["@keyword.return"]     = { fg = "palette.orange" },
      ["@variable"] = { fg = "palette.magenta" },
      -- ["@variable.builtin"]   = { fg = "palette.magenta" },
      -- ["@variable.parameter"] = { fg = "palette.magenta" },
    },
  },
})
vim.fn.system("rm -rf " .. vim.fn.stdpath("cache") .. "/nightfox")
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.cmd("colorscheme nightfox")
  end,
})
