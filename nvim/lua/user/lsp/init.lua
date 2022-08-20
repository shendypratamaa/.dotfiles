local M = {}

local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local capabilities = vim.lsp.protocol.make_client_capabilities()

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
      },
    },
  },
  tsserver = { disable_formatting = true },
  prosemd_lsp = {},
  cssls = {},
  tailwindcss = {},
}

M.on_attach = function(client, bufnr)
  require 'user.lsp.saga'

  require('user.lsp.ts_utils').setup()

  require('user.lsp.highlight').setup(client)

  require('user.lsp.keymaps_lsp').setup(bufnr)
end

local formatter = {
  'stylua',
  'prettierd',
  'markdownlint',
  'write-good',
  'eslint_d',
  'selene',
  'fixjson',
}

require('user.lsp.handlers').setup()

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local opts = {
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

function M.setup()
  require('user.lsp.null_ls').setup(opts)
  require('user.lsp.mason').setup(servers, opts, formatter)
end

return M
