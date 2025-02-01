return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				svelte = { { "prettierd", "prettier", stop_after_first = true } },
				javascript = { { "prettierd", "prettier", stop_after_first = true } },
				typescript = { { "prettierd", "prettier", stop_after_first = true } },
				javascriptreact = { { "prettierd", "prettier", stop_after_first = true } },
				typescriptreact = { { "prettierd", "prettier", stop_after_first = true } },
				json = { { "prettierd", "prettier", stop_after_first = true } },
				markdown = { { "prettierd", "prettier", stop_after_first = true } },
				html = { "htmlbeautifier" },
				bash = { "beautysh" },
				rust = { "rustfmt" },
				toml = { "taplo" },
				sh = { "shellcheck" },
				go = { "gofmt" },
				xml = { "xmllint" },
			},
			formatters = {
				stylua = {
					prepend_args = { "--column-width", "200" },
				},
			},
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				conform.format({ bufnr = args.buf })
			end,
		})
		vim.keymap.set({ "n", "v" }, "<leader>lf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
