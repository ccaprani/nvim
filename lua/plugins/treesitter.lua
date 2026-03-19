return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "markdown", "python", "c", "cpp", "lua", "vim", "vimdoc", "latex" },
            highlight = {
                enable = true,
                disable = { "latex" },
                additional_vim_regex_highlighting = { "latex", "markdown" },
            },
        })
    end,
}
