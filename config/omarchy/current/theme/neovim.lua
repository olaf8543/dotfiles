-- return {
--     {
--         "ribru17/bamboo.nvim",
--         priority = 1000,
--     },
--     {
--         "LazyVim/LazyVim",
--         opts = {
--             colorscheme = "bamboo",
--         },
--     },
--     {
--         "akinsho/bufferline.nvim",
--         config = function()
--             require('bufferline').setup({
--                 highlights = {
--                     buffer_visible = {
--                         fg = '#63b07a',
--                     },
--                     buffer_selected = {
--                         fg = '#63b07a',
--                         bold = true,
--                         italic = true,
--                     },
--                 },
--             })
--         end
--     }
-- }
return {
    { "st-eez/osaka-jade.nvim", lazy = false, priority = 1000 },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "osaka-jade",
        },
    },
}
