-- Make sure Lazy is installed first
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Core plugins
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim", config = function() require("plugins.telescope") end },
  { "lewis6991/gitsigns.nvim", config = function() require("plugins.gitsigns") end },
  { "nvim-lualine/lualine.nvim", config = function() require("plugins.lualine") end },
  { "Mofiqul/vscode.nvim" },
  {
  'williamboman/mason.nvim',          -- LSP installer
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',          -- LSP base config
    'hrsh7th/nvim-cmp',               -- Autocompletion engine
    'hrsh7th/cmp-nvim-lsp',           -- LSP completions
    'L3MON4D3/LuaSnip',               -- Snippet engine
    'saadparwaiz1/cmp_luasnip',       -- Snippet completions
    'hrsh7th/cmp-buffer',             -- Buffer completions
    'hrsh7th/cmp-path',               -- Path completions
    'jose-elias-alvarez/null-ls.nvim',-- Formatters and linters
  },
  config = function()
    require('plugins.lsp')            -- We'll create this next
  end
}

  -- more plugins...
})

