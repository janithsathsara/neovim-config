return {
	"folke/which-key.nvim",
	lazy = true,
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	opts = {},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
