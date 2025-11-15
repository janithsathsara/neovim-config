return {
	"m4xshen/hardtime.nvim",
	lazy = true,
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {},
	config = function()
		require("hardtime").setup()
	end,
}
