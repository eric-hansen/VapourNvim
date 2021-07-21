Vapour.utils.plugins.add_user({'folke/tokyonight.nvim'})
Vapour.utils.plugins.add_user({'nacro90/numb.nvim', {config = function() require'numb'.setup{show_numbers = false} end}})

Vapour.settings.colorscheme = 'tokyonight'

-- Example config in Lua
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = false
vim.g.tokyonight_italic_comments = false
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

-- Load the colorscheme
vim.cmd[[colorscheme tokyonight]]
