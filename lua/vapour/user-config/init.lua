Vapour.language_servers.sumneko = {
  enabled = true,
  root_path = '/home/ehansen/.config/nvim/ls/lua-language-server',
  binary_path = '/home/ehansen/.config/nvim/ls/lua-language-server/bin/Linux/lua-language-servr'
}

Vapour.plugins.bufferline.enabled = true
Vapour.plugins.toggleterm.enabled = true
Vapour.plugins.markdown_preview.enabled = true
Vapour.plugins.compe.enabled = true

Vapour.plugins.telescope = {
  enabled = true,
  which_key = {
    root = 'f',
    definitions = {
      z = {':Telescope file_browser<cr>', 'File Browser'}
    }
  }
}

Vapour.plugins.rainbow_parentheses.enabled = true

Vapour.plugins.zenmode = {
  enabled = true,
  which_key = {
    name = "Zen Mode",
    root = 'z',
    definitions = {
      z = {':ZenMode<cr>', 'Toggle'},
      t = {
        name = 'Twilight',
        t = {':Twilight<cr>', 'Toggle'},
      }
    }
  }
}

Vapour.plugins.which_key.allow_override_mappings = true

Vapour.plugins.user = {
  {'folke/lua-dev.nvim'},
  {'mfussenegger/nvim-dap', {opt=true}},
  {'rcarriga/nvim-dap-ui', {opt=true}},
  {'vim-test/vim-test'},
  {'kdheepak/lazygit.nvim'},
  {'folke/zen-mode.nvim', {config = function() require('zen-mode').setup {} end}},
  {"folke/twilight.nvim", {config = function() require('twilight').setup {} end}},
  {'TaDaa/vimade'}
}

Vapour.plugins.packer.init.display = {
  open_fn = function()
    return Vapour.utils.plugins.require('packer.util').float { border = "single" }
  end
}

Vapour.plugins.which_key.user_defined.p = {
  name = "Plugins",
  s = {":PackerSync<cr>", "Sync"},
  u = {":PackerUpdate<cr>", "Update"},
}

require('vapour/user-config/dap')
require('vapour.user-config.testing')
require('vapour.user-config.git')
require('vapour.user-config.theme')
require('vapour.user-config.lualine')
require('vapour.user-config.neorg')

vim.cmd [[
autocmd! BufWritePost * :lua require 'vapour.user-config.autocmds'.sync()
]]
vim.cmd[[autocmd! BufReadPost,FileReadPost lua require "lsp_signature".on_attach()]]
--Vapour.utils.plugins.require_if_installed('vapour.user-config.autopairs')
