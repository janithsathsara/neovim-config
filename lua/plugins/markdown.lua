return {
	"MeanderingProgrammer/render-markdown.nvim",
	lazy = false,
	priority = 100,
	opts = {
        treesitter = {
            enabled = true,
            highlight = true,
        },
		latex = { enabled = false },
	},
    config = function()
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
				-- Ensure markdown and markdown_inline are included
				additional_vim_regex_highlighting = { "markdown", "markdown_inline" },
			},
		})
	end,
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
}
