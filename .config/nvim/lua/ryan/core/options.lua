-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.swapfile = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.cursorline = true

-- synchronizes the system keyboard
-- with neovims clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt.scrolloff = 999

vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true

vim.g.mapleader = " "
-- vim.g.mapleader = "<Space>"

-- this will clear the search results highlighted. 
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
