vim.g.snacks_animate = false
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

--Deactivate native auto-complete
vim.opt.complete = ""

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.fileformats = { "unix", "dos" }
vim.opt.fillchars = { eob = " " } -- character that appears after line ending

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.winborder = "single"

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 2
vim.opt.linebreak = true
vim.opt.ignorecase = true
vim.opt.showtabline = 0
vim.opt.foldcolumn = "0"
vim.opt.cursorcolumn = false

-- these two were required to fix the cursorlinenr not correctly showing issue
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

--NOTE: folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

vim.lsp.inlay_hint.enable(true)

-- vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

vim.opt.shortmess:append("a")
vim.opt.shortmess:append("t")
vim.opt.shortmess:append("C")
vim.opt.shortmess:append("I")

vim.opt.cmdheight = 1

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "komorebi.json",
	command = "set filetype=jsonc",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "komorebi.bar.json",
	command = "set filetype=jsonc",
})

-- open help as a vertical split
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = { "*.txt" },
	callback = function()
		if vim.bo.buftype == "help" then
			vim.cmd.wincmd("L") -- Move help window to the far right
		end
	end,
})
