return {
    "zbirenbaum/copilot.lua",
    dependencies = "zbirenbaum/copilot-cmp",
    cond = not vim.g.vscode,
    config = function()
        require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
        })

        require("copilot_cmp").setup({
            method = "getCompletionsCycling",
        })
    end
}
