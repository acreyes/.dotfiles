-- install debuggers
--
require("mason-nvim-dap").setup({
    ensure_installed = { "codelldb" }
})
local lldb = {
	name = "Launch lldb",
	type = "codelldb", -- matches the adapter
	request = "launch", -- could also attach to a currently running process
	program = function()
		return vim.fn.input(
			"Path to executable: ",
			vim.fn.getcwd() .. "/",
			"file"
		)
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	args = {},
	runInTerminal = false,
}

local dap = require('dap')

dap.adapters.codelldb = {
  type = 'server',
  -- host = '127.0.0.1',
  port = "13000",
  executable = {
    command = '/Users/adamreyes/.local/share/nvim/mason/bin/codelldb',
    args = {"--port", "13000"},
  }
}

require('dap').configurations.cpp = {
	lldb -- different debuggers or more configurations can be used here
}
