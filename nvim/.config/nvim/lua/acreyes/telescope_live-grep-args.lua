local telescope = require("telescope")
local custom_pickers = require("acreyes.telescop_custom_pickers")

vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set('n', '<leader>ff', custom_pickers.live_grep)

telescope.setup {
    pickers = {
        oldfiles = {
            sort_lastused = true,
            cwd_only = true,
        },
        live_grep = {
            path_display = { 'shorten' },
            mappings = {
                i = {
                    ['<c-f>'] = custom_pickers.actions.set_extension,
                    ['<c-l>'] = custom_pickers.actions.set_folders,
                },
            },
        },
    },
}
