require('lualine').setup({
  options = {
    theme = 'solarized_dark',
    component_separators = { left = '', right = ''},
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
