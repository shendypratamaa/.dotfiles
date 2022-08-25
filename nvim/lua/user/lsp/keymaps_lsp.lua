local M = {}

local function keymappings(bufnr)
  local function keymap_lsp(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local opts = { noremap = true, silent = true }

  keymap_lsp('n', 'gh', ':Lspsaga lsp_finder<CR>', opts)
  keymap_lsp('n', '<leader>ca', ':Lspsaga code_action<CR>', opts)
  keymap_lsp('n', 'K', ':Lspsaga hover_doc<CR>', opts)
  keymap_lsp('n', 'gs', ':Lspsaga signature_help<CR>', opts)
  keymap_lsp('n', 'gr', ':Lspsaga rename<CR>', opts)
  keymap_lsp('n', 'gD', ':Lspsaga preview_definition<CR>', opts)
  keymap_lsp('n', '[d', ':Lspsaga diagnostic_jump_next<CR>', opts)
  keymap_lsp('n', ']d', ':Lspsaga diagnostic_jump_prev<CR>', opts)
  keymap_lsp('n', 'gl', ':Lspsaga show_line_diagnostics<CR>', opts)
  keymap_lsp('v', 'pa', ':Lspsaga range_code_action<CR>', opts)

  keymap_lsp('n', 'gS', ':TSLspOrganize<CR>', opts)
  keymap_lsp('n', 'gR', ':TSLspRenameFile<CR>', opts)
  keymap_lsp('n', 'gn', ':TSLspImportAll<CR>', opts)

  keymap_lsp('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)

  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting_sync(nil, 2000)' ]]
end

M.setup = function(bufnr)
  keymappings(bufnr)
end

return M
