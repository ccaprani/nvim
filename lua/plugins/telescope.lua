return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-dap.nvim",
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope file_browser<CR>", desc = "File browser" },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup()
            telescope.load_extension("file_browser")
            telescope.load_extension("dap")
        end,
    },
}
