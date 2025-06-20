vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>Q", "<Cmd>q<CR>", { desc = "Exit" })
vim.keymap.set("n", "<leader>w", "<Cmd>w<CR>", { desc = "Save" })

vim.keymap.set("n", "<leader>m", "GVgg")
vim.keymap.set("v", "J", ":m '>+1<CR><CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR><CR>gv=gv")
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

--NOTE:packages
vim.keymap.set("n", "<leader>pl", "<Cmd>Lazy<CR>")
vim.keymap.set("n", "<leader>pm", "<Cmd>Mason<CR>")

-- vim.keymap.set("n", "<C-V>", [["+p]], { desc = "copy from os clipboard" })
vim.keymap.set("n", "G", "Gzz", { desc = "Move to the bottom of the page" })
vim.keymap.set("n", "<C-d>", "<C-d>zz_", { desc = "move the cursor down half page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz_", { desc = "move the cursor up half page" })
vim.keymap.set("n", "<C-f>", "<C-f>zz_", { desc = "move the cursor up half page" })
vim.keymap.set("n", "<C-b>", "<C-b>zz_", { desc = "move the cursor up half page" })
vim.keymap.set("n", "}", "}zz_", { desc = "move the cursor up half page" })
vim.keymap.set("n", "{", "{zz_", { desc = "move the cursor up half page" })
vim.keymap.set("n", "n", "nzzzv", { desc = "something" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "something else" })
vim.keymap.set("n", "<leader>lg", vim.lsp.buf.format, { desc = "LSP format" })

--close all buffers remap
--TODO: does not work correctly. The dashboard draws over everthing and when files are opened again, they cannot be seen.
vim.keymap.set("n", "<leader>C", "<Cmd>bufdo bdelete<CR><Cmd>lua Snacks.dashboard()<CR>", { desc = "close all buffers" })

--Close current Buffer remap and go to header file
vim.keymap.set("n", "<leader>c", "<Cmd>bdelete<CR>", { desc = "close current buffer" })

-- Quickfix list

vim.keymap.set("n", "<leader>sq", "<Cmd>copen<CR>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>sn", "<Cmd>cnext<CR>", { desc = "Next quickfix item" })
vim.keymap.set("n", "<leader>sp", "<Cmd>cprevious<CR>", { desc = "Previous quickfix item" })
vim.keymap.set("n", "<leader>sz", "<Cmd>cwindow<CR>", { desc = "Open quickfix list in window" })

--unmap keys
-- vim.keymap.set('n', 'x', '<Nop>', { silent = true })
-- vim.keymap.set('v', 'x', '<Nop>', { silent = true })
vim.keymap.set("v", "s", "<Nop>", { silent = true })
vim.keymap.set("n", "s", "<Nop>", { silent = true })
vim.keymap.set("v", "S", "<Nop>", { silent = true })
vim.keymap.set("n", "S", "<Nop>", { silent = true })
