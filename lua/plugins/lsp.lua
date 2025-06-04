-- mason: installs LSP servers easily
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "clangd", "tsserver" }, -- customize per your languages
  automatic_installation = true,
})

-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
})

-- LSP attach logic
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("gd", vim.lsp.buf.definition, "Go to Definition")
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
  nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  nmap("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
  nmap("]d", vim.diagnostic.goto_next, "Next Diagnostic")
end

-- Setup language servers
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = { "lua_ls", "pyright", "clangd", "tsserver" }
for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

-- Formatter/linter (null-ls)
require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.prettier,   -- JS/TS
    require("null-ls").builtins.formatting.stylua,     -- Lua
    require("null-ls").builtins.formatting.black,      -- Python
  },
  on_attach = on_attach,
})

