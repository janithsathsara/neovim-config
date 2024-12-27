return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        'saghen/blink.cmp',
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim",                   opts = {} },
    },
    config = function()
        -- import lspconfig plugin
        local lspconfig = require("lspconfig")

        -- import mason_lspconfig plugin
        local mason_lspconfig = require("mason-lspconfig")

        -- import blink.cmp plugin
        local capabilities = require("blink.cmp").get_lsp_capabilities()


        local keymap = vim.keymap -- for conciseness

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                -- local opts = { buffer = ev.buf, silent = true }

                -- set keybinds
                keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP references" })   -- show definition, references

                keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "LSP declaration" })              -- go to declaration

                keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", { desc = "LSP definitions" }) -- show lsp definitions

                keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", { desc = "LSP implementations" }
                ) -- show lsp implementations

                keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>",
                    { desc = "LSP type definitions" }
                )                                                                                                          -- show lsp type definitions

                keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "LSP code actions" })             -- see available code actions, in visual mode will apply to selection

                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })                               -- smart rename

                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnosis" }) -- show  diagnostics for file

                keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnosis" })                  -- show diagnostics for line

                keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })                    -- jump to previous diagnostic in buffer

                keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })                        -- jump to next diagnostic in buffer

                keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor" })          -- show documentation for what is under cursor

                keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })                                 -- mapping to restart lsp if necessary
            end,
        })

        -- used to enable autocompletion (assign to every lsp server config)
        -- local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Change the Diagnostic symbols in the sign column (gutter)
        -- (not in youtube nvim video)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        mason_lspconfig.setup_handlers({
            -- default handler for installed servers
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,
            ["lua_ls"] = function()
                -- configure lua server (with special settings)
                lspconfig["lua_ls"].setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            -- make the language server recognize "vim" global
                            diagnostics = {
                                globals = { "vim" },
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                })
            end,
            ["pylsp"] = function()
                lspconfig["pylsp"].setup({
                    capabilities = capabilities,
                    settings = {
                        pylsp = {
                            plugins = {
                                pylsp_black = { enabled = false },
                                pylsp_mypy = { enabled = false },
                                pylsp_isort = { enabled = false },
                                pyflakes = { enabled = false },
                                autopep8 = { enabled = false },
                                pycodestyle = { enabled = false },
                                yapf = { enabled = false },
                            }
                        }
                    },
                })
            end
        })
    end,
}
