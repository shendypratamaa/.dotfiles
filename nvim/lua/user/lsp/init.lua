local servers = {
  html = {},
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas()
      },
    },
  },
  sumneko_lua = {},
  tsserver = {},
  prosemd_lsp = {},
  cssls = {},
  tailwindcss = {}
}

local options = {}

local formatter = {
 "stylua",
}

require"user.lsp.null_ls"
require"user.lsp.saga"
require"user.lsp.mason".setup(servers, options, formatter)
-- require"user.lsp.handlers".on_attach(client, bufnr)
require"user.lsp.handlers".setup()
