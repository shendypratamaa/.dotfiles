local M = {}

function M.setup()
  local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = 'ﯧ' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(
      sign.name,
      { texthl = sign.name, text = sign.text, numhl = '' }
    )
  end

  local diagnostics_config = {
    virtual_text = false,
    signs = true,
    underline = false,
    update_in_insert = true,
    severity_sort = true,
  }

  vim.diagnostic.config(diagnostics_config)

end

return M
