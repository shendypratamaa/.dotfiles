require('focus').setup {
  winhighlight = true,
  enable = true,
  width = 90,
  quickfixheight = 20,
  treewidth = 20,
  compatible_filetrees = { 'NvimTree' },
  excluded_filetypes = {
    'TelescopePrompt',
    'SymbolsOutline',
    'toggleterm',
    'undotree',
    'harpoon',
    'help',
    'cmdline'
  },
  forced_filestypes = { 'dap_repl' },
}
