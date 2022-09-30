local mason_ok, mason = pcall(require, 'mason')
local masontool_ok, masontool = pcall(require, 'mason-tool-installer')
local masonlsp_ok, masonlsp = pcall(require, 'mason-lspconfig')

if not mason_ok and masontool_ok and masonlsp_ok then
  return
end

local M = {}

function M.setup(servers, formatter)
  mason.setup {
    ui = {
      border = 'rounded',
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
    },
  }

  masontool.setup {
    ensure_installed = formatter,
    auto_update = false,
    run_on_start = true,
    start_delay = 3000,
  }

  masonlsp.setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true,
  }
end

return M
