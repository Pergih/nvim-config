-- lua/plugins/nvimtree.lua
require("nvim-tree").setup({
  view = {
    width = 30,
    side = "left",
    relativenumber = true,
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false, -- change to true if you want to hide dotfiles
  },
  git = {
    enable = true,
    ignore = false,
  },
})

-- Keymaps
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle File Explorer' })
vim.keymap.set('n', '<leader>f', ':NvimTreeFocus<CR>', { desc = 'Focus File Explorer' })

-- Add at the end of plugins/nvimtree.lua
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if directory then
      vim.cmd.cd(data.file)
      require("nvim-tree.api").tree.open()
    end
  end
})



