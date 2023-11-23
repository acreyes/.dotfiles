-- install debuggers
--
require("mason-nvim-dap").setup({
    ensure_installed = { "codelldb", "cppdbg" }
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
    command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
    args = {"--port", "13000"},
  }
}

require('dap').configurations.cpp = {
	lldb -- different debuggers or more configurations can be used here
}

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = vim.fn.stdpath('data') .. '/' .. 'mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}

vim.keymap.set("n", "<leader>dc", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<leader>dso", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<leader>dsi", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<leader>dss", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
