return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
        -- Ensure event_handlers table exists
        opts.event_handlers = opts.event_handlers or {}

        -- Add handler to close Neo-tree after file open
        table.insert(opts.event_handlers, {
            event = "file_opened",
            handler = function()
                -- Close all Neo-tree windows
                require("neo-tree.command").execute({ action = "close" })
            end,
        })

        return opts
    end,
}
