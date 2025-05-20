return {
    "rcarriga/nvim-notify",
    cond = not vim.g.vscode,
    config = function()
        require("notify").setup({
            background_colour = "#1a1b26",    -- Your theme's background color
            require("notify").setup({
                timeout = 1,                  -- Default: 5000 (5 seconds)
                fps = 60,                     -- Reduce for slower fade animations
                stages = "fade_in_slide_out", -- Simpler animation
            })
        })
    end
}
