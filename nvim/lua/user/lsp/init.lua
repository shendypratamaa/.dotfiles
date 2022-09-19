local lsp_config = require 'lspconfig'
local navic = require 'nvim-navic'
local cmp = require 'cmp_nvim_lsp'

local cfg = {
  bind = true,
  hint_enable = true,
  max_width = 80,
  floating_window = false,
  floating_window_above_cur_line = false,
  toggle_key = '<C-p>',
  handler_opts = {
    border = 'rounded',
  },
}

local disable_diagnostics_lsp = function()
  vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
end

local on_attach = function(client, bufnr)
  require('user.lsp.saga').setup()
  require('user.lsp.typscript_utils').setup()
  require('user.lsp.lspkeymaps').setup(bufnr)

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

local update_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp.update_capabilities(update_capabilities)

local servers = {
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
  html = {},
  prosemd_lsp = {},
  cssls = {},
  tailwindcss = {},
  emmet_ls = {},
  yamlls = {},
}

local formatter = {
  'stylua',
  'prettier',
  'markdownlint',
  'write-good',
  'eslint_d',
  'fixjson',
}

for server_name, _ in pairs(servers) do
  local flags = {
    debounce_text_changes = 150,
  }

  local lsp_opts = {
    flags = flags,
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lsp_opts = vim.tbl_deep_extend('force', lsp_opts, servers[server_name] or {})
  lsp_config[server_name].setup(lsp_opts)

  if server_name == 'sumneko_lua' then
    lsp_config.sumneko_lua.setup(require('lua-dev').setup {
      library = { plugins = { 'neotest' }, types = true },
      lspconfig = lsp_opts,
    })
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
require('lsp_signature').setup(cfg)
require('user.lsp.null_ls').setup(on_attach)
require('user.lsp.mason').setup(servers, formatter)
