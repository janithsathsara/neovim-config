return {
    'goolord/alpha-nvim',
    event = "VimEnter",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            "                                                     ",
            "                                                     ",
            "                                                     ",
            "                                                     ",
            "                                                     ",
            "                                                     ",
            "                                                     ",
            "                                                     ",
            " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ",
            " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
            " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ",
            " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
            " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
            " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
            "                                                     ",
        }

        vim.api.nvim_set_hl(0, 'AlphaHeader', { fg = '#a6e3a1' })
        dashboard.section.header.opts.hl = "AlphaHeader"
        dashboard.section.buttons.val = {
            dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
            dashboard.button("SPC e", "  > Toggle file explorer", "<CMD>Oil --float<CR>"),
            dashboard.button("SPC ff", "󰱼  > Find Files", "<cmd>Telescope find_files<CR>"),
            dashboard.button("SPC fw", "  > Find Words", "<cmd>Telescope live_grep<CR>"),
            dashboard.button("SPC fo", "󰁯  > Find recently opened files", "<cmd>Telescope oldfiles<CR>"),
            dashboard.button("SPC q", "  > Quit NVIM", "<cmd>qa<CR>"),

        }
        alpha.setup(dashboard.opts)

        vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end
};
