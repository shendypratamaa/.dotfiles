local M = {}

local function keymapWindow()
  local keymap = vim.keymap.set
  local term_opts = { silent = true }
  keymap('n', 'sp', ':FocusSplitNicely<cr>', term_opts)
end

function M.setup()
  keymapWindow()
  require('focus').setup {
    hybridnumber = false,
    winhighlight = false, -- when true issue with this colorscheme
    compatible_filetrees = { 'nvim-tree' },
    excluded_filetypes = { 'toggleterm' }, -- can ovverides window lspsaga
  }
end

return M
