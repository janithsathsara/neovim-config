return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python",
        },
        config = function()
            -- Mason setup
            require("mason").setup()

            -- Automatically install and setup debuggers
            require("mason-nvim-dap").setup({
                -- Specify debuggers that should be installed and automatically configured
                ensure_installed = {
                    "firefox",  -- JavaScript/TypeScript
                    "python",   -- debugpy
                    "codelldb", -- Rust debugging
                },
                automatic_installation = true,
                -- Automatically set up debugger configurations
                handlers = {
                    function(config)
                        -- This will automatically set up all debugger configurations
                        require("mason-nvim-dap").default_setup(config)
                    end,
                    python = function(config)
                        require("dap-python").setup(
                        "C:\\Users\\BlackPearl\\AppData\\Local\\nvim-data\\mason\\packages\\debugpy\\venv\\Scripts\\python.exe")
                        -- Enable debugging of tests
                        require("dap-python").test_runner = "pytest"
                    end,
                },
            })

            -- DAP UI setup
            require("dapui").setup({
                layouts = {
                    {
                        elements = {
                            { id = "scopes",      size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks",      size = 0.25 },
                            { id = "watches",     size = 0.25 },
                        },
                        size = 40,
                        position = "left",
                    },
                    {
                        elements = {
                            { id = "repl",    size = 0.5 },
                            { id = "console", size = 0.5 },
                        },
                        size = 10,
                        position = "bottom",
                    },
                },
            })

            -- Virtual Text setup
            require("nvim-dap-virtual-text").setup({
                enabled = true,
                highlight_changed_variables = true,
                show_stop_reason = true,
            })

            --Setup nvim dap
            local dap = require("dap")

            dap.adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = {
                    command = "node",
                    -- 💀 Make sure to update this path to point to your installation
                    args = { "C:\\Users\\BlackPearl\\AppData\\Local\\nvim-data\\mason\\packages\\js-debug-adapter\\js-debug\\src\\dapDebugServer.js", "${port}" },
                },
            }
            dap.configurations.javascript = {
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    console = "integratedTerminal",
                    terminalKind = "integrated",
                },
            }

            -- Keymappings
            vim.keymap.set("n", "<F5>", function()
                require("dap").continue()
            end, { desc = "continue" })
            vim.keymap.set("n", "<F10>", function()
                require("dap").step_over()
            end, { desc = "step over" })
            vim.keymap.set("n", "<F11>", function()
                require("dap").step_into()
            end, { desc = "step into" })
            vim.keymap.set("n", "<F12>", function()
                require("dap").step_out()
            end, { desc = "step out" })
            vim.keymap.set("n", "<Leader>db", function()
                require("dap").toggle_breakpoint()
            end, { desc = "toggle brakpoint" })
            vim.keymap.set("n", "<Leader>dB", function()
                require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Breakpoint condition" })
            vim.keymap.set("n", "<Leader>dr", function()
                require("dap").repl.open()
            end, { desc = "repl open" })
            vim.keymap.set("n", "<Leader>dl", function()
                require("dap").run_last()
            end, { desc = "run last" })
            vim.keymap.set("n", "<Leader>du", function()
                require("dapui").toggle()
            end, { desc = "dapui toggle" })

            -- Automatically open/close DAP UI
            local dapui = require("dapui")
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            -- dap.listeners.before.event_terminated["dapui_config"] = function()
            --     dapui.close()
            -- end
            -- dap.listeners.before.event_exited["dapui_config"] = function()
            --     dapui.close()
            -- end
        end,
    },
}
