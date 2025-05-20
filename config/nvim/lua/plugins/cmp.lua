return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip', -- Only if using snippets
        'rafamadriz/friendly-snippets',
        'onsails/lspkind.nvim',
        'hrsh7th/cmp-nvim-lsp',
    },
    cond = not vim.g.vscode,
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        local autopairs = require('nvim-autopairs.completion.cmp')
        local handlers = require('nvim-autopairs.completion.handlers')
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-J>"] = cmp.mapping.scroll_docs(4),
                ["<C-K>"] = cmp.mapping.scroll_docs(-4),
                -- stopped using these but thought id keep them
                -- commented for now
                -- ["<Tab>"] = cmp.mapping(function(fallback)
                --     if cmp.visible() then
                --         cmp.select_next_item()
                --     elseif luasnip.expand_or_jumpable() then
                --         luasnip.expand_or_jump()
                --     else
                --         fallback()
                --     end
                -- end, { "i", "s" }),
                -- ["<S-Tab>"] = cmp.mapping(function(fallback)
                --     if cmp.visible() then
                --         cmp.select_prev_item()
                --     elseif luasnip.jumpable(-1) then
                --         luasnip.jump(-1)
                --     else
                --         fallback()
                --     end
                -- end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = "copilot", priority = 1000 },
                { name = "nvim_lsp" },
                { name = "luasnip" }, --snippets
                { name = "buffer" },  --text within current buffer
                { name = "path" },    --file system paths
            }),
            --configure lspkind for vs-code like pictograms in completion menu
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = "...",
                }),
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            cmp.event:on(
                'confirm_done',
                autopairs.on_confirm_done({
                    filetypes = {
                        -- "*" is a alias to all filetypes
                        ["*"] = {
                            ["("] = {
                                kind = {
                                    cmp.lsp.CompletionItemKind.Function,
                                    cmp.lsp.CompletionItemKind.Method,
                                },
                                handler = handlers["*"]
                            }
                        },
                        lua = {
                            ["("] = {
                                kind = {
                                    cmp.lsp.CompletionItemKind.Function,
                                    cmp.lsp.CompletionItemKind.Method
                                },
                                ---@param char string
                                ---@param item table item completion
                                ---@param bufnr number buffer number
                                ---@param rules table
                                ---@param commit_character table<string>
                                handler = function(char, item, bufnr, rules, commit_character)
                                    -- Your handler function. Inspect with print(vim.inspect{char, item, bufnr, rules, commit_character})
                                end
                            }
                        },
                        -- Disable for tex
                        tex = false
                    }
                })
            ),
        })
    end,
}
