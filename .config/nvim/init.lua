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
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { 'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = { 'nvim-lua/plenary.nvim' } },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "fatih/vim-go" },
    { "github/copilot.vim" },
}
local opts = {}
require("lazy").setup(plugins, opts)

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "tsserver", "clangd" },
})
require("lspconfig").tsserver.setup {}
require("lspconfig").clangd.setup {}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil -- disable semantic syntax highlighting

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- vim.keymap.set('i', '<C-å>', vim.lsp.buf.completion, opts)
    vim.keymap.set('n', '<space>q', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


local builtin = require("telescope.builtin")
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>p', builtin.find_files, {})
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})

local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = { "go" },
    highlight = { enabled = false },
    indent = { enabled = true }
})

-- options
vim.cmd("set termguicolors")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")
vim.cmd("set noswapfile")
vim.cmd("set cursorline")
vim.cmd("set relativenumber")
vim.cmd("set guicursor=n-v-c-i:block")
vim.cmd("set scrolloff=10")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")
vim.cmd("command W w")

-- keybindings
vim.cmd("nnoremap € $")
vim.keymap.set('n', 'tt', 'Vyp', {})
vim.keymap.set('n', 'tk', '_i//<escape>', {})
vim.keymap.set('n', '<leader>sd', vim.diagnostic.open_float, {})
-- yank to system clipboard
-- vim.keymap.set('n', '<leader>y', '"+y', {})
-- vim.keymap.set('n', '<leader>p', '"+p', {})

-- theme
vim.cmd.colorscheme "catppuccin"
vim.cmd("hi! Normal guibg=#000000 guifg=#e8e8e8")

-- statusline 
local function git_branch()
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    if string.len(branch) > 0 then
        return branch
    else
        return " "
    end
end

local function statusline()
    local set_color_1 = "%#DiffText#"
    local branch = git_branch()
    local set_color_2 = "%#StatusLine#"
    local file_name = " %f"

    return string.format(
        "%s %s %s%s",
        set_color_1,
        branch,
        set_color_2,
        file_name
    )
end
vim.opt.statusline = statusline()
