local illuminate_ok, illuminate = pcall(require, 'illuminate')

if not illuminate_ok then
  return
end

local hl = vim.api.nvim_set_hl
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap(
  'n',
  '\\fs',
  ':lua require("illuminate").goto_next_reference()<CR>',
  opts
)
keymap(
  'n',
  '\\fd',
  ':lua require("illuminate").goto_prev_reference()<CR>',
  opts
)
keymap('n', '\\ff', ':lua require("illuminate").textobj_select()<CR>', opts)

illuminate.configure {
  providers = {
    'regex',
  },
  delay = 50,
  filetype_overrides = {},
  filetypes_denylist = {
    'NvimTree',
    'alpha',
    'packer',
    'qf',
    'OUTLINE',
    'help',
    'man',
    'lspinfo',
    'startuptime',
    'Trouble',
    'undotree_2',
  },
  filetypes_allowlist = {},
  modes_denylist = {},
  modes_allowlist = {},
  providers_regex_syntax_denylist = {},
  providers_regex_syntax_allowlist = {},
  under_cursor = false,
}
