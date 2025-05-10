return {
    "williamboman/mason.nvim",
    cond = not vim.g.vscode,
    config = function()
        require("mason").setup()
    end,
}
