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
  require('user.lsp.keymaps_lsp').setup(bufnr)

  if client.name == 'sumneko_lua' then
    client.resolved_capabilities.document_formatting = false
    navic.attach(client, bufnr)
  end
  if client.name == 'tsserver' then
    client.resolved_capabilities.document_formatting = false
    navic.attach(client, bufnr)
    disable_diagnostics_lsp()
  end
  if client.name == 'pyright' then
    client.resolved_capabilities.document_formatting = false
    navic.attach(client, bufnr)
    disable_diagnostics_lsp()
  end
  if client.name == 'jsonls' then
    client.resolved_capabilities.document_formatting = false
    navic.attach(client, bufnr)
  end
  if client.name == 'html' then
    client.resolved_capabilities.document_formatting = false
  end
end

local capabilities =
  cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = {
  html = {},
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
      },
    },
  },
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
      },
    },
  },
  tsserver = { disable_formatting = true },
  pyright = {
    analysis = {
      typeCheckingMode = 'off',
    },
  },
  prosemd_lsp = {},
  cssls = {},
  tailwindcss = {},
  emmet_ls = {},
}

local formatter = {
  'stylua',
  'prettierd',
  'markdownlint',
  'write-good',
  'eslint_d',
  'isort',
  'black',
  'flake8',
  'fixjson',
}

local flags = {
  debounce_text_changes = 150,
}

for server_name, _ in pairs(servers) do
  local lsp_opts = {
    flags = flags,
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lsp_opts = vim.tbl_deep_extend('force', lsp_opts, servers[server_name] or {})
  lsp_config[server_name].setup(lsp_opts)

  if server_name == 'sumneko_lua' then
    lsp_opts = require('lua-dev').setup { lspconfig = lsp_opts }
  end

  if server_name == 'tsserver' then
    lsp_opts = require('typescript').setup {
      debug_commands = false,
      debug = false,
      server = lsp_opts,
    }
  end
end

require('user.lsp.handlers').setup()

require 'user.lsp.null_ls'
require('user.lsp.mason').setup(servers, formatter)
