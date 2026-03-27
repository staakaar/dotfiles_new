local bufferline = require("bufferline")

bufferline.setup({
  options = {
    -- "buffers"はバッファ一覧、"tabs"はタブページのみを表示
    mode                         = "buffers",

    -- bufferline.style_preset.default または bufferline.style_preset.minimal
    style_preset                 = bufferline.style_preset.default,

    -- ハイライトグループを上書き可能にするか
    themable                     = true,

    -- バッファ番号の表示方法
    -- "none" | "ordinal" | "buffer_id" | "both"
    numbers                      = "ordinal",

    -- バッファを閉じるコマンド
    close_command                = "bdelete! %d",

    -- 右クリック時のコマンド
    right_mouse_command          = "bdelete! %d",

    -- 左クリック時のコマンド
    left_mouse_command           = "buffer %d",

    -- 中クリック時のコマンド（nilで無効）
    middle_mouse_command         = nil,

    -- アクティブバッファのインジケーター設定
    indicator                    = {
      -- style が 'icon' 以外の場合はiconを省略可能
      icon = "▎",
      -- "icon" | "underline" | "none"
      style = "icon",
    },

    -- 各種アイコン設定
    buffer_close_icon            = "󰅖",
    modified_icon                = "● ",
    close_icon                   = " ",
    left_trunc_marker            = " ",
    right_trunc_marker           = " ",

    -- バッファ名のフォーマット（カスタム関数で変更可能）
    -- buf には以下が含まれる:
    --   name    | str | アクティブファイルのベース名
    --   path    | str | アクティブファイルのフルパス
    --   bufnr   | int | アクティブバッファの番号
    -- name_formatter = function(buf)
    --   return buf.name
    -- end,

    -- バッファ名の最大文字数
    max_name_length              = 18,

    -- 重複バッファのプレフィックス最大文字数
    max_prefix_length            = 15,

    -- バッファ名を省略するか
    truncate_names               = true,

    -- タブの最小サイズ
    tab_size                     = 18,

    -- LSP診断の表示
    -- false | "nvim_lsp" | "coc"
    diagnostics                  = "nvim_lsp",

    -- インサートモード中に診断を更新するか（cocのみ適用）
    diagnostics_update_in_insert = false,

    -- nvimの診断ハンドラを使用して更新するか
    diagnostics_update_on_event  = true,

    -- 診断インジケーターの表示形式
    -- nilにするとバッファ名のハイライトは残るが診断ハイライトは消える
    diagnostics_indicator        = function(count, level, _, _)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,

    -- 特定条件でバッファをタブラインから除外するカスタムフィルター
    -- NOTE: 重い処理は書かないこと
    -- custom_filter = function(buf_number, buf_numbers)
    --   -- 特定のfiletypeを除外
    --   if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
    --     return true
    --   end
    --   -- バッファ名で除外
    --   if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
    --     return true
    --   end
    --   -- 作業ディレクトリに基づいて除外（例: 特定リポジトリでwikiを非表示）
    --   if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
    --     return true
    --   end
    --   -- インデックス番号で除外（例: 最初のバッファを非表示）
    --   if buf_numbers[1] ~= buf_number then
    --     return true
    --   end
    -- end,

    -- サイドバー（nvim-tree等）のオフセット設定
    offsets                      = {
      {
        filetype = "NvimTree",
        -- text = "File Explorer" または function
        text = "File Explorer",
        -- "left" | "center" | "right"
        text_align = "center",
        separator = true,
      },
    },

    -- ファイルタイプアイコンに色をつけるか
    color_icons                  = true,

    -- アイコンの取得方法をカスタマイズ（省略時はnvim-web-deviconsを使用）
    -- get_element_icon = function(element)
    --   local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(
    --     element.filetype, { default = false }
    --   )
    --   return icon, hl
    -- end,

    -- バッファのファイルタイプアイコンを表示するか
    show_buffer_icons            = true,

    -- バッファの閉じるアイコンを表示するか
    show_buffer_close_icons      = true,

    -- タブライン右端の閉じるアイコンを表示するか
    show_close_icon              = false,

    -- タブページインジケーターを表示するか
    show_tab_indicators          = true,

    -- 重複バッファのプレフィックスを表示するか
    show_duplicate_prefix        = true,

    -- 異なるグループ間でも重複パスを重複とみなすか
    duplicates_across_groups     = true,

    -- カスタムソート済みバッファの順序を保持するか
    persist_buffer_sort          = true,

    -- moveコマンドが端で折り返すか
    move_wraps_at_ends           = false,

    -- セパレーターのスタイル
    -- "slant" | "slope" | "thick" | "thin" | { "任意文字", "任意文字" }
    separator_style              = "slant",

    -- タブ幅を均一に強制するか
    enforce_regular_tabs         = false,

    -- 常にタブラインを表示するか
    always_show_bufferline       = true,

    -- バッファ数に応じてタブラインを自動表示/非表示するか
    auto_toggle_bufferline       = true,

    -- ホバー時の動作設定
    hover                        = {
      enabled = true,
      -- ホバーまでの遅延（ミリ秒）
      delay = 200,
      -- ホバー時に表示する要素
      reveal = { "close" },
    },

    -- バッファのソート方法
    -- "insert_after_current" | "insert_at_end" | "id" | "extension"
    -- | "relative_directory" | "directory" | "tabs"
    -- またはカスタム関数:
    -- sort_by = function(buffer_a, buffer_b)
    --   -- 最終更新日時でソートする例
    --   local modified_a = vim.fn.getftime(buffer_a.path)
    --   local modified_b = vim.fn.getftime(buffer_b.path)
    --   return modified_a > modified_b
    -- end,
    sort_by                      = "insert_after_current",

    -- バッファピックモードのアルファベット設定
    pick                         = {
      alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890",
    },
  },
})

-- colorscheme適用後にハイライトを上書き
-- bufferline自身もColorScheme *でset_all()を呼ぶため、
-- vim.schedule()で後から実行することで確実に上書きする
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "nightfox",
  callback = function()
    vim.schedule(function()
      local p = require("nightfox.palette").load("nightfox")
      local hl = vim.api.nvim_set_hl
      hl(0, "BufferLineFill",              { bg = p.bg0 })
      hl(0, "BufferLineBackground",        { fg = p.fg3, bg = p.bg1 })
      hl(0, "BufferLineBufferSelected",    { fg = p.fg1, bg = p.bg3, bold = true })
      hl(0, "BufferLineBufferVisible",     { fg = p.fg2, bg = p.bg2 })
      hl(0, "BufferLineNumbers",           { fg = p.fg3, bg = p.bg1 })
      hl(0, "BufferLineNumbersSelected",   { fg = p.fg1, bg = p.bg3, bold = true })
      hl(0, "BufferLineNumbersVisible",    { fg = p.fg2, bg = p.bg2 })
      hl(0, "BufferLineSeparator",         { fg = p.bg0, bg = p.bg1 })
      hl(0, "BufferLineSeparatorSelected", { fg = p.bg0, bg = p.bg3 })
      hl(0, "BufferLineSeparatorVisible",  { fg = p.bg0, bg = p.bg2 })
      hl(0, "BufferLineIndicatorSelected", { fg = p.blue.base, bg = p.bg3 })
    end)
  end,
})
