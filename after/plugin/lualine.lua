require('lualine').setup({
  options = {
    theme = 'catppuccin',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    refresh = {
      tabline = 1000
    }
  },
  sections = {
    lualine_b = {},
    lualine_c = {'filename', 'diff'}
  },
  tabline = {
    lualine_y = {'branch'}
  }
})
