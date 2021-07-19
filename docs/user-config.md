User Configuration
====================

To allow custom user configurations edit the `./lua/vapour/user-config/init.lua` file.

The order of loading is as follows:

- `./lua/vapour/init.lua`
- `./lua/vapour/options.lua`
- `./lua/vapour/user-config/init.lua`
- `./lua/vapour/plugins/init.lua`
- `./lua/vapour/keybindings/init.lua`

This is important because this means that while Vapour's default options, config, etc... is loaded in we can easily modify it to our tastes.

## Helpers

There's helpers kind of spread throughout the project, which are outlined below.  These are also exposed to the user config, which will be demonstrated further on.

Each item is a sub-property of the parent, so `file.create` is actually referenced as `Vapour.utils.file.create`.

### Vapour.utils

- `file.create` : Creates a file, taking in the path + filename
- `file.exists` : True if the passed in file exists, false if not (simply checks to see if the file is readable)
- `plugins.require` : If a plugin is being `require'...'`'ed then check to see if it's enabled, and if not or if the module isn't able to be loaded, return `nil` otherwise the module/plugin
- `plugins.packadd` : If a plugin is lazy-loaded they must be passed in to `packadd!`, which this serves as a wrapper for
- `plugins.exists` : Sugar to say `if not Vapour.utils.plugins.exists('something') then ... end` more often than not
- `plugins.which_key` : Define a `which_key` mapping, often for plugins
- `plugins.add_user` : For user-defined plugins, simply pass in like you would to Packer (`plugins.add_user {'some/plugin', {config...}}`) which can then be installed via `:PackerSync`
- `plugins.require_if_installed` : Tries to laod in a module, and if it can't then if it's passed in as `<user>/<repo>` then it will add it to the list of user plugins

## How To Configure Vapour

The defaults are sane, however below will illustrate different ways to customize Vapour.

### Enable A plugin

By default most plugins are disabled for performance reasons (i.e.: not everyone using this needs to have a Markdown previewer enabled).  To enable a Vapour-defined plugin simply set it's `enabled` property to non-falsy:

```
Vapour.plugins.toggleterm.enabled = true
```

This will then let you sync your plugins and install it if it was not so previously.

If you want to define multiple elements of the plugin (see `./lua/vapour/plugins/init.lua`) you can do so like this:

```
Vapour.plugins.telescope = {
  enabled = true,
  which_key = {
    root = 'f',
    definitions = {
      z = {':Telescope file_browser<cr>', 'File Browser'}
    }
  }
}
```

This will make the plugin enabled and also define a `which_key` table for it.

### User-Defined Plugins

The chances are you will at some point want to have plugins installed that Vapour doesn't have defined.  You can either submit a PR for the plugin, or define it yourself as a user plugin:

```
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
```

The above demonstrates how to define plugins regularly and for any special set ups needed.  What happens under the hood is each entry will simply be passed to `packer.use` so if you want to know what options are available for a plugin please see the documentation for Packer.

### Configure Packer

Since Packer is loaded in **after** the user config is, you can customize how Packer works as well.  Currently you can pass in configuration changes to `Vapour.plugins.packer.init` like so:

```
Vapour.plugins.packer.init.display = {
  open_fn = function()
    return Vapour.utils.plugins.require('packer.util').float { border = "single" }
  end
}
```

This will give a floating window with a border to Packer instead of popping up in a new window.

Again, anything that you can pass into `packer.init` can be defined here.

### Custom which_key options

Vapour uses `which_key` as a sort of menu system and to remember what keys are mapped to which action.  You are also able to define your own as well:

```
Vapour.plugins.which_key.user_defined.p = {
  name = "Plugins",
  s = {":PackerSync<cr>", "Sync"},
  u = {":PackerUpdate<cr>", "Update"},
}
```

Now when you do `<leader>p` you'll be prompted to either `s`ync or `u`pdate Packer.

You can also do this on a deeper level:

```
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
```

This will not only give me `<leader>z` to toggle with `z` but also if I choose `<leader>zt` I'm presented with an option to toggle `Twilight` plugin for zen mode.

The definition for `which_key` looks like this:

```
which_key = {
  name = "Name to display on menu",
  root = "", -- This will be the key after <leader> to activate the option
  definitions = {
    z = {':SomeAction<cr>', 'Description'},
    t = {
      name = 'Sub-menu for this which_key',
      t = {':AnotherAction<cr>', 'Description for this action'}
    }
  }
}
```

In the example above, `z` and `t` can be any keys.  If it's something special like `/` then you would wrap it around `'` instead (i.e.: `'/'`).

## Organization

You can also organize your user configs into sub-folders.

For example, if you wanted to define a colorscheme but not clutter up your `init.lua` file, you can create a folder or file within `./lua/vapour/user-config` and then `require` it.

Going with the exmple of a custom colorscheme, assuming the folder is `theme` and located in the `user-config` directory, then in your `init.lua` file you just do this:

```
require 'vapour.user-config.theme'
```

`.` or `/` are acceptable here but `.` is the convention.

You can then set your theme-specific configuration in `./lua/vapour/user-config/theme/init.lua`.  Below is an example:

```
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
```

You could also put this in `lua/vapour/user-config/theme.lua`, it's a matter of preference.
