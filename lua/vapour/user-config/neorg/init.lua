Vapour.utils.plugins.add_user({
  "vhyrro/neorg",
    config = function()
        require('neorg').setup {
            -- Tell Neorg what modules to load
            load = {
                ["core.defaults"] = {}, -- Load all the default modules
                ["core.norg.concealer"] = {}, -- Allows for use of icons
                ["core.norg.dirman"] = { -- Manage your directories with Neorg
                    config = {
                        workspaces = {
                            main = "~/.neorg"
                        },
                        autodetect = true,
                        autochdir = true,
                    }
                }
            },
        }
    end,
    requires = "nvim-lua/plenary.nvim"
})

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/vhyrro/tree-sitter-norg",
        files = { "src/parser.c" },
        branch = "main"
    },
}

Vapour.plugins.compe.sources.neorg = true
