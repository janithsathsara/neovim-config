return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")
        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        ["<C-n>"] = false,
                        ["<C-p>"] = false,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                    n = {
                        ["<C-n>"] = false,
                        ["<C-p>"] = false,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                },
            },
        }
        -- telescope.load_extension("fzf")
        telescope.load_extension("ui-select")

        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find files" })
        vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "live grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "help tags" })
        vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "keymaps" })
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "diagnostics" })
    end,
}
