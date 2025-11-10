return {
   {
      "VonHeikemen/lsp-zero.nvim",
      branch = 'v3.x',
      lazy = false,  -- Load at startup, no lazy loading
      priority = 100,  -- Load early
      dependencies = {
         "neovim/nvim-lspconfig",
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/nvim-cmp",
      },
      config = function()
         local lsp = require("lsp-zero")

         -- Configure nvim-cmp
         local cmp = require('cmp')
         local cmp_select = {behavior = cmp.SelectBehavior.Select}
         local cmp_mappings = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
         })

         cmp_mappings['<Tab>'] = nil
         cmp_mappings['<S-Tab>'] = nil
         cmp.setup({ mapping = cmp_mappings })

         -- Set sign icons
         lsp.set_sign_icons({ error = 'E', warn = 'W', hint = 'H', info = 'I' })

         -- CRITICAL: Setup keybindings via on_attach
         lsp.on_attach(function(client, bufnr)
            local opts = {buffer = bufnr, remap = false}
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
         end)

         -- CRITICAL: This extends lspconfig to use lsp-zero's on_attach
         lsp.extend_lspconfig()

         -- NOW configure LSP servers (they will use the on_attach callback above)
         -- Servers are already installed in ~/.local/share/nvim/mason/bin/
         require('lspconfig').lua_ls.setup {
            settings = {
               Lua = {
                  workspace = {
                     checkThirdParty = false,
                  },
               },
            },
         }
         
         require('lspconfig').ruff.setup {}
         require('lspconfig').pyright.setup {}
         require('lspconfig').clangd.setup {}
         require('lspconfig').cmake.setup {}
         require('lspconfig').fortls.setup {}

         vim.diagnostic.config({ virtual_text = true })

         for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
            vim.api.nvim_set_hl(0, group, {})
         end

         vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', {noremap=true, silent=true})
         vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = {"*.py", "*.hpp", "*.cpp"},
            callback = function(args)
               vim.lsp.buf.format({ async = false })
            end,
         })
      end
   },
   -- Mason as separate lazy-loaded plugin for server management
   {
      "williamboman/mason.nvim",
      cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
      dependencies = {
         "williamboman/mason-lspconfig.nvim",
      },
      config = function()
         require('mason').setup({})
         require('mason-lspconfig').setup({
            ensure_installed = { 'ruff', 'pyright', 'cmake', 'clangd', 'fortls', 'lua_ls' },
         })
      end
   }
}
