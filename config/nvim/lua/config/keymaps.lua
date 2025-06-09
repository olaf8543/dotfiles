-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>ah", "<cmd>nohl<CR>", { desc = "Clear search highlights" })

-- thanks primagen for these
vim.keymap.set("v", "K", "<cmd>m '<-2<CR>gv=gv", { desc = "Move visual selection up" })
vim.keymap.set("v", "J", "<cmd>m '>+1<CR>gv=gv", { desc = "Move visual selection down" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines (keep cursor position)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (center cursor)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (center cursor)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next match (center cursor)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous match (center cursor)" })

-- greatest remaps ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking deleted text" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex mode" })

vim.keymap.set(
    "n",
    "<leader>.r",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace current word in entire file" }
)

-- My own leader keybindings

-- commenting
vim.keymap.set("n", "<BS>co", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "<BS>cO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })
