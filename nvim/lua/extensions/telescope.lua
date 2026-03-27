local builtin = require('telescope.builtin')
local telescope = require 'telescope'
local themes = require 'telescope.themes'
local actions = require 'telescope.actions'

-- gitルートを返す。gitリポジトリ外なら現在のcwdを返す
local function project_root()
  local root = vim.fn.systemlist("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    return vim.fn.getcwd()
  end
  return root
end

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fs', function()
  builtin.live_grep({ cwd = project_root() })
end, { desc = 'Telescope grep in project' })
vim.keymap.set('n', '<leader>fF', function()
  builtin.find_files({ cwd = project_root(), hidden = true, no_ignore = true })
end, { desc = 'Telescope find files in project (include hidden)' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set("n", "<leader>fp", function()
  require("telescope").extensions.projects.projects {}
end, { noremap = true, silent = true, desc = "Find projects" })

telescope.setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
        ["<esc>"] = actions.close
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    -- please take a look at the readme of the extension you want to configure
  }
}
telescope.load_extension 'fzf'
