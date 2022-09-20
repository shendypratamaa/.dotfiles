local py_ok, py = pcall(require, 'dap-python')
local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'

if not py_ok then
  return
end

local M = {}

function M.setup()
  py.setup(path)
end

return M
