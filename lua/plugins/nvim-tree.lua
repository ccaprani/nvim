return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>f", ":NvimTreeToggle<CR>", desc = "Toggle file explorer" },
    },
    config = function()
        local function on_attach(bufnr)
            local api = require("nvim-tree.api")

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- Default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- Custom mappings
            vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
            vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
            vim.keymap.set("n", "<CR>", api.node.open.no_window_picker, opts("Open: No Window Picker"))
        end

        require("nvim-tree").setup({
            on_attach = on_attach,
            view = {
                adaptive_size = false,
            },
        })
    end,
}
