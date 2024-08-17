vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 2
vim.opt.linebreak = true
vim.opt.ignorecase = false
vim.opt.showtabline = 0
vim.opt.foldcolumn = "0"

-- vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

vim.opt.shortmess:append("a")
vim.opt.shortmess:append("t")
vim.opt.shortmess:append("C")
vim.opt.shortmess:append("I")

vim.opt.cmdheight = 0


vim.api.nvim_create_autocmd(
    'TextYankPost',
    {
        pattern = '*',
        callback = function()
            vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 }
        end
    }
)

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "komorebi.json",
    command = "set filetype=jsonc",
})

-- autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup='Visual', timeout=300}
