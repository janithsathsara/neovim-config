return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
        modes = {
            char = {
                enabled = false, -- disable f, F, t, T motions
            },
        },
    },
    -- stylua: ignore
    keys = {
        -- Basic jump anywhere
        -- Example: Press 's', type 'function', press label to jump
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" }, -- jump anywhere. Can be done with y or d as well.

        -- Jump to treesitter nodes
        -- Example: Inside a function, press 'S' to highlight and jump to:
        -- - function parameters
        -- - return statements
        -- - function names
        -- - code blocks
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" }, -- jump and highlight treesitter nodes

        -- Remote operations
        -- Example: yr{text} will:
        -- 1. Start yank operation
        -- 2. Search for {text}
        -- 3. Yank that line
        -- 4. Return to original position
        { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" }, -- yr{matching string}y will copy that line and jump back to the position you were in

        -- Search through code structure
        -- Example: Press 'R' to search and select:
        -- - entire functions
        -- - class definitions
        -- - loops or conditionals
        -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },

        -- Toggle flash during searches
        -- Example: In command mode (/) press Ctrl-s to
        -- toggle flash highlights while searching
        -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
}
