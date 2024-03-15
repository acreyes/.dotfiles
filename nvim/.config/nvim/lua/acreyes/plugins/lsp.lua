return {
   {
      "VonHeikemen/lsp-zero.nvim",
      branch = 'v3.x',
      dependencies = {
         "neovim/nvim-lspconfig",
         "williamboman/mason-lspconfig.nvim",
         "williamboman/mason.nvim",
         "hrsh7th/cmp-nvim-lsp",
         "L3MON4D3/LuaSnip",
         "hrsh7th/nvim-cmp",
      },
      config = function()
         -- gives a default lsp configuration so I don't have to set it up
         local lsp = require("lsp-zero")

         lsp.preset("recommended")

         require('mason').setup({})
         require('mason-lspconfig').setup({
            -- Replace the language servers listed here 
            -- with the ones you want to install
            ensure_installed = {
               'jedi_language_server',
               'cmake',
               'clangd',
               'fortls',
               'lua_ls'
            },
            handlers = {
               function(server_name)
                  require('lspconfig')[server_name].setup({})
               end,
            },
         })
         -- Fix Undefined global 'vim'
         require('lspconfig').lua_ls.setup {
            settings = {
               Lua = {
                  workspace = {
                     checkThirdParty = false,
                  },
               },
            },
         }


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

         cmp.setup({
            mapping = cmp_mappings
         })
         -- lsp.setup_nvim_cmp({
         --    mapping = cmp_mappings
         -- })

         lsp.set_preferences({
            suggest_lsp_servers = false,
            sign_icons = {
               error = 'E',
               warn = 'W',
               hint = 'H',
               info = 'I'
            }
         })

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

         lsp.setup()

         vim.diagnostic.config({
            virtual_text = true
         })

         for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
            vim.api.nvim_set_hl(0, group, {})
         end

         vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = {'*.hxx', '*.hpp', '*.cxx', '*.cpp'},
            callback = function(args)
               vim.lsp.buf.format({ async = false })
            end,
         })
      end
   }
}
