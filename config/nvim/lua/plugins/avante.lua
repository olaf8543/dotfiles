return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- ⚠️ NEVER set this to "*"! It will break the plugin
    -- Build command: downloads prebuilt binary or compiles from source
    build = vim.fn.has("win32") ~= 0
        and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "hrsh7th/nvim-cmp",            -- For autocompletion in chat input
        {
            -- Support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    use_absolute_path = true, -- Required for Windows
                },
            },
        },
        {
            -- Markdown rendering
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
    ---@module 'avante'
    ---@type avante.Config
    opts = {
        -- Primary provider used in agentic mode and planning phase
        provider = "ollama",
        -- Mode for interaction: "agentic" (tools) or "legacy" (planning)
        mode = "legacy",
        providers = {
            ollama = {
                endpoint = "http://192.168.1.156:11434",
                model = "qwen3-coder-next:q4_K_M",
                timeout = 30000, -- milliseconds
                extra_request_body = {
                    temperature = 0.75,
                    max_tokens = 64000,
                },
            },

        },
    },
}
