local lsp_config = require 'lspconfig'

local navic = require 'nvim-navic'

local disable_diagnostics_lsp = function()
  vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
end

local cmp = require 'cmp_nvim_lsp'

local on_attach = function(client, bufnr)
  require 'user.lsp.saga'
  require('user.lsp.ts_utils').setup()
  require('user.lsp.highlight').setup(client)
  require('user.lsp.keymaps_lsp').setup(client, bufnr)

  if client.name == 'sumneko_lua' then
    client.resolved_capabilities.document_formatting = false
    navic.attach(client, bufnr)
  end
  if client.name == 'tsserver' then
    client.resolved_capabilities.document_formatting = false
    navic.attach(client, bufnr)
  end
  if client.name == 'jsonls' then
    client.resolved_capabilities.document_formatting = false
    navic.attach(client, bufnr)
  end
end

local capabilities =
  cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

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

local flags = {
  debounce_text_changes = 150,
}

lsp_config.sumneko_lua.setup {
  flags = flags,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}

lsp_config.tsserver.setup {
  flags = flags,
  on_attach = on_attach,
  capabilities = capabilities,
  disable_diagnostics_lsp(),
}

lsp_config.jsonls.setup {
  flags = flags,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
}

lsp_config.cssls.setup {
  flags = flags,
  on_attach = on_attach,
  capabilities = capabilities,
}

lsp_config.pyright.setup {
  flags = flags,
  on_attach = on_attach,
  capabilities = capabilities,
}

lsp_config.html.setup {}
lsp_config.tailwindcss.setup {}
lsp_config.prosemd_lsp.setup {}

require('user.lsp.handlers').setup()

require 'user.lsp.null_ls'
require('user.lsp.mason').setup(servers, formatter)
