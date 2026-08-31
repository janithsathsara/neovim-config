return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = true,
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		build = ":TSUpdate",
		config = function()
			local runtime_parser = vim.fs.joinpath(vim.env.VIMRUNTIME, "parser", "lua.so")
			if vim.uv.fs_stat(runtime_parser) then
				pcall(vim.treesitter.language.add, "lua", { path = runtime_parser })
			end

			local group = vim.api.nvim_create_augroup("user_treesitter", { clear = true })

			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = "*",
				callback = function(args)
					local ok = pcall(vim.treesitter.start, args.buf)
					if not ok then
						return
					end

					vim.wo[0][0].foldmethod = "expr"
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
