return {
    -- Welcome screen
    {
        "mhinz/vim-startify",
        config = function()
            vim.g.startify_lists = {
                { type = "files", header = { "   Files" } },
                { type = "dir", header = { "   Current Directory " .. vim.fn.getcwd() } },
                { type = "sessions", header = { "   Sessions" } },
                { type = "bookmarks", header = { "   Bookmarks" } },
            }
        end,
    },
    -- CSV viewer
    { "chrisbra/csv.vim", ft = "csv" },
    -- REPL
    { "urbainvaes/vim-ripple" },
    -- Formatter
    {
        "mhartington/formatter.nvim",
        config = function()
            require("formatter").setup({
                filetype = {
                    python = {
                        function()
                            return { exe = "black", args = { "-q", "-" }, stdin = true }
                        end,
                    },
                },
            })
        end,
    },
    -- Markdown
    {
        "plasticboy/vim-markdown",
        ft = { "markdown", "pandoc" },
        dependencies = { "godlygeek/tabular" },
    },
    -- Python indentation
    { "Vimjas/vim-python-pep8-indent", ft = "python" },
    -- Black formatter
    { "psf/black", ft = "python" },
}
