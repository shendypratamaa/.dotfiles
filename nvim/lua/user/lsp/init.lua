local M = {}

local servers = {
  html = {},
  jsonls = {},
  sumneko_lua = {},
  tsserver = {},
  pyright = {},
  prosemd_lsp = {},
  cssls = {},
  tailwindcss = {},
}

local formatter = {
  'stylua',
  'prettierd',
  'markdownlint',
  'write-good',
  'eslint_d',
  'selene',
  'isort',
  'black',
  'flake8',
}

local on_attach = function(client, bufnr)
  require 'user.lsp.saga'
  require('user.lsp.ts_utils').setup()
  require('user.lsp.highlight').setup(client)
  require('user.lsp.keymaps_lsp').setup(client, bufnr)
end

local cmp = require 'cmp_nvim_lsp'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local server_capabilities = cmp.update_capabilities(capabilities)

local opts = {
  on_attach = on_attach,
  capabilities = server_capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

require('user.lsp.handlers').setup()

function M.setup()
  require('user.lsp.null_ls').setup(opts)
  require('user.lsp.mason').setup(servers, opts, formatter)
end

return M
