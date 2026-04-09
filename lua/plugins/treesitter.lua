return {
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
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
		init = function()
			local ensureInstalled = {
				"lua",
				"python",
				"typescript",
				"c_sharp",
				"dockerfile",
				"typescript",
				"html",
				"css",
				"json",
				"bash",
				"markdown",
				"yaml",
				"vim",
				"rust",
				"go",
				"cpp",
				"java",
				"sql",
				"markdown_inline",
			}
			local alreadyInstalled = require("nvim-treesitter.config").get_installed()
			local parsersToInstall = vim.iter(ensureInstalled)
				:filter(function(parser)
					return not vim.tbl_contains(alreadyInstalled, parser)
				end)
				:totable()
			require("nvim-treesitter").install(parsersToInstall)
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
