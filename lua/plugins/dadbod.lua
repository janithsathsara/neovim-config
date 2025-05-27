return {
	{
		"tpope/vim-dadbod",
		event = "VeryLazy",
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		config = function()
			-- Set up vim-dadbod-ui configurations
			vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
			vim.g.db_ui_use_nerd_fonts = 1

			-- Add DBUI filetype detection
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					-- Enable vim-dadbod-completion for SQL files
					require("blink.cmp.config.sources").add_provider({
						name = "vim-dadbod-completion",
						module = "blink.cmp.sources.buffer",
						score_offset = 95,
					})
				end,
			})
		end,
	},
}

-- postgres://<username>:<password>@localhost/<database>
-- postgresql://postgres@localhost:5432/test
-- Toggle dbui and press A. Then add the given link
-- saving will run the query
