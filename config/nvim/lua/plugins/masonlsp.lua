return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    cond = not vim.g.vscode,
    config = function()
        require("mason-lspconfig").setup()
    end,
}
