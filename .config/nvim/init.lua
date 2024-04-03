-- load package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { "EdenEast/nightfox.nvim" },
    { 'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = { 'nvim-lua/plenary.nvim' } },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "fatih/vim-go" },
    { "github/copilot.vim" },
}
local opts = {}

require("lazy").setup(plugins, opts)

local builtin = require("telescope.builtin")

vim.g.mapleader = " "
vim.keymap.set('n', '<leader>p', builtin.find_files, {})
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})

local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = { "go" },
    highlight = { enabled = true },
    indent = { enabled = true }
})


vim.cmd.colorscheme "carbonfox"

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")
vim.cmd("set noswapfile")
vim.cmd("set cursorline")
vim.cmd("nnoremap € $")
vim.cmd("set relativenumber")
vim.cmd("set rnu")
