return {
    "mfussenegger/nvim-lint",
    opts = {
        -- Event to trigger linters
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        -- linters_by_ft = {
        --     fish = { "fish" },
        --     lua = { "stylua" },
        --     sh = { "shfmt" },
        --     c = { "clang_format" },
        --     cpp = { "clang_format" },
        --     sql = { "sqlfluff" },
        --     py = { "black" },
        -- },
        -- LazyVim extension to easily override linter options
        -- or add custom linters.
        ---@type table<string,table>
        linters = {
            -- -- Example of using selene only when a selene.toml file is present
            -- selene = {
            --   -- `condition` is another LazyVim extension that allows you to
            --   -- dynamically enable/disable linters based on the context.
            --   condition = function(ctx)
            --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
            --   end,
            -- },
        },
    },
}
