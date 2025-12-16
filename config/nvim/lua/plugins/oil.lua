return {
    "stevearc/oil.nvim",
    enabled = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    keys = {
        {
            "<leader>e",
            "<cmd>Oil<cr>",
            desc = "Open File explorer (cwd)",
        },
        {
            "<leader>E",
            "<cmd>e.<cr>",
            desc = "Open File explorer (Root Dir)",
        },
    },
    opts = {
        keymaps = {
            ["g?"] = { "actions.show_help", mode = "n" },
            ["<CR>"] = "actions.select",
            ["<C-p>"] = { "actions.preview", opts = { horizontal = true } },
            ["<leader>e"] = { "actions.close", mode = "n" },
            ["<C-l>"] = "actions.refresh",
            ["-"] = { "actions.parent", mode = "n" },
            ["_"] = { "actions.open_cwd", mode = "n" },
            ["`"] = { "actions.cd", mode = "n" },
            ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
            ["gs"] = { "actions.change_sort", mode = "n" },
            ["gx"] = "actions.open_external",
            ["g."] = { "actions.toggle_hidden", mode = "n" },
            ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
    },
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
}
