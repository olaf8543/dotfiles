-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "<C-a>", "<Esc>A;<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "<C-j>", "<Esc>A;<CR>", { desc = "Exit insert mode" })
-- thanks primagen for these
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines (keep cursor position)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (center cursor)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (center cursor)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next match (center cursor)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous match (center cursor)" })

-- greatest remaps ever
-- vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking deleted text" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex mode" })

vim.keymap.set(
    "n",
    "<leader>.r",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace current word in entire file" }
)

vim.keymap.set("n", "gce", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs><esc>kJA", { desc = "Add Comment At End Of Line" })

-- Check if launched from Kitty scrollback
if vim.g.kitty_scrollback == 1 then
    vim.keymap.set("n", "<M-q>", "<cmd>q!<CR>", { desc = "Quit file" })
end
