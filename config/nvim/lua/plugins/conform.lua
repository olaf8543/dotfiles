return {
    "stevearc/conform.nvim",
    cond = not vim.g.vscode,
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                javascript = { "biome" },
                typescript = { "biome" },
                javascriptreact = { "biome" },
                typescriptreact = { "biome" },
                html = { "prettier" },
                json = { "biome" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
            formatters = {
                biome = {
                    command = "biome",
                    args = { "format", "--stdin-file-path", "$FILENAME" },
                    stdin = true,
                },
            },
        })
    end,
}
