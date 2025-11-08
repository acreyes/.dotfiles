return {
   "ThePrimeagen/harpoon",
   keys = {
      { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Harpoon add file" },
      { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon menu" },
      { "<C-j>", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon file 1" },
      { "<C-k>", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon file 2" },
      { "<C-l>", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon file 3" },
      { "<C-;>", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon file 4" },
      { "<C-f>", function() require("harpoon.ui").nav_file(5) end, desc = "Harpoon file 5" },
   },
}
