vim.opt.guicursor = ""
vim.opt.mouse = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 3
vim.opt.softtabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase= true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "132"
vim.g.fortran_do_enddo=1

vim.api.nvim_create_autocmd('Filetype', {
   pattern = 'fortran',
   callback = function()
      vim.opt.formatprg = "fprettify --silent"
   end
})

vim.api.nvim_create_autocmd('Filetype', {
   pattern = 'c,cpp',
   callback = function()
      vim.bo.commentstring = '// %s'
   end
})

-- autocmd Filetype fortran setlocal formatprg=fprettify\ --silent

-- Disable unused providers (saves ~230ms startup time)
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
