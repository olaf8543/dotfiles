return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    cond = not vim.g.vscode,
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "biome",
                "clangd",
                "html",
                "jdtls",
                "lua_ls",
                "pylsp",
                "rust_analyzer",
                "ts_ls",
            }
        })
    end,
}
