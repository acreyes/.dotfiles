return {
   "ThePrimeagen/git-worktree.nvim",
   dependencies = { "nvim-telescope/telescope.nvim" },
   keys = {
      { "<leader>nwt", function() require("telescope").extensions.git_worktree.create_git_worktree() end, desc = "Create git worktree" },
      { "<leader>pwt", function() require("telescope").extensions.git_worktree.git_worktrees() end, desc = "List git worktrees" },
   },
   config = function()
      require("git-worktree").setup({
         change_directory_command = "cd",
         update_on_change =  true,
         update_on_change_command = "e .",
         clearjumps_on_change = true,
         autopush = false,
      })

      require("telescope").load_extension("git_worktree")
   end
}
