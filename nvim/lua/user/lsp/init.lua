local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()

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
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';'),
        },
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

M.on_attach = function(client, bufnr)
  require 'user.lsp.saga'

  require('user.lsp.ts_utils').setup()

  require('user.lsp.highlight').setup(client)

  require('user.lsp.keymaps_lsp').setup(client, bufnr)
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

M.capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local opts = {
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

require('user.lsp.handlers').setup()

function M.setup()
  require('user.lsp.null_ls').setup(opts)
  require('user.lsp.mason').setup(servers, opts, formatter)
end

return M
