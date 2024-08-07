vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>q", "<Cmd>q<CR>", { desc = "Exit" })
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
vim.keymap.set("n", "<C-d>", "<C-d>zz_", { desc = "move the cursor down half page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz_", { desc = "move the cursor up half page" })
vim.keymap.set("n", "}", "}zz_", { desc = "move the cursor up half page" })
vim.keymap.set("n", "{", "{zz_", { desc = "move the cursor up half page" })
vim.keymap.set("n", "n", "nzzzv", { desc = "something" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "something else" })

--close all buffers remap
vim.keymap.set("n", "<leader>C", "<Cmd>bufdo bdelete<CR><Cmd>Alpha<CR>", { desc = "close all buffers" })
--Close current Buffer remap and go to header file
vim.keymap.set("n", "<leader>c", "<Cmd>bdelete<CR>", { desc = "close current buffer" })
