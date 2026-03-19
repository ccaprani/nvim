return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
            "nvim-neotest/nvim-nio",
        },
        keys = {
            { "<F5>", function() require("dap").continue() end, desc = "DAP Continue" },
            { "<F6>", function() require("dap").step_over() end, desc = "DAP Step Over" },
            { "<F7>", function() require("dap").step_out() end, desc = "DAP Step Out" },
            { "<F8>", function() require("dap").step_into() end, desc = "DAP Step Into" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional breakpoint" },
            { "<leader>dn", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
            { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
            { "<leader>dR", function() require("dap").clear_breakpoints() end, desc = "Clear breakpoints" },
            { "<leader>de", function() require("dap").set_exception_breakpoints({ "all" }) end, desc = "Exception breakpoints" },
            { "<leader>di", function() require("dap.ui.widgets").hover() end, desc = "Hover" },
            { "<leader>d?", function() local w = require("dap.ui.widgets"); w.centered_float(w.scopes) end, desc = "Scopes" },
            { "<leader>dk", function() require("dap").up() end, desc = "Stack up" },
            { "<leader>dj", function() require("dap").down() end, desc = "Stack down" },
            { "<leader>dr", function() require("dap").repl.toggle({}, "vsplit") end, desc = "Toggle REPL" },
            { "<leader>dp", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "Log point" },
            { "<leader>dl", function() require("dap").run_last() end, desc = "Run last" },
            { "<leader>ds", ":Telescope dap frames<CR>", desc = "DAP frames" },
            { "<leader>dc", ":Telescope dap commands<CR>", desc = "DAP commands" },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- Python debugger (auto-detect python)
            local python_path = vim.fn.exepath("python3")
            if python_path == "" then
                python_path = vim.fn.exepath("python")
            end
            require("dap-python").setup(python_path)
            require("dap-python").test_runner = "pytest"

            -- DAP UI
            dapui.setup({
                icons = { expanded = "▾", collapsed = "▸" },
                mappings = {
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                expand_lines = true,
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.5 },
                            "stacks",
                            "watches",
                        },
                        size = 50,
                        position = "left",
                    },
                    {
                        elements = {
                            "repl",
                            "console",
                        },
                        size = 10,
                        position = "bottom",
                    },
                },
                floating = {
                    max_height = nil,
                    max_width = nil,
                    border = "single",
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                windows = { indent = 1 },
                render = { max_type_length = nil },
            })

            -- Auto open/close UI on debug events
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- Pretty gutter icons
            vim.fn.sign_define("DapStopped", { text = "▶", texthl = "WarningMsg", linehl = "DapUIBreakpointsCurrentLine", numhl = "ModeMsg" })
            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "ErrorMsg", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "⊕", texthl = "ErrorMsg", linehl = "", numhl = "" })
            vim.fn.sign_define("DapLogPoint", { text = "!!", texthl = "ErrorMsg", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "⨷", texthl = "ErrorMsg", linehl = "", numhl = "" })
        end,
    },
}
