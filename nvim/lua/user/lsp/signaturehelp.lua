local M = {}

local signature = require 'lsp_signature'

function M.setup(bufnr)
  signature.on_attach({
    bind = true,
    handler_opts = {
      border = 'rounded',
    },
  }, bufnr)
end

return M
