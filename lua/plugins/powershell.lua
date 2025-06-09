return {
	"TheLeoP/powershell.nvim",
	lazy = true,
	ft = { "ps1" },
	config = function()
		-- This is the default configuration
		require("powershell").setup({
			bundle_path = "C:\\Users\\BlackPearl\\AppData\\Local\\nvim-data\\mason\\packages\\powershell-editor-services",
			capabilities = vim.lsp.protocol.make_client_capabilities(),
		})
	end,
}
