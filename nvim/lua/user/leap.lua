local leap_ok, leap = pcall(require, 'leap')

if not leap_ok then
  return
end

vim.cmd [[
  autocmd ColorScheme * lua require('leap').init_highlight(true)
]]

leap.set_default_keymaps {}

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
    vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = '#707070' }),
}
