return {
    "carlos-algms/agentic.nvim",
    opts = {
        -- Pi is exposed to Agentic through the Agent Client Protocol adapter.
        -- Install with: npm install -g pi-acp
        provider = "pi-acp",
        provider_switcher = {
            -- Keep the provider picker focused on CLIs that are actually installed.
            hide_unhealthy_providers = true,
        },
    },
    keys = {
        {
            "<leader>aa",
            function() require("agentic").toggle() end,
            mode = { "n", "v" },
            desc = "Agentic: Toggle chat",
        },
        {
            "<leader>ac",
            function() require("agentic").add_selection_or_file_to_context() end,
            mode = { "n", "v" },
            desc = "Agentic: Add selection/file",
        },
        {
            "<leader>an",
            function() require("agentic").new_session() end,
            mode = { "n", "v" },
            desc = "Agentic: New session",
        },
        {
            "<leader>ar",
            function() require("agentic").restore_session() end,
            mode = { "n", "v" },
            desc = "Agentic: Restore session",
        },
        {
            "<leader>ap",
            function() require("agentic").switch_provider() end,
            mode = { "n", "v" },
            desc = "Agentic: Switch provider",
        },
        {
            "<leader>ax",
            function() require("agentic").stop_generation() end,
            mode = { "n", "v" },
            desc = "Agentic: Stop generation",
        },
        {
            "<leader>ad",
            function() require("agentic").add_current_line_diagnostics() end,
            mode = "n",
            desc = "Agentic: Add line diagnostic",
        },
        {
            "<leader>aD",
            function() require("agentic").add_buffer_diagnostics() end,
            mode = "n",
            desc = "Agentic: Add buffer diagnostics",
        },
    },
}
