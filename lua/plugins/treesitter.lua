return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = { "markdown", "python", "c", "cpp", "lua", "vim", "vimdoc", "latex" },
        })

        -- Disable treesitter highlighting for latex (vimtex handles it)
        -- Enable additional vim regex highlighting for latex and markdown
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "tex", "latex" },
            callback = function(args)
                vim.treesitter.stop(args.buf)
            end,
        })
    end,
}
