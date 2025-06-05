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

    -- Colorscheme
    {
        "Mofiqul/vscode.nvim",
        priority = 1000,
        config = function()
            vim.o.background = "dark"
            require("vscode").setup({})
            require("vscode").load()
        end
    },
    -- Vim be good
    {
        "ThePrimeagen/vim-be-good",
        cmd = {
            "VimBeGood", 
        },
    },


    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 30,
                    side = "left",
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,
                },
            })

            vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle File Explorer' })
            vim.keymap.set('n', '<leader>f', ':NvimTreeFocus<CR>', { desc = 'Focus File Explorer' })
        end
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup {
                options = {
                    theme = "vscode",
                    section_separators = "",
                    component_separators = "",
                }
            }
        end
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    "lua", "python", "cpp", "c", "javascript", "typescript", "bash", "html", "json", "css", "markdown"
                },
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                },
            })
        end
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects"
    },



    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files)
            vim.keymap.set("n", "<leader>fg", builtin.live_grep)
            vim.keymap.set("n", "<leader>fb", builtin.buffers)
            vim.keymap.set("n", "<leader>fh", builtin.help_tags)
        end
    },

    -- Git signs
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitsigns").setup()
        end
    },

    -- Git integration
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gwrite", "Gread", "Glog", "Ggrep", "Gstatus", "Gbrowse" },
        keys = {
            { "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
        }
    },



    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup()

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
        end
    },

    -- Tmux navigation
    {
        "christoomey/vim-tmux-navigator",
        lazy = false
    },

    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
        },
        config = function()
            vim.g.undotree_WindowLayout = 2 -- Horizontal split layout (1 is vertical)
            vim.g.undotree_SetFocusWhenToggle = 1
            vim.g.undotree_SplitWidth = 25  -- width for vertical split (default is 50)
            vim.g.undotree_SplitHeight = 1  -- height for horizontal split (default is 10)
        end
    },
    -- LSP & Autocompletion via lsp-zero
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        },
        config = function()
            local lsp = require('lsp-zero').preset({})

            lsp.on_attach(function(_, bufnr)
                local opts = { buffer = bufnr }
                local map = vim.keymap.set

                map('n', 'K', vim.lsp.buf.hover, opts)
                map('n', 'gd', vim.lsp.buf.definition, opts)
                map('n', 'gD', vim.lsp.buf.declaration, opts)
                map('n', 'gi', vim.lsp.buf.implementation, opts)
                map('n', 'go', vim.lsp.buf.type_definition, opts)
                map('n', 'gr', vim.lsp.buf.references, opts)
                map('n', 'gs', vim.lsp.buf.signature_help, opts)
                map('n', '<F2>', vim.lsp.buf.rename, opts)
                map({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end, opts)
                map('n', '<F4>', vim.lsp.buf.code_action, opts)
            end)

            lsp.setup()

            -- mason
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'lua_ls', 'clangd', 'pyright', 'bashls', 'html', 'cssls', 'jsonls'
                },
                handlers = {
                    lsp.default_setup,
                },
            })

            -- nvim-cmp setup
            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-j>'] = cmp.mapping.complete(),
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                },
            })
        end
    },

    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    -- for Python
                    null_ls.builtins.formatting.black.with({
                        extra_args = { "--line-length", "88" },
                    }),
                    -- for C/C++
                    null_ls.builtins.formatting.clang_format.with({
                        extra_args = { "--style", "{IndentWidth: 4, TabWidth: 4, UseTab: Never}" }
                    }),
                    -- optionally for Lua, JS, etc
                    -- null_ls.builtins.formatting.prettier,
                },
            })
            vim.keymap.set({ 'n', 'x' }, '<F3>', function()
                vim.lsp.buf.format({ async = true, timeout_ms = 3000 })
            end, { desc = "Format buffer" })
        end
    },


})
