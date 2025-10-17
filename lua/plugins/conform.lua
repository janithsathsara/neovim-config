return {
	"stevearc/conform.nvim",
	lazy = true,
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				bash = { "beautysh" },
				cs = { "clang_format" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				go = { "goimports" },
				html = { "prettierd" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				lua = { "stylua" },
				markdown = { "prettierd" },
				python = {
					"ruff_fix",
					"ruff_format",
					"ruff_organize_imports",
				},
				rust = { "rustfmt" },
				svelte = { "prettierd" },
				sh = { "shellcheck" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				toml = { "taplo" },
				xml = { "xmllint" },
			},
			formatters = {
				stylua = {
					inherit = true,
					prepend_args = {
						"--column-width",
						"150",
					},
				},
				rustfmt = {
					inherit = true,
					prepend_args = {
						"--config",
						"max_width=150",
					},
				},
				clang_format = {
					prepend_args = {
						"--style",
						"{IndentWidth: 4, TabWidth: 4, UseTab: Never}",
					},
				},
				prettierd = {
					prepend_args = {
						"--tab-width=4", -- Set tab width to 2 spaces
					},
				},
				mdformat = {
					command = "mdformat",
					args = { "--wrap", "148", "-" },
					stdin = true,
				},
			},
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				conform.format({
					bufnr = args.buf,
					lsp_fallback = true,
				})
			end,
		})
	end,
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end,
			mode = {
				"n",
				"v",
			},

			desc = "Format file or range (in visual mode)",
		},
	},
}
