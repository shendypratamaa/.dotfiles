vim.cmd [[
  hi FocusedWindow guibg=none
  hi UnfocusedWindow guibg=#434c5e
  hi Visual guifg=#4c566a guibg=#eceff4
]]

require('focus').setup {
  winhighlight = true,
  enable = true,
  width = 90,
  quickfixheight = 20,
  treewidth = 20,
  compatible_filetrees = { 'NvimTree' },
  excluded_filetypes = {
    'ToggleTerm',
    'UndoTreeToggle',
    'TelescopePrompt',
    'SymbolsOutline',
    'harpoon',
    'help',
  },
  forced_filestypes = { 'dap_repl' },
}
