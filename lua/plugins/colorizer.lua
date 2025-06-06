return {
	"norcalli/nvim-colorizer.lua",
	lazy = true,
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		require("colorizer").setup()
	end,
}
