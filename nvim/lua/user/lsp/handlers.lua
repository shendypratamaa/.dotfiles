local M = {}

function M.setup(client)
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

  local disable_servers = {
    'tsserver',
  }

  local disable_diagnostics_virtual_text_lsp = function(client)
    for _, v in pairs(disable_servers) do
      if v == client then
        vim.lsp.handlers['textDocument/publishDiagnostics'] = function()
          return false
        end
      end
    end
  end

  local lsp_highlight_document = function(client)
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_exec(
        [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
        false
      )
    end
  end
end

return M
