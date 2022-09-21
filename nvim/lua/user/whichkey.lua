local status_ok, which_key = pcall(require, 'which-key')

if not status_ok then
  return
end

local wk = which_key

local setup = {
  plugins = {
    marks = false, -- shows a list of your marks on ' and `
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = 'Comments' },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    ['<space>'] = 'SPC',
    ['<cr>'] = 'RET',
    ['<tab>'] = 'TAB',
  },
  icons = {
    breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
    separator = '➜', -- symbol used between a key and it's label
    group = '+', -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = 'single', -- none, single, double, shadow
    position = 'bottom', -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 3, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 10, -- spacing between columns
    align = 'center', -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  -- triggers = 'auto', -- automatically setup triggers
  triggers = { '<leader>' }, -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { 'j', 'k' },
    v = { 'j', 'k' },
  },
}

local opts = {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps:
}

local keybinds = {
  D = { '<cmd>:Bwipeout<CR>', 'Delete Buffer' },
  s = { '<cmd>:w!<CR>', 'Save Files' },
  S = { '<cmd>StartupTime<CR>', 'Startup Time' },
  q = { '<cmd>:wq!<CR>', 'Quit Save' },
  h = { '<cmd>sv<CR>', 'Split Horizontal' },
  v = { '<cmd>vs<CR>', 'Split Vertical' },
  n = { '<cmd>NvimTreeToggle<CR>', 'Explorer' },
  N = { '<cmd>NeorgStart<CR>', 'Notes' },
  F = { '<cmd>Format<CR>', 'Format File' },
  t = {
    name = 'Telescope',
    T = {'<cmd>lua require("user.telescope").colorscheme_pick()<CR>', 'Change Colorscheme'},
    f = {'<cmd>lua require("telescope.builtin").find_files()<CR>', 'Find Files'},
    b = {'<cmd>lua require("telescope.builtin").buffers()<CR>', 'Buffers'},
    r = {'<cmd>lua require("telescope.builtin").live_grep()<CR>', 'Live Grep'},
    h = {'<cmd>lua require("telescope.builtin").help_tags()<CR>', 'Help Tags'},
    g = {'<cmd>Telescope<CR>', 'Telescope list builtins'},
    e = {'<cmd>TodoTelescope<CR>', 'Todo Notes'},
    t = {'<cmd>Telescope bookmarks', 'Bookmars Browser'},
    v = {'<cmd>lua require("telescope").extensions.project.project{ display_type = "full"}<CR>', 'Project'}
  },
  l = {
    name = 'LSP',
    h = { '<cmd>LspInfo<CR>', 'Lsp Info' },
    j = { '<cmd>Mason<CR>', 'Mason Info' },
    n = { '<cmd>NullLsInfo<CR>', 'NullLs Info' },
  },
}

wk.setup(setup)
wk.register(keybinds, opts)
