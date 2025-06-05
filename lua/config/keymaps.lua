-- Set leader key
vim.g.mapleader = " "


-- Use system clipboard for all yank operations
vim.keymap.set({ "n", "v" }, "y", '"+y', { noremap = true })
vim.keymap.set("n", "Y", '"+Y', { noremap = true })
vim.keymap.set({ "n", "v" }, "d", '"+d', { noremap = true })
vim.keymap.set({ "n", "v" }, "x", '"+x', { noremap = true })
vim.keymap.set({ "n", "v" }, "p", '"+p', { noremap = true })
vim.keymap.set({ "n", "v" }, "P", '"+P', { noremap = true })

