-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- better up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- shortcut to edit this file
vim.keymap.set("n", "<leader>km", ":e ~/.config/nvim/lua/config/keymaps.lua<cr>")
-- opinionated quotes
vim.keymap.set("n", "<leader>''", ":%s/'/\"/g<cr>", { desc = "Convert single quotes to double for entire file" })
--navigate panes
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "jk", [[<C-\><C-n>]])
vim.keymap.set("t", "jk", [[<C-\><C-n>]])
vim.keymap.set("t", "jk", [[<C-\><C-n>]])
vim.keymap.set("t", "jk", [[<C-\><C-n>]])
vim.keymap.set("t", "jk", [[<C-\><C-n>]])
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]])
