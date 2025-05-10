vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Synchronizes the system clipboard with Neovim
vim.opt.clipboard = "unnamedplus"

vim.opt.scrolloff = 999

vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.g.mapleader = " "

vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        vim.fn.system("kitty @ set-background-opacity 0.7")
    end,
})

vim.api.nvim_create_autocmd("VimLeave", {
    pattern = "*",
    callback = function()
        vim.fn.system("kitty @ set-background-opacity 0.5")
    end,
})
