local opt = vim.opt
local g = vim.g

-- Leader keys (must be set before lazy.nvim)
g.mapleader = " "
g.maplocalleader = " "

-- Python host (auto-detect for portability)
local python = vim.fn.exepath("python3")
if python ~= "" then
    g.python3_host_prog = python
end

-- Disable netrw (nvim-tree replaces it)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Encoding
opt.encoding = "utf-8"

-- Line numbers
opt.relativenumber = true
opt.number = true

-- Tabs & indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.incsearch = true
opt.smartcase = true

-- UI
opt.termguicolors = true
opt.showmatch = false
opt.hidden = true
opt.errorbells = false
opt.wrap = false
opt.scrolloff = 4
opt.cmdheight = 2
opt.updatetime = 50
opt.colorcolumn = "80"
opt.laststatus = 3
opt.showmode = false
opt.splitbelow = true
opt.splitright = true
opt.completeopt = { "menuone", "noselect" }

-- Files
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true

-- Folds
opt.viewoptions:remove("options")

-- Conceal (for LaTeX)
opt.conceallevel = 1
