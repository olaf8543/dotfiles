return {
    "voldikss/vim-floaterm",
    cond = not vim.g.vscode,
    keys = {
        {
            "<leader>g",
            "<cmd>FloatermNew --height=0.8 --width=0.9 lazygit<CR>",
        },
    },
    config = function()
    end
}
