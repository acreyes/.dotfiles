return {
   "nvim-telescope/telescope.nvim",
   tag = "0.1.5",
   cmd = "Telescope",
   keys = {
      { "<leader>pf", function() require('telescope.builtin').find_files() end, desc = "Find files" },
      { "<C-p>", function() require('telescope.builtin').git_files() end, desc = "Find git files" },
      { "<leader>h", function() require('telescope.builtin').help_tags() end, desc = "Help tags" },
   },
   dependencies = {
      {'nvim-lua/plenary.nvim'},
      { "nvim-telescope/telescope-live-grep-args.nvim" },
   },
   config = function ()
      require('telescope').setup({})
      require("telescope").load_extension("live_grep_args")
      require("acreyes.plugins.telescope.telescope_live-grep-args")
   end
}
