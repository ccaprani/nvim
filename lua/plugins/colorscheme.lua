return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        require("gruvbox").setup({
            contrast = "hard",
            invert_selection = false,
            italic = {
                strings = true,
                emphasis = true,
                comments = true,
            },
            overrides = {
                Conceal = { bg = "NONE" },
                ColorColumn = { bg = "#3c3836" },
            },
        })
        vim.o.background = "dark"
        vim.cmd.colorscheme("gruvbox")
    end,
}
