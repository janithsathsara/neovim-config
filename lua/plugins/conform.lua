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
				c = { "clang_format" },
				cpp = { "clang_format" },
				cs = { "clang_format" },
				go = { "goimports" },
				html = { "oxfmt" },
				javascript = { "oxfmt" },
				javascriptreact = { "oxfmt" },
				jsonc = { "oxfmt" },
				json = { "oxfmt" },
				lua = { "stylua" },
				markdown = { "oxfmt" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				sh = { "beautysh" },
				rust = { "rustfmt" },
				svelte = { "oxfmt" },
				toml = { "taplo" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				typst = { "typstyle" },
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
						-- "--style",
						-- "{IndentWidth: 4, TabWidth: 4, UseTab: Never}",
						"--style",
						"{IndentWidth: 4, TabWidth: 4, UseTab: Never, ColumnLimit: 80, BreakAfterOpenBracketBracedList: true, BreakBeforeCloseBracketBracedList: true, BinPackArguments: false, BinPackParameters: false, Cpp11BracedListStyle: false}",
					},
				},
				prettierd = {
					prepend_args = {
						"--tab-width=4", -- Set tab width to 2 spaces
					},
				},
				oxfmt = {
					args = {
						"-c",
						"/home/blackpearl/.config/nvim/lua/config/.oxfmtrc.jsonc",
						"--stdin-filepath",
						"$FILENAME",
					},
				},
				mdformat = {
					command = "mdformat",
					args = { "--wrap", "148", "-" },
					stdin = true,
				},
			},
			format_on_save = function(bufnr)
				if vim.g.disable_auto_format then
					return nil
				end
				return {
					timeout_ms = 3500,
					lsp_fallback = false,
				}
			end,
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				if vim.g.disable_auto_format then
					return nil
				else
					conform.format({
						bufnr = args.buf,
						lsp_fallback = false,
					})
				end
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
					timeout_ms = 3500,
				})
			end,
			mode = {
				"n",
				"v",
			},

			desc = "Format file or range (in visual mode)",
		},
		{
			"<leader>lt",
			"<cmd>ConformToggle<cr>",
			mode = {
				"n",
				"v",
			},

			desc = "Format file or range (in visual mode)",
		},
	},
}
