return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        wk.setup()
        wk.add({
            { "<leader>S", group = "Session" },
            { "<leader>v", group = "Vim config" },
            { "<leader>p", group = "Pandoc" },
            { "<leader>d", group = "Debug" },
            { "<leader>f", group = "Find" },
            { "<leader>w", group = "Workspace" },
        })
    end,
}
