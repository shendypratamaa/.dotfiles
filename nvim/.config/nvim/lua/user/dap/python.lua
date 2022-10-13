local py_ok, py = pcall(require, 'dap-python')
local path = "~/.venv/bin/python"

if not py_ok then
  vim.notify('notwork', 'error')
  return
end

local M = {}

function M.setup()
  py.setup(path)
end

return M
