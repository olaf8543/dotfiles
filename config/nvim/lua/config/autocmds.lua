-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Not an autocmd but i want to run it on startup
-- vim.fn.system("kitty @ set-background-opacity 0.7")

-- vim.api.nvim_create_autocmd("VimLeave", {
--     callback = function()
--         pcall(function()
--             vim.fn.system("kitty @ set-background-opacity 0.5")
--         end)
--     end,
-- })
-- vim.api.nvim_create_autocmd("VimLeave", {
--     callback = function()
--         if not os.getenv("TMUX") then
--             pcall(function()
--                 vim.fn.system("kitty @ set-background-opacity 0.5")
--             end)
--         end
--     end,
-- })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    callback = function()
        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 4
        vim.bo.expandtab = true
    end,
})
