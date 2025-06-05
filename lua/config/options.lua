vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = ggVGtrue
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Set encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Cpy Pst
vim.api.nvim_set_option("clipboard", "unnamed")


vim.g.clipboard = {
  name = "xclip",
  copy = {
    ["+"] = "xclip -selection clipboard",
    ["*"] = "xclip -selection primary",
  },
  paste = {
    ["+"] = "xclip -selection clipboard -o",
    ["*"] = "xclip -selection primary -o",
  },
  cache_enabled = 0,
}


-- Undo Tree

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"

