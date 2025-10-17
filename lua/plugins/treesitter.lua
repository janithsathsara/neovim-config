return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				context_commentstring = { enable = true },
				ensure_installed = {
					"c_sharp", --csharp
					"lua", -- Lua
					"python", -- Python
					"javascript", -- JavaScript
					"typescript", -- TypeScript
					"html", -- HTML
					"css", -- CSS
					"json", -- JSON
					"bash", -- Bash
					"markdown", -- Markdown
					"yaml", -- YAML
					"vim", -- Vimscript
					"rust", -- Rust
					"go", -- Go
					"cpp", -- C++
					"java", -- Java
					"sql", -- SQL
					"markdown_inline", -- Markdown
				},
				highlight = { enable = true },
				fold = { enable = true },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = true,
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			require("treesitter-context").setup({
				enable = true,
			})
		end,
	},
}
