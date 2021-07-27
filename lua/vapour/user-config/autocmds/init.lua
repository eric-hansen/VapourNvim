local mappings = {
  freedom = {
    profile = "dev-freedom",
    remote_dir_root = "/var/www/html/freedom",
  }
}

local M = {
  exec = {}
}

M.exec.output_handler = function(err, data)
  if err then print ('Sync error: ' .. err) else print('Sync success') end
end

M.exec.run = function(cmd, args)
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)

  -- Global variable due to schedule wrapper
  _exec_run_handler = vim.loop.spawn(cmd, {
    args = args or {},
    stdio = {nil, stdout, stderr}
  }, vim.schedule_wrap(function()
    stdout:read_stop()
    stderr:read_stop()
    stdout:close()
    stderr:close()
    _exec_run_handler:close()
  end)
  )

  vim.loop.read_start(stdout, M.exec.output_handler)
  vim.loop.read_start(stderr, M.exec.output_handler)
end

M.sync = function()
  local paths = {
    relative = vim.fn.expand('%'),
    absolute = vim.fn.expand('%:p'),
  }

  for key, config in pairs(mappings) do
    if string.match(paths.absolute, '.*' .. key .. '.*') then
      print('Attemping to sync ' .. paths.relative .. ' to ' .. config.profile)
      M.exec.run('scp', {paths.absolute, config.profile .. ':' .. config.remote_dir_root .. '/' .. paths.relative})
      return true
    end
  end
end

return M

