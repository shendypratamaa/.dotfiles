local M = {}

local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'

function M.setup()
  require('dap-python').setup(path)
end

return M
