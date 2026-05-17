return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	keys = {
		{ "<M-l>", mode = "i" },
		{ "<M-]>", mode = "i" },
		{ "<M-[>", mode = "i" },
		{ "<C-]>", mode = "i" },
	},
	dependencies = {
		{
			"copilotlsp-nvim/copilot-lsp",
			init = function()
				vim.g.copilot_nes_debounce = 500
			end,
		},
	},
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,
				debounce = 15,
				keymap = {
					accept = "<M-l>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			panel = { enabled = false },
			nes = {
				enabled = true,
				auto_trigger = false,
				keymap = {
					accept_and_goto = "<leader>a",
					accept = false,
					dismiss = "<Esc>",
				},
			},
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "BlinkCmpMenuOpen",
			callback = function()
				vim.b.copilot_suggestion_hidden = true
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "BlinkCmpMenuClose",
			callback = function()
				vim.b.copilot_suggestion_hidden = false
			end,
		})
	end,
}
