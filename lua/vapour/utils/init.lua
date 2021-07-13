-- Utility functions to help with various uses
local packadd_plugin = function (p)
  vim.cmd('packadd! ' .. p)
end

local require_plugin = function (p)
  local ok, plugin = pcall(require, p)
  if ok then return plugin else return nil end
end

local plugin_exists = function (p)
  local plugin = require_plugin(p)

  return plugin == nil
end

Vapour.utils = {
  file = {
    exists = function(file)
        local fp = io.open(file, "r")
        if fp ~= nil then
            io.close(fp)
            return true
        else
            return false
        end
    end,
    create = function(user_config)
        local fp, err = io.open(user_config, 'w+')
        assert(fp, err)
        fp:write('')
        fp:close()
    end
  },
  plugins = {
    require = require_plugin,
    packadd = packadd_plugin,
    exists = plugin_exists,

    -- Allows us to require packages in vapour-user-config
    -- without throwing exceptions if the package don't exist
    -- Optionally you can run this like some/package to add it
    -- to the Vapour.packages.user table for installation.
    --
    -- mod_name - Name to pass into require()
    -- pkg - The name to pass into Packer (i.e.: <username>/<repo>)
    -- conf - Any configurations to pass into Packer
    require_if_installed = function(mod_name, pkg, conf)
      assert(mod_name, 'Module name is needed for require()')

      local packer_ref = pkg or '' -- In case we are only passed in mod_name
      local user, repo = string.match(packer_ref, "(.*)/(.*)")
      local packer_conf = conf or {}
      local pkg_is_git = true

      if not repo then pkg_is_git = false end

      local plugin = plugin_exists(mod_name)

      if plugin ~= nil then
        return plugin
      elseif pkg_is_git then
        table.insert(Vapour.plugins.user, {packer_ref, conf})
        return nil
      end
    end,
  },
}

