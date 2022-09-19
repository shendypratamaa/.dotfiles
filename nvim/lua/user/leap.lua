local leap_ok, leap = pcall(require, 'leap')

if not leap_ok then
  return
end

leap.set_default_keymaps {}

local hl = vim.api.nvim_set_hl

leap.setup {
  max_aot_targets = nil,
  highlight_unlabeled = false,
  case_sensitive = false,
  equivalence_classes = { ' \t\r\n' },
  special_keys = {
    repeat_search = '<enter>',
    next_match = '<enter>',
    prev_match = '<tab>',
    next_group = '<space>',
    prev_group = '<tab>',
  },
  hl(0, 'LeapBackdrop', { fg = '#707070' }),
  hl(0, 'LeapLabelPrimary', { bg = '#36567a', fg = '#ffffff' }),
}
