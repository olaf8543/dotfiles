return {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    cond = not vim.g.vscode,
    config = function()
        local ls = require("luasnip")
        local rep = require("luasnip.extras").rep
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.i
        local d = ls.dynamic_node

        ls.add_snippets("c", {
            s("main", {
                t({ "int main(int argc, char **argv) {", "\t" }), -- First two lines
                i(1),                                             -- Cursor position
                t({ "", "\treturn 0;", "}" }),                    -- Remaining lines
            })
        })

        ls.add_snippets("typescriptreact", {
            s("htag", {
                t("<"), i(1), t(">"),
                i(2),
                t("</"), rep(1), t(">"),
            })
        })

        ls.add_snippets("typescriptreact", {
            s("ptag", {
                t("<"), i(1), t(" "), i(2), t(">"), -- need to do this to not repeat class identifiers
                i(3),
                t("</"), rep(1), t(">"),
            })
        })
        ls.add_snippets("typescriptreact", {
            s("stag", {
                t("<"), i(1), t(" />"),
            })
        })

        require("luasnip.loaders.from_vscode").lazy_load()

        vim.keymap.set({ "i", "s" }, "<C-j>", function()
            ls.jump(1) -- Jump forward
        end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-k>", function()
            ls.jump(-1) -- Jump backward
        end, { silent = true })
    end,
}
