local M = {}

function M.setup(servers, options, formatter)
  local lsp_config = require 'lspconfig'

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

  -- Set up LSP servers
  for server_name, _ in pairs(servers) do
    local opts =
      vim.tbl_deep_extend('force', options, servers[server_name] or {})

    if server_name == 'sumneko_lua' then
      opts = require('lua-dev').setup { lspconfig = opts }
    end

    if server_name == 'tsserver' then
      require('typescript').setup {
        disable_commands = false,
        debug = false,
        server = opts,
      }
    else
      lsp_config[server_name].setup(opts)
    end
  end

  -- BUG:
  -- require('mason-lspconfig').setup_handlers {
  --   function(server_name)
  --     local opts =
  --       vim.tbl_deep_extend('force', options, servers[server_name] or {})
  --     lsp_config[server_name].setup { opts }
  --   end,
  --   ['sumneko_lua'] = function()
  --     local opts =
  --       vim.tbl_deep_extend('force', options, servers['sumneko_lua'] or {})
  --     lsp_config.sumneko_lua.setup(require('lua-dev').setup { opts })
  --   end,
  --   ['tsserver'] = function()
  --     local opts =
  --       vim.tbl_deep_extend('force', options, servers['tsserver'] or {})
  --     require('typescript').setup {
  --       disable_commands = false,
  --       debug = false,
  --       server = opts,
  --     }
  --   end,
  --   ['jsonls'] = function()
  --     local opts =
  --       vim.tbl_deep_extend('force', options, servers['jsonls'] or {})
  --     lsp_config.jsonls.setup { opts }
  --   end,
  -- }
end

return M
