return {
    {

        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            -- import mason
            local telescope = require("telescope")
            local mason = require("mason")

            -- import mason-lspconfig
            local mason_lspconfig = require("mason-lspconfig")

            local mason_tool_installer = require("mason-tool-installer")

            -- enable mason and configure icons
            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            mason_lspconfig.setup({
                -- list of servers for mason to install
                ensure_installed = {
                    "tsserver",
                    "html",
                    "cssls",
                    "lua_ls",
                    "emmet_ls",
                    "pyright",
                },
            })

            mason_tool_installer.setup({
                ensure_installed = {
                    "stylua",
                    "prettierd",
                    "black",
                    "isort",
                    "pylint",
                    "eslint_d"
                },
            })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        main = "null-ls",
        opts = function(_, config)
            -- config variable is the default configuration table for the setup function call
            local null_ls = require("null-ls")

            config.sources = {
                -- Set a formatter
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettierd,
                null_ls.builtins.formatting.black,
                null_ls.builtins.code_actions.refactoring,
                null_ls.builtins.code_actions.gitsigns,
            }

            vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "LSP format" })

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function()
                    vim.lsp.buf.format()
                end,
            })

            return config -- return final config table
        end,

        dependencies = {
            "jay-babu/mason-null-ls.nvim",
            config = function()
                require("mason-null-ls").setup()
            end,
        },
    }
}
