return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				svelte = { "prettierd" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				markdown = { "prettierd" },
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
					inherit = true,
					prepend_args = { "--column-width", "200" },
				},
				rustfmt = {
					inherit = true,
					prepend_args = { "--config", "max_width=150" },
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
