return {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    commit = "a1c3d6b369a18514d656dac149de807becacbdf7",
    config = function()
        vim.keymap.set("i", "<M-i>", function()
            return vim.fn["codeium#Accept"]()
        end, { expr = true, silent = true, desc = "Codeium accept" })
        vim.keymap.set("i", "<M-n>", function()
            return vim.fn["codeium#CycleCompletions"](1)
        end, { expr = true, silent = true, desc = "Codeium cycle forward" })
        vim.keymap.set("i", "<M-N>", function()
            return vim.fn["codeium#CycleCompletions"](-1)
        end, { expr = true, silent = true, desc = "Codeium cycle backwards" })
        vim.keymap.set("i", "<M-c>", function()
            return vim.fn["codeium#Clear"]()
        end, { expr = true, silent = true, desc = "Codeium clear" })
        vim.keymap.set("i", "<M-m>", function()
            return vim.fn["codeium#Complete"]()
        end, { expr = true, silent = true, desc = "Codeium manually trigger suggestion" })
        vim.keymap.set("n", "<leader>ic", function()
            return vim.fn["codeium#Chat"]()
        end, { expr = true, silent = true, desc = "Codeium open chat" })
        vim.keymap.set("n", "<leader>it", "<CMD>CodeiumToggle<CR>", { desc = "Codeium toggle on/off" })
    end,
}
