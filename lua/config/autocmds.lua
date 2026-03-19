local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank (replaces vim-highlightedyank)
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})

-- Wrap settings per filetype
augroup("WrapSettings", { clear = true })
autocmd("FileType", {
    group = "WrapSettings",
    pattern = { "c", "cpp" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.textwidth = 80
    end,
})
autocmd("FileType", {
    group = "WrapSettings",
    pattern = { "vim", "sh", "python", "make", "text" },
    callback = function()
        vim.opt_local.wrap = false
    end,
})
autocmd("FileType", {
    group = "WrapSettings",
    pattern = { "tex", "latex", "context", "plaintex" },
    callback = function()
        vim.opt_local.wrap = true
    end,
})

-- Remember folds
augroup("RememberFolds", { clear = true })
autocmd("BufWinLeave", {
    group = "RememberFolds",
    pattern = "*.*",
    callback = function()
        if vim.bo.filetype ~= "help" then
            vim.cmd("mkview")
        end
    end,
})
autocmd("BufWinEnter", {
    group = "RememberFolds",
    pattern = "*.*",
    callback = function()
        if vim.bo.filetype ~= "help" then
            vim.cmd("silent! loadview")
        end
    end,
})

-- Python fold method
autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.py",
    callback = function()
        vim.opt_local.foldmethod = "indent"
    end,
})

-- Black format on save
autocmd("BufWritePre", {
    pattern = "*.py",
    callback = function()
        vim.cmd("silent! Black")
    end,
})
