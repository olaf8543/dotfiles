return {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        require("luasnip").setup({})
        -- Load VS Code-like snippets from friendly-snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        -- Keymaps for snippet navigation (optional but recommended)
    end,
}
