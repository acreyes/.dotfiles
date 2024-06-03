return {
   "nvim-telescope/telescope.nvim",
   tag = "0.1.5",
   dependencies = {
      {'nvim-lua/plenary.nvim'},
      { "nvim-telescope/telescope-live-grep-args.nvim" },
   },
   config = function ()
      require('telescope').setup({})
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
      vim.keymap.set('n', '<C-p>', builtin.git_files, {})
      vim.keymap.set('n', '<leader>h', builtin.help_tags)
      require("telescope").load_extension("live_grep_args")
      require("acreyes.plugins.telescope.telescope_live-grep-args")
   end
}
