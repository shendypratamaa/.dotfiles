local lspservers = {
  html = {},
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
      },
    },
  },
  sumneko_lua = {},
  tsserver = {},
  prosemd_lsp = {},
  cssls = {},
  tailwindcss = {},
}

local options = {}

local formatter = {
  'stylua',
  'prettierd',
  'markdownlint'
}

require 'user.lsp.null_ls'
require 'user.lsp.saga'
require('user.lsp.mason').setup(lspservers, options, formatter)
require('user.lsp.handlers').setup()
