return {
    "stevearc/conform.nvim",
    opts = {
        default_format_opts = {
            timeout_ms = 3000,
            async = false, -- not recommended to change
            quiet = false, -- not recommended to change
            lsp_format = "fallback", -- not recommended to change
        },
        formatters_by_ft = {
            lua = { "stylua" },
            fish = { "fish_indent" },
            sh = { "shfmt" },
            c = { "clang_format" },
            cpp = { "clang_format" },
            sql = { "sqlfluff" },
            py = { "black" },
            -- js = { "prettier" },
            -- jsx = { "prettier" },
            -- ts = { "prettier" },
            -- tsx = { "prettier" },
        },
        -- The options you set here will be merged with the builtin formatters.
        -- You can also define any custom formatters here.
        ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
        formatters = {
            injected = { options = { ignore_errors = true } },
            clang_format = {
                prepend_args = {
                    "--style",
                    "{ IndentWidth: 4, UseTab: Never}",
                },
            },
            -- # Example of using dprint only when a dprint.json file is present
            -- dprint = {
            --   condition = function(ctx)
            --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
            --   end,
            -- },
            --
            -- # Example of using shfmt with extra args
            -- shfmt = {
            --   prepend_args = { "-i", "2", "-ci" },
            -- },
        },
    },
}
