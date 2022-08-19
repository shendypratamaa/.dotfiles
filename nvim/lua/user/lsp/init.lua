local M = {}

local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local capabilities = vim.lsp.protocol.make_client_capabilities()

local disable_servers = {
  'tsserver',
}

local disable_diagnostics_virtual_text_lsp = function(client)
  for _, v in pairs(disable_servers) do
    if client == v then
      vim.lsp.handlers['textDocument/publishDiagnostics'] = function()
        return false
      end
    end
  end
end

M.on_attach = function(client, bufnr)
  if client.name == 'sumneko_lua' then
    client.resolved_capabilities.document_formatting = false
  end

  require('user.lsp.clientservers').setup(client, bufnr)
  require('user.lsp.keymaps_lsp').setup(bufnr)
  require('user.lsp.handlers').setup(client)

  disable_diagnostics_virtual_text_lsp(client.name)
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

function M.setup()
  local formatter = {
    'stylua',
    'prettierd',
    'markdownlint',
    'write-good',
    'eslint_d',
    'selene',
    'fixjson'
  }

  local opts = {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }

  local servers = {
    html = {},
    jsonls = {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
      filetypes = { 'jsonc', 'json' },
    },
    sumneko_lua = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = {
              [vim.fn.expand '$VIMRUNTIME/lua'] = true,
              [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
            },
            maxPreload = 2000,
            preloadFileSize = 50000,
          },
          completion = { callSnippet = 'Both' },
          telemetry = { enable = false },
        },
      },
    },
    tsserver = { disable_formatting = true },
    prosemd_lsp = {},
    cssls = {},
    tailwindcss = {},
  }

  require 'user.lsp.null_ls'
  require 'user.lsp.saga'
  require('user.lsp.mason').setup(servers, opts, formatter)
end

return M
