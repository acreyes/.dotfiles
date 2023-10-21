require("git-worktree").setup({
    change_directory_command = "cd",
    update_on_change =  true,
    update_on_change_command = "e .",
    clearjumps_on_change = true,
    autopush = false,
})

local twt = require("telescope").load_extension("git_worktree")
vim.keymap.set("n", "<leader>nwt", twt.create_git_worktree)
vim.keymap.set("n", "<leader>pwt", twt.git_worktrees)

