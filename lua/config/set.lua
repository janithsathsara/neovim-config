vim.g.snacks_animate = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guicursor = ""

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Ruler format
vim.opt.ruler = true
-- vim.opt.rulerformat = [[Ln %l%H, Col %c%V | VCol %V | %p%% | %{&filetype} | %{&fileencoding} ]]

--Deactivate native auto-complete
vim.opt.complete = ""
vim.opt.wildmenu = false
vim.opt.wildmode = ""

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.fileformats = { "unix", "dos" }
vim.opt.fillchars = { eob = " " } -- character that appears after line ending

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.winborder = "single"

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 2
vim.opt.linebreak = true
vim.opt.ignorecase = true
vim.opt.showtabline = 0
vim.opt.foldcolumn = "0"
vim.opt.cursorcolumn = false

-- these two were required to fix the cursor line not correctly showing issue
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"

--NOTE: folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

vim.lsp.inlay_hint.enable(true)

-- vim.opt.ifname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

vim.opt.shortmess:append("a")
vim.opt.shortmess:append("t")
vim.opt.shortmess:append("C")
vim.opt.shortmess:append("I")

vim.opt.cmdheight = 1

--spell

vim.opt.spell = false
vim.opt.spelllang = "en_us"

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "text", "markdown", "typst" },
	callback = function()
		vim.opt.spell = true
	end,
})

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
			vim.opt.number = true
			vim.opt.relativenumber = true
		end
	end,
})

-- open man pages
vim.api.nvim_create_autocmd("FileType", {
	pattern = "man*",
	callback = function()
		if vim.bo.buftype == "nofile" then
			vim.cmd.wincmd("L")
			vim.opt.number = true
			vim.opt.relativenumber = true
		end
	end,
})

-- No more auto comments in newlines
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Auto resize splits
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

vim.api.nvim_create_user_command("ConformToggle", function()
	vim.g.disable_auto_format = not vim.g.disable_auto_format
	local status = vim.g.disable_auto_format and "OFF" or "ON"
	vim.notify("Auto Format: " .. status, vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command("Scratch", function()
	vim.cmd("enew")
	vim.bo.buftype = "nofile"
	vim.bo.bufhidden = "hide"
	vim.bo.swapfile = false
	vim.notify("Scratch Buffer", vim.log.levels.INFO)
end, {})
