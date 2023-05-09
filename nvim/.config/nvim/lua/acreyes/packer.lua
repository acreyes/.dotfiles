-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
vim.cmd.packadd('packer.nvim')

    return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use { 'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            { "nvim-telescope/telescope-live-grep-args.nvim" },
        },
        config = function()
            require("telescope").load_extension("live_grep_args")
        end
    }

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })

    use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use( 'nvim-treesitter/playground')
    use( 'nvim-treesitter/nvim-treesitter-context' )
    use( 'ThePrimeagen/harpoon')
    use( 'mbbill/undotree')
    use( 'tpope/vim-fugitive')
    use( 'tpope/vim-surround')
    use( 'tpope/vim-commentary')
    use( 'Civitasv/cmake-tools.nvim')
    use( 'mfussenegger/nvim-dap')
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use "folke/neodev.nvim"
    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    }
    use ("jay-babu/mason-nvim-dap.nvim")
    use( 'vim-pandoc/vim-pandoc')
    use( 'vim-pandoc/vim-pandoc-syntax')
    use( 'christoomey/vim-tmux-navigator')
    use ('vim-scripts/DoxygenToolkit.vim')

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
            'williamboman/mason.nvim',
            run = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
        }
    }

    use ('lervag/vimtex')

    -- install without yarn or npm
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use ({"/Users/adamreyes/Documents/research/repos/github/flash.nvim"})

    use('czheo/mojo.vim')
    use('ThePrimeagen/git-worktree.nvim')

    use({
       "L3MON4D3/LuaSnip",
       -- follow latest release.
       tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
       -- install jsregexp (optional!:).
       run = "make install_jsregexp"
    })



-- install without yarn or npm
use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
})

use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

  end)
