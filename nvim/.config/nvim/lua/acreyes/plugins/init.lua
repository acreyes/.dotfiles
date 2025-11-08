return {
   "nvim-lua/plenary.nvim",
   {
      "mbbill/undotree",
      cmd = "UndotreeToggle",
      keys = {
         { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
      },
   },
   {
      "tpope/vim-surround",
      keys = {
         { "ys", mode = "n" },
         { "ds", mode = "n" },
         { "cs", mode = "n" },
         { "S", mode = "x" },
      },
   },
   {
      "tpope/vim-commentary",
      keys = {
         { "gc", mode = { "n", "v" } },
         { "gcc", mode = "n" },
      },
   },
   -- "Civitasv/cmake-tools.nvim",
   -- "vim-pandoc/vim-pandoc",
   -- "vim-pandoc/vim-pandoc-syntax",
   -- "vim-scripts/DoxygenToolkit.vim",
   -- {
   --    "iamcco/markdown-preview.nvim",
   --    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
   --    ft = { "markdown" },
   --    build = function() vim.fn["mkdp#util#install"]() end,
   -- },
   {
      'rose-pine/neovim',
      name = 'rose-pine',
      lazy = false,
      priority = 1000,
      config = function()
         vim.cmd('colorscheme rose-pine')
         vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
      end
   },
   -- {
   -- "vim-scripts/cpp_doxygen",
   -- config = function()
   --    vim.keymap.set("n", "<leader>d", "<Plug>cpp_doxygenInsert")
   --    vim.g.cpp_doxygen_style = "exclamation"
   --    vim.g.cpp_doxygen_command_mark = "@"
   -- end
-- }
   -- { 
   --    "danymat/neogen", 
   --    config = true,
   --    -- Uncomment next line if you want to follow only stable versions
   --    -- version = "*" 
   -- },
}
