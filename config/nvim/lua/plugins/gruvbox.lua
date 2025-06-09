return {
    "ellisonleao/gruvbox.nvim",
    opts = {
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
            strings = true,
            comments = true,
            operators = false,
            folds = false,
            emphasis = false,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "soft", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        transparent_mode = true,
    },
}
