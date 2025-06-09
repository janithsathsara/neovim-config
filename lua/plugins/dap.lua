return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		cmd = { "DapToggleBreakpoint" },
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

			--powershell
			dap.configurations.ps1 = {
				{
					name = "PowerShell: Launch Current File",
					type = "ps1",
					request = "launch",
					script = "${file}",
				},
				{
					name = "PowerShell: Launch Script",
					type = "ps1",
					request = "launch",
					script = function()
						return coroutine.create(function(co)
							vim.ui.input({
								prompt = 'Enter path or command to execute, for example: "${workspaceFolder}/src/foo.ps1" or "Invoke-Pester"',
								completion = "file",
							}, function(selected)
								coroutine.resume(co, selected)
							end)
						end)
					end,
				},
				{
					name = "PowerShell: Attach to PowerShell Host Process",
					type = "ps1",
					request = "attach",
					processId = "${command:pickProcess}",
				},
			}

			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticHint", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "➜", texthl = "DiagnosticInfo", linehl = "Visual", numhl = "" })

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
		keys = {
			-- Keymappings
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				"n",
				desc = "continue",
			},
			{
				"<F6>",
				function()
					require("dap").step_over()
				end,
				"n",
				desc = "step over",
			},
			{
				"<F7>",
				function()
					require("dap").step_into()
				end,
				"n",
				desc = "step into",
			},
			{
				"<F8>",
				function()
					require("dap").step_out()
				end,
				"n",
				desc = "step out",
			},
			{
				"<Leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				"n",
				desc = "toggle brakpoint",
			},
			{
				"<Leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				"n",
				desc = "Breakpoint condition",
			},
			{
				"<Leader>dr",
				function()
					require("dap").repl.open()
				end,
				"n",
				desc = "repl open",
			},
			{
				"<Leader>dl",
				function()
					require("dap").run_last()
				end,
				"n",
				desc = "run last",
			},
			{
				"<Leader>du",
				function()
					require("dapui").toggle()
				end,
				"n",
				desc = "dapui toggle",
			},
			{
				"<Leader>dv",
				function()
					require("nvim-dap-virtual-text").toggle()
				end,
				"n",
				desc = "DAP: Toggle Virtual Text",
			},
		},
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python", -- Only load for Python files
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-python").setup("C:\\Users\\BlackPearl\\AppData\\Local\\nvim-data\\mason\\packages\\debugpy\\venv\\Scripts\\python.exe")
			require("dap-python").test_runner = "pytest"
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("nvim-dap-virtual-text").setup({
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				show_stop_reason = true,
			})
		end,
	},
}
