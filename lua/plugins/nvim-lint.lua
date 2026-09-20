return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		require("lint").linters_by_ft = {
			javascript = { "oxlint" },
			javascriptreact = { "oxlint" },
			lua = { "selene" },
			python = { "ruff" },
			sh = { "shellcheck" },
			zsh = { "shellcheck" },
			svelte = { "oxlint" },
			typescript = { "oxlint" },
			typescriptreact = { "oxlint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		lint.linters.oxlint = vim.tbl_deep_extend("force", lint.linters.oxlint, {
			prepend_args = { "-c", "/home/blackpearl/.config/nvim/lua/config/.oxlintrc.jsonc" },
		})

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
				print("Linting")
			end,
			mode = { "n", "v" },
			desc = "Trigger linting for current file",
		},
	},
}
