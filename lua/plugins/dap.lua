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
			local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
			-- Mason setup
			require("mason").setup()
			-- Go setup
			require("dap-go").setup({
				delve = {
					path = mason_packages .. "/delve/dlv",
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
						mason_packages .. "/js-debug-adapter/js-debug/src/dapDebugServer.js",
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

			dap.adapters.lldb = {
				type = "executable",
				command = mason_packages .. "/codelldb/codelldb",
				name = "lldb",
			}
			dap.configurations.c = {
				{
					name = "Launch",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},

					-- 💀
					-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
					--
					--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
					--
					-- Otherwise you might get the following error:
					--
					--    Error on launch: Failed to attach to the target process
					--
					-- But you should be aware of the implications:
					-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
					-- runInTerminal = false,
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
			require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python", {
				rocks = {
					enabled = true,
					hererocks = true,
				},
			})
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
