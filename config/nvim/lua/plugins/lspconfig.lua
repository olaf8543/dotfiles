return {
    "neovim/nvim-lspconfig",
    config = function()
        local navic = require("nvim-navic")
        local on_attach = function(client, bufnr)
            if client.server_capabilities.documentSymbolProvider then
                navic.attach(client, bufnr)
                -- add definition keybinds to buffer
                vim.keymap.set("n", "<leader>i", vim.lsp.buf.hover, {
                    buffer = bufnr, -- Makes the keybind buffer-local
                    desc = "Show hover documentation",
                })
                vim.keymap.set("n", "<leader>j", vim.lsp.buf.definition, {
                    buffer = bufnr, -- Makes the keybind buffer-local
                    desc = "Show hover documentation",
                })
            end
        end
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        local lspconfig = require("lspconfig")
        lspconfig.clangd.setup({on_attach = on_attach, capabilities = capabilities })
        lspconfig.jdtls.setup({on_attach = on_attach, capabilities = capabilities })
        lspconfig.ts_ls.setup({on_attach = on_attach, capabilities = capabilities })
        lspconfig.pylsp.setup({on_attach = on_attach, capabilities = capabilities })
        lspconfig.rust_analyzer.setup({on_attach = on_attach, capabilities = capabilities })
        lspconfig.lua_ls.setup({on_attach = on_attach, capabilities = capabilities })
    end,
}
