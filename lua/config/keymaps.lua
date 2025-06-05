-- Set leader key
vim.g.mapleader = " "


-- Use system clipboard for all yank operations
vim.keymap.set({ "n", "v" }, "y", '"+y', { noremap = true })
vim.keymap.set("n", "Y", '"+Y', { noremap = true })
vim.keymap.set({ "n", "v" }, "d", '"+d', { noremap = true })
vim.keymap.set({ "n", "v" }, "x", '"+x', { noremap = true })
vim.keymap.set({ "n", "v" }, "p", '"+p', { noremap = true })
vim.keymap.set({ "n", "v" }, "P", '"+P', { noremap = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

