return {
	{
		"romus204/tree-sitter-manager.nvim",
		dependencies = {}, -- tree-sitter CLI must be installed system-wide
		config = function()
			require("tree-sitter-manager").setup({
				-- Default Options
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"c_sharp",
					"css",
					"dockerfile",
					"ecma",
					"go",
					"html",
					"java",
					"javascript",
					"json",
					"jq",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"rust",
					"sql",
					"typescript",
					"typescript",
					"typst",
					"vim",
					"yaml",
				}, -- list of parsers to install at the start of a neovim session
				border = "rounded", -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
				auto_install = false, -- if enabled, install missing parsers when editing a new file
				-- highlight = true, -- treesitter highlighting is enabled by default
				-- languages = {}, -- override or add new parser sources
				-- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
				-- query_dir = vim.fn.stdpath("data") .. "/site/queries",
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

-- {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	branch = "main",
-- 	lazy = false,
-- 	build = ":TSUpdate",
-- 	config = function()
-- 		local runtime_parser = vim.fs.joinpath(vim.env.VIMRUNTIME, "parser", "lua.so")
-- 		if vim.uv.fs_stat(runtime_parser) then
-- 			pcall(vim.treesitter.language.add, "lua", { path = runtime_parser })
-- 		end
--
-- 		local group = vim.api.nvim_create_augroup("user_treesitter", { clear = true })
--
-- 		vim.api.nvim_create_autocmd("FileType", {
-- 			group = group,
-- 			pattern = "*",
-- 			callback = function(args)
-- 				local ok = pcall(vim.treesitter.start, args.buf)
-- 				if not ok then
-- 					return
-- 				end
--
-- 				vim.wo[0][0].foldmethod = "expr"
-- 				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- 				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
-- 			end,
-- 		})
-- 	end,
-- },
-- Plugin
-- {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	lazy = false,
-- 	branch = "main",
-- 	build = ":TSUpdate",
-- 	config = function()
-- 		require("nvim-treesitter").setup({
-- 			-- highlight = { enable = true },
-- 			-- indent = { enable = true },
-- 			-- auto_install = true,
-- 		})
-- 	end,
-- 	init = function()
-- local ensureInstalled = {
-- 	"lua",
-- 	"python",
-- 	"typescript",
-- 	"c_sharp",
-- 	"dockerfile",
-- 	"typescript",
-- 	"html",
-- 	"css",
-- 	"json",
-- 	"bash",
-- 	"markdown",
-- 	"yaml",
-- 	"vim",
-- 	"rust",
-- 	"go",
-- 	"cpp",
-- 	"java",
-- 	"sql",
-- 	"markdown_inline",
-- }
-- local alreadyInstalled = require("nvim-treesitter.config").get_installed()
-- local parsersToInstall = vim.iter(ensureInstalled)
-- 	:filter(function(parser)
-- 		return not vim.tbl_contains(alreadyInstalled, parser)
-- 	end)
-- 	:totable()
-- require("nvim-treesitter").install(parsersToInstall)
-- 	end,
-- },
