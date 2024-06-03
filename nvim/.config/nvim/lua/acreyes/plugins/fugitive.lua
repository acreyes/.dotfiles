return {
   "tpope/vim-fugitive",
   config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
      vim.opt.diffopt:append('vertical')
   end
}
