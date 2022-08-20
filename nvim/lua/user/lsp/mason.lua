local M = {}

function M.setup(servers, options, formatter)
  local lsp_config = require 'lspconfig'

  local disable_diagnostics_lsp = function()
    vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
  end

  local function extend(...)
    vim.tbl_deep_extend(...)
  end

  -- mason
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

  -- mason-lspconfig
  require('mason-lspconfig').setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = false,
  }

  local install_root_dir = vim.fn.stdpath 'data' .. 'mason'

  require('mason-lspconfig').setup_handlers {
    function(server_name)
      local opts = extend('force', options, servers[server_name] or {})
      lsp_config[server_name].setup { opts }
    end,
    ['sumneko_lua'] = function()
      local opts = extend('force', options, servers['sumneko_lua'] or {})
      lsp_config.sumneko_lua.setup(require('lua-dev').setup { opts })
    end,
    ['tsserver'] = function()
      local opts = extend('force', options, servers['tsserver'] or {})
      require('typescript').setup {
        disable_commands = false,
        debug = false,
        server = opts,
      }
    end,
  }

  lsp_config.sumneko_lua.setup {
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
    end,
  }

  lsp_config.tsserver.setup {
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
    end,
  }

  disable_diagnostics_lsp()
end

return M
