return {
    "neovim/nvim-lspconfig",
    cond = not vim.g.vscode,
    config = function()
        vim.diagnostic.config({

        })
        local on_attach = function(client, bufnr)
            if client.server_capabilities.documentSymbolProvider then
                vim.keymap.set("n", "<leader>ii", vim.lsp.buf.hover, {
                    buffer = bufnr,
                    desc = "Show hover documentation",
                })
                vim.keymap.set("n", "<leader>ir", vim.lsp.buf.references, {
                    buffer = bufnr,
                })
                vim.keymap.set("n", "<leader>id", vim.lsp.buf.definition, {
                    buffer = bufnr,
                    desc = "Show hover documentation",
                })
                vim.keymap.set('n', '<leader>iw', vim.diagnostic.open_float, {
                    desc = 'Show diagnostic error message'
                })

                -- Modified auto-format with better float control
                vim.api.nvim_create_autocmd('BufWritePre', {
                    buffer = bufnr,
                    callback = function()
                        -- Suppress UI during formatting
                        vim.lsp.buf.code_action({
                            context = { only = { 'source.organizeImports' } },
                            apply = true,
                            silent = true -- <-- Add this to suppress confirmation
                        })

                        -- Format without UI flicker
                        vim.lsp.buf.format({
                            async = false,
                            filter = function(c) return c.name ~= 'biome' end,
                            timeout_ms = 3000 -- Add timeout
                        })
                    end
                })
            end
        end

        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lspconfig = require("lspconfig")
        local servers = {
            "clangd",
            "jdtls",
            "ts_ls",
            "pylsp",
            "rust_analyzer",
            "lua_ls",
            "html",
            "biome"
        }

        -- Server-specific configurations
        local server_settings = {
            ts_ls = {
                settings = {
                    typescript = {
                        preferences = {
                            importModuleSpecifier = 'shortest',
                            includePackageJsonAutoImports = 'on'
                        }
                    },
                    javascript = {
                        preferences = {
                            importModuleSpecifier = 'shortest',
                            includePackageJsonAutoImports = 'on'
                        }
                    }
                }
            },
            biome = {
                filetypes = { 'javascript', 'typescript', 'json' }
            },
        }

        for _, server in ipairs(servers) do
            local config = {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = server_settings[server] or {}
            }

            -- Language-specific conditional logic
            if server == 'biome' then
                config.filetypes = server_settings.biome.filetypes
            end

            lspconfig[server].setup(config)
        end
    end,

}
