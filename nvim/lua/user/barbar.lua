---@diagnostic disable: missing-parameter
local barbar_ok, barbar = pcall(require, 'bufferline')
local bufferline_state = require 'bufferline.state'

if not barbar_ok then
  return
end

local autocmd = vim.api.nvim_create_autocmd
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', '<s-h>', '<cmd>BufferPrevious<CR>', opts)
keymap('n', '<s-l>', '<cmd>BufferNext<CR>', opts)
keymap('n', '\\1', '<cmd>BufferPin<CR>', opts)
keymap('n', '\\da', '<cmd>BufferCloseAllButPinned<CR>', opts)

autocmd('BufWinEnter', {
  pattern = '*',
  callback = function()
    if vim.bo.filetype == 'NvimTree' then
      bufferline_state.set_offset(32, 'Directory')
    end
  end,
})

autocmd('BufWinLeave', {
  pattern = '*',
  callback = function()
    if vim.fn.expand('<afile>'):match 'NvimTree' then
      bufferline_state.set_offset(0)
    end
  end,
})

barbar.setup {
  animation = true,
  auto_hide = false,
  tabpages = true,
  closable = true,
  clickable = true,
  exclude_ft = {},
  exclude_name = {},
  icons = 'both',
  icon_custom_colors = false,
  icon_separator_active = '  ',
  icon_separator_inactive = '▎',
  icon_close_tab = '',
  icon_close_tab_modified = '●',
  icon_pinned = '車',
  insert_at_end = false,
  insert_at_start = false,
  maximum_padding = 0,
  maximum_length = 30,
  semantic_letters = true,
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
  no_name_title = nil,
}
