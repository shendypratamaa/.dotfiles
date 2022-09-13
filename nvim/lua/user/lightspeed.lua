local lightspeed = require 'lightspeed'

vim.keymap.set('n', 's', '<Plug>Lightspeed_s', {})
vim.keymap.set('n', 'S', '<Plug>Lightspeed_S', {})

vim.cmd [[
  autocmd ColorScheme * lua require'lightspeed'.init_highlight(true)
]]

lightspeed.setup {
  ignore_case = false,
  exit_after_idle_msecs = { unlabeled = nil, labeled = nil },
  jump_to_unique_chars = { safety_timeout = 400 },
  match_only_the_start_of_same_char_seqs = true,
  force_beacons_into_match_width = false,
  substitute_chars = { ['\r'] = '¬' },
  disable_default_maaping = true,
  special_keys = {
    next_match_group = '<space>',
    prev_match_group = '<tab>',
  },
  limit_ft_matches = 4,
  repeat_ft_with_target_char = false,
}
