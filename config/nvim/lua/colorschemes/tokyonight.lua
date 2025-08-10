return {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
        style = "moon",
        transparent = true,
        on_colors = function(colors)
            colors.comment = "#767C77"
        end,
        on_highlights = function(hl, c)
            hl.LineNrAbove = { fg = "#767C77" }
            hl.LineNrBelow = { fg = "#767C77" }
        end,
    },
}
