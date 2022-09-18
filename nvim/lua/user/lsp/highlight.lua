local M = {}

local function lsp_highlight_document(client, bufnr)
  if client.resolved_capabilities.document_highlight then
    local opts = { clear = false }
    local augroup = vim.api.nvim_create_augroup('LspDocumentHighlight', opts)
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
        vim.lsp.buf.document_highlight()
      end,
    })
  end
end

function M.setup(client, bufnr)
  lsp_highlight_document(client, bufnr)
end

return M
