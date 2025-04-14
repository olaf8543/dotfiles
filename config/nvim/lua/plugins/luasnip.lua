return {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        local ls = require("luasnip")
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.i

        ls.add_snippets("c", {
            s("main", {
                t({"int main(int argc, char **argv) {", "\t"}), -- First two lines
                i(1),                        -- Cursor position
                t({"", "\treturn 0;", "}"}), -- Remaining lines
            })
        })

        -- Load VS Code-like snippets (with placeholders)
        require("luasnip.loaders.from_vscode").lazy_load()

        -- Keymaps for jumping between placeholders
        vim.keymap.set({ "i", "s" }, "<C-j>", function()
            ls.jump(1) -- Jump forward
        end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-k>", function()
            ls.jump(-1) -- Jump backward
        end, { silent = true })
    end,
}
