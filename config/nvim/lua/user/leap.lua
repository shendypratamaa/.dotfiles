local leap_ok, leap = pcall(require, "leap")
local flit_ok, flit = pcall(require, "flit")
local keymap        = vim.keymap.set
local hl            = vim.api.nvim_set_hl

if not leap_ok and flit_ok then
  return
end

local flit_cfg = {
  keys = { f = "f", F = "F", t = "t", T = "T" },
  labeled_modes = "v",
  multiline = false,
  opts = {},
}

local leap_cfg = {
  max_aot_targets = nil,
  highlight_unlabeled = true,
  case_sensitive = false,
  equivalence_classes = { " \t\r\n" },
  special_keys = {
    repeat_search = "<enter>",
    next_match = "<enter>",
    prev_match = "<tab>",
    next_group = "<space>",
    prev_group = "<tab>",
  },
  hl(0, "LeapBackdrop", { fg = "#707070" }),
  hl(0, "LeapMatch", { link = "HlSearchLens" }),
  hl(0, "LeapLabelPrimary", { link = "HlSearchLens" })
}

keymap({'n', 'x', 'o'}, 'vn', function() require('leap-ast').leap() end, {})

leap.set_default_keymaps {}

flit.setup(flit_cfg)
leap.setup(leap_cfg)
