return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"williamboman/mason.nvim",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			-- Mason setup
			require("mason").setup()
			-- Go setup
			require("dap-go").setup({
				delve = {
					path = "C:\\Users\\BlackPearl\\AppData\\Local\\nvim-data\\mason\\packages\\delve\\dlv.exe",
				},
			})
			-- Enable python dap
			require("dap-python").setup("C:\\Users\\BlackPearl\\AppData\\Local\\nvim-data\\mason\\packages\\debugpy\\venv\\Scripts\\python.exe")
			-- Enable debugging of tests
			require("dap-python").test_runner = "pytest"

			-- DAP UI setup
			require("dapui").setup({
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						size = 10,
						position = "bottom",
					},
				},
			})

			-- -- Virtual Text setup (FIXED: moved after dap setup and enhanced configuration)
			-- require("nvim-dap-virtual-text").setup({
			-- 	enabled = true,
			-- 	enabled_commands = true,
			-- 	highlight_changed_variables = true,
			-- 	highlight_new_as_changed = false,
			-- 	show_stop_reason = true,
			-- 	commented = false,
			-- 	only_first_definition = true,
			-- 	all_references = false,
			-- 	clear_on_continue = false,
			-- 	-- Display virtual text for all stack frames not only current frame
			-- 	display_callback = function(variable, buf, stackframe, node, options)
			-- 		if options.virt_text_pos == "inline" then
			-- 			return " = " .. variable.value
			-- 		else
			-- 			return variable.name .. " = " .. variable.value
			-- 		end
			-- 	end,
			-- 	-- Position of virtual text, see `:help nvim_buf_set_extmark()`, default tries to inline the virtual text
			-- 	virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
			-- 	-- Experimental features:
			-- 	all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
			-- 	virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
			-- 	virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
			-- })

			--Setup nvim dap
			local dap = require("dap")

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					-- 💀 Make sure to update this path to point to your installation
					args = {
						"C:\\Users\\BlackPearl\\AppData\\Local\\nvim-data\\mason\\packages\\js-debug-adapter\\js-debug\\src\\dapDebugServer.js",
						"${port}",
					},
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

			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticHint", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "➜", texthl = "DiagnosticInfo", linehl = "Visual", numhl = "" })

			-- Keymappings
			vim.keymap.set("n", "<F5>", function()
				require("dap").continue()
			end, { desc = "continue" })
			vim.keymap.set("n", "<F6>", function()
				require("dap").step_over()
			end, { desc = "step over" })
			vim.keymap.set("n", "<F7>", function()
				require("dap").step_into()
			end, { desc = "step into" })
			vim.keymap.set("n", "<F8>", function()
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
			vim.keymap.set("n", "<Leader>dv", function()
				require("nvim-dap-virtual-text").toggle()
			end, { desc = "DAP: Toggle Virtual Text" })

			-- Automatically open/close DAP UI
			local dapui = require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end

			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Virtual text
			dap.listeners.after.event_initialized["dap_virtual_text"] = function()
				vim.cmd("DapVirtualTextEnable")
			end

			dap.listeners.before.event_terminated["dap_virtual_text"] = function()
				vim.cmd("DapVirtualTextDisable")
			end

			dap.listeners.before.event_exited["dap_virtual_text"] = function()
				vim.cmd("DapVirtualTextDisable")
			end
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("nvim-dap-virtual-text").setup({
				enabled = true, -- enable by default
				enabled_commands = true, -- adds DAPVirtualTextEnable, etc.
				highlight_changed_variables = true,
				show_stop_reason = true,
			})
		end,
	},
}
