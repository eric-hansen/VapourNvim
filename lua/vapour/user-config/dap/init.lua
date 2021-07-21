local dap = Vapour.utils.plugins.require('dap')
local dapui = Vapour.utils.plugins.require('dapui')

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/home/ehansen/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003
  }
}

dapui.setup({
  icons = {
    expanded = "▾",
    collapsed = "▸"
  },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = {"<CR>", "<2-LeftMouse>"},
    open = "o",
    remove = "d",
    edit = "e",
  },
  sidebar = {
    open_on_start = true,
    elements = {
      -- You can change the order of elements in the sidebar
      "scopes",
      "breakpoints",
      "stacks",
      "watches"
    },
    width = 40,
    position = "left" -- Can be "left" or "right"
  },
  tray = {
    open_on_start = false,
    elements = {
      "repl"
    },
    height = 10,
    position = "bottom" -- Can be "bottom" or "top"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil   -- Floats will be treated as percentage of your screen.
  }
})

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

Vapour.plugins.which_key.user_defined.d = {
    name = "DAP Debugger",
    b = {
      name = "Breakpoints",
      t = {":lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint"},
      c = {":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Conditional Breakpoint"},
      l = {":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", "Log Point Breakpoint"},
    },
    r = {":lua require'dap'.repl.open()<cr>", "Open RPEL"},
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    u = {
      name = "UI",
      t = {':lua require("dapui").toggle()<cr>', 'Toggle'},
    }
}

vim.cmd[[
    nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
    nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
    nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
    nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
]]
