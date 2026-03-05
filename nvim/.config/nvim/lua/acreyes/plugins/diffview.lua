return {
   "sindrets/diffview.nvim",
   cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
   keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview file history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview repo history" },
   },
   config = function()
      require("diffview").setup({
         use_icons = false,
         view = {
            merge_tool = {
               layout = "diff3_mixed",
            },
         },
      })
   end,
}
