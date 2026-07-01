return {
	"chrisgrieser/nvim-spider",
	lazy = true,
	-- default values
	config = function()
		require("spider").setup({
			skipInsignificantPunctuation = true,
			subwordMovement = true,
			consistentOperatorPending = false, -- see the README for details
			customPatterns = {}, -- see the README for details
		})
	end,
	keys = {
		{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
		{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
		{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
		{ "ge", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" } },
	},
}
