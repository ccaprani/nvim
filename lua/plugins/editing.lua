return {
    -- Surround text objects
    { "tpope/vim-surround" },
    -- Better repeat with plugins
    { "tpope/vim-repeat" },
    -- Pairs of mappings (prev/next)
    { "tpope/vim-unimpaired" },
    -- Treesitter-aware commenting (replaces vim-commentary)
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("Comment").setup()
        end,
    },
    -- Auto-closing brackets (replaces jiangmiao/auto-pairs)
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
}
