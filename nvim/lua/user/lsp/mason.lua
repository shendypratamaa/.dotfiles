local M = {}

function M.setup(lspservers, options, formatter)
  local lspconfig = require 'lspconfig'

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

  function formatterList(args)
    for _ , v in pairs(args) do
      return v
    end
  end

  require('mason-tool-installer').setup {
    ensure_installed = { formatterList(formatter) },
    auto_update = false,
    run_on_start = true,
  }

  -- mason-lspconfig
  require('mason-lspconfig').setup {
    ensure_installed = vim.tbl_keys(lspservers),
    automatic_installation = false,
  }

  require('mason-lspconfig').setup_handlers {
    function(server_name)
      local opts =
        vim.tbl_deep_extend('force', options, lspservers[server_name] or {})
      lspconfig[server_name].setup { opts }
    end,
    ['sumneko_lua'] = function()
      local opts =
        vim.tbl_deep_extend('force', options, lspservers['sumneko_lua'] or {})
      lspconfig.sumneko_lua.setup(require('lua-dev').setup { opts })
    end,
    ['tsserver'] = function()
      local opts =
        vim.tbl_deep_extend('force', options, lspservers['tsserver'] or {})
      lspconfig.tsserver.setup {
        disable_commands = false,
        debug = false,
        server = opts,
      }
    end,
  }
end

return M
