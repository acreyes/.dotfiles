local fl = require("flash")
local ui = require("flash.ui")
local prompt = require("flash.prompts")
local buf = require("flash.buffers")

local maps = {}
maps["<leader><leader>k"] =  buf.kill_all
maps["<leader>si"]        =  buf.send_stdin
maps["<leader>fj"]        =  buf.toggle_win
maps["<leader>ps"]        =  prompt.pickSim
maps["<leader>pr"]        =  prompt.pickRun
maps["<leader>po"]        =  prompt.pickObj
maps["<leader>sh"]        =  prompt.switch
maps["<leader>sr"]        =  prompt.switchRD
maps["<leader>es"]        =  prompt.editSetup
for map, bind in pairs(maps) do
    vim.keymap.set("n", map, bind)
end

local reload = function()
    require("plenary.reload").reload_module('flash')
    fl = require("flash")
    ui = require("flash.ui")
    prompt = require("flash.prompts")
    buf = require("flash.buffers")
    fl.init({FLASH = vim.fn.getcwd()})
    maps["<leader><leader>k"] =  buf.kill_all
    maps["<leader>si"]        =  buf.send_stdin
    maps["<leader>fj"]        =  buf.toggle_win
    maps["<leader>ps"]        =  prompt.pickSim
    maps["<leader>pr"]        =  prompt.pickRun
    maps["<leader>po"]        =  prompt.pickObj
    maps["<leader>sh"]        =  prompt.switch
    maps["<leader>sr"]        =  prompt.switchRD
    maps["<leader>es"]        =  prompt.editSetup
    for map, bind in pairs(maps) do
        vim.keymap.set("n", map, bind)
    end
end

vim.api.nvim_create_user_command('Flaunch',
    function(opts)
        reload()
        local WorkTree = require("git-worktree")
        WorkTree.on_tree_change(
            function(op, metadata)
                if op == WorkTree.Operations.Switch then
                    print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
                    reload()
                end
            end
        )
    end,
    {nargs=0,
})

-- local FLASH_DIR = os.getenv('FLASH_DIR')
-- fl.init({FLASH=os.getenv('FLASH_DIR')})



