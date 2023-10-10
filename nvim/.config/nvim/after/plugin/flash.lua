local fl = require("flash")
local ui = require("flash.ui")
local prompt = require("flash.prompt")
local buf = require("flash.buffers")

local FLASH_DIR = os.getenv('FLASH_DIR')
fl.init(FLASH_DIR)

vim.keymap.set("n", "<leader><leader>k", buf.kill_all)
vim.keymap.set("n", "<leader>si", buf.send_stdin)
vim.keymap.set("n", "<leader>fj", buf.toggle_win)
vim.keymap.set("n", "<leader>ps", prompt.pickSim)
vim.keymap.set("n", "<leader>pr", prompt.pickRun)
vim.keymap.set("n", "<leader>po", prompt.pickObj)
vim.keymap.set("n", "<leader>sh", prompt.switch)


