local M = {}

local disable_diagnostics_lsp = function()
  vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
end

function M.setup(servers, options, formatter)
  local lsp_config = require 'lspconfig'
  local navic = require 'nvim-navic'

  require('mason').setup {
    ui = {
      border = 'rounded',
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
    },
  }

  require('mason-tool-installer').setup {
    ensure_installed = formatter,
    auto_update = false,
    run_on_start = true,
    start_delay = 3000,
  }

  require('mason-lspconfig').setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = false,
  }

  require('mason-lspconfig').setup_handlers {
    function(server_name)
      local opts =
        vim.tbl_deep_extend('force', options, servers[server_name] or {})
      lsp_config[server_name].setup { opts }
    end,

    ['sumneko_lua'] = function()
      local opts = vim.tbl_deep_extend('force', options, servers['sumneko_lua'])
      lsp_config.sumneko_lua.setup(require('lua-dev').setup {
        lspconfig = {
          on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            navic.attach(client, bufnr)
          end,
          opts,
        },
      })
    end,

    ['tsserver'] = function()
      local opts = vim.tbl_deep_extend('force', options, servers['tsserver'])
      require('typescript').setup {
        disable_commands = false,
        debug = false,
        server = {
          on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            navic.attach(client, bufnr)
            disable_diagnostics_lsp()
          end,
          opts,
        },
      }
    end,

    ['jsonls'] = function()
      local opts = vim.tbl_deep_extend('force', options, servers['jsonls'])
      lsp_config.jsonls.setup {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
          },
        },
        on_attach = function(client, bufnr)
          client.resolved_capabilities.document_formatting = false
          navic.attach(client, bufnr)
        end,
        opts,
      }
    end,
  }
end

return M
