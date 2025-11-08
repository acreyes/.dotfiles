return {
   "tpope/vim-fugitive",
   cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
   keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
   },
   config = function()
      vim.opt.diffopt:append('vertical')
   end
}
