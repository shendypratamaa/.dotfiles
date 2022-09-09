local M = {}

local function config_jsts()
  require('dap-vscode-js').setup {
    adapters = { 'pwa-node' },
  }

  for _, language in ipairs { 'typescript', 'javascript' } do
    require('dap').configurations[language] = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
      },
      {
        type = 'pwa-node',
        request = 'attach',
        name = 'Attach',
        processId = require('dap.utils').pick_process,
        cwd = '${workspaceFolder}',
      },
    }
  end
end

function M.setup()
  config_jsts()
end

return M
