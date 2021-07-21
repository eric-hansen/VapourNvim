Vapour.utils.plugins.add_user({'hoob3rt/lualine.nvim'})
Vapour.utils.plugins.add_user({'kyazdani42/nvim-web-devicons'})

require('lualine').setup{
  options = {
    theme = Vapour.settings.colorscheme
  }
}
