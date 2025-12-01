return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		require("lint").linters_by_ft = {
			sh = { "shellcheck" },
			javascript = { "oxlint" },
			typescript = { "oxlint" },
			javascriptreact = { "oxlint" },
			typescriptreact = { "oxlint" },
			svelte = { "oxlint" },
			python = { "ruff" },
		}

		lint.linters.eslint_d = require("lint").linters.eslint_d

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
	keys = {
		{
			"<leader>la",
			function()
				require("lint").try_lint()
			end,
			mode = { "n", "v" },
			desc = "Trigger linting for current file",
		},
	},
}
