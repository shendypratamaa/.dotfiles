vim.cmd [[
  hi FocusedWindow guibg=none
  hi link UnfocusedWindow CursorLine
  hi LineNr guibg=none guifg=#d8dee9
  hi Visual guibg=#d8dee9 guifg=#4c566a
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
    'TreesitterPlayground',
  },
  forced_filestypes = { 'dap_repl' },
}
