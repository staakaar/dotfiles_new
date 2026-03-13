require("dashboard").setup({
  theme = 'hyper',
  config = {
    packages = {
      enable = true,
    },
    projects = {
      enable = true,
      limit = 8,
      icon = ' ',
      label = 'Projects',
      action = 'Telescope projects cwd='
    },
    mru = {
      enable = true,
      limit = 8,
      icon = ' ',
      label = 'Recent files',
      action = 'Telescope oldfiles',
      cwd_only = false,
    },
    footer = {
      enable = true,
      content = '󰊳 Update |  Files |  Apps |  dotfiles',
    },
    week_header = {
      enable = true,
    },
    shortcut = {
      { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
      {
        icon = ' ',
        icon_hl = '@variable',
        desc = 'Files',
        group = 'Label',
        action = 'Telescope find_files',
        key = 'f',
      },
      {
        desc = ' Apps',
        group = 'DiagnosticHint',
        action = 'Telescope app',
        key = 'a',
      },
      {
        desc = ' dotfiles',
        group = 'Number',
        action = 'Telescope dotfiles',
        key = 'd',
      },
    },
  },
})
