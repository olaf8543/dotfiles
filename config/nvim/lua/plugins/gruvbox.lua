return {
    "ellisonleao/gruvbox.nvim",
    cond = not vim.g.vscode,
    config = function()
        require("gruvbox").setup({
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = true,
                comments = true,
                operators = false,
                folds = false,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true,    -- invert background for search, diffs, statuslines and errors
            contrast = "soft", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {},
            transparent_mode = true,
        })
    end,

    init = function()
        vim.cmd("colorscheme gruvbox")
    end
}
