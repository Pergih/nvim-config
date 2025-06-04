-- require("config.options")
require("config.keymaps")
-- require("config.plugins")
-- require("config.colorscheme")


-- Key mappings
-- vim.api.nvim_set_keymap("n", "<leader>w",":w<CR>", { noremap = true, silent = true }) 
-- vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { noremap = true, silent = true}) 


-- Set encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"


-- Plugin manager setup: lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function()
      -- Options: dark / light
      vim.o.background = "dark"
      require("vscode").setup({})
      require("vscode").load()
    end
    },


{
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('plugins.nvimtree')
  end
},

    {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional, for icons
    config = function()
    require('lualine').setup {
      options = {
        theme = 'vscode',  -- Match with the colorscheme
        section_separators = '',
        component_separators = '',
        }
    }
    end
    },

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }, -- required
        
        config = function()
            require('telescope').setup()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end
    },
    
    {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('gitsigns').setup()
    end
    },

{
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require('harpoon')

    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
  end
},
{
  "christoomey/vim-tmux-navigator",
  lazy = false
},



    { "neovim/nvim-lspconfig" },
})

