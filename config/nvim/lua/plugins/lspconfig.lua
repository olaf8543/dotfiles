return {
    "neovim/nvim-lspconfig",
    config = function()
        local on_attach = function(client, bufnr)
            if client.server_capabilities.documentSymbolProvider then
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
        local servers = {
            "clangd",
            "jdtls",
            "ts_ls",
            "pylsp",
            "rust_analyzer",
            "lua_ls"
        }

        for _, server in ipairs(servers) do
            lspconfig[server].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end
    end,
}
