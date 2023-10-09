local fl = require("flash")
local buf = require("flash.buffers")

local FLASH_DIR = os.getenv('FLASH_DIR')
fl.init(FLASH_DIR)

vim.keymap.set("n", "<leader>sh", fl.setup)
vim.keymap.set("n", "<leader>ch", fl.compile)
vim.keymap.set("n", "<leader>rh", fl.run)
vim.keymap.set("n", "<leader><leader>k", buf.kill_all)
vim.keymap.set("n", "<leader>si", buf.send_stdin)

