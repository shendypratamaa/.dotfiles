local cybu_ok, cybu = pcall(require, 'cybu')
local keymap = vim.keymap.set
local opts = { silent = true }

if not cybu_ok then
  return
end

keymap('n', '<s-h>', '<Plug>(CybuPrev)', opts)
keymap('n', '<s-l>', '<Plug>(CybuNext)', opts)

local cfg = {
  position = {
    relative_to = 'editor', -- win, editor, cursor
    anchor = 'topleft', -- topleft, topcenter, topright,
    -- centerleft, center, centerright,
    -- bottomleft, bottomcenter, bottomright
    vertical_offset = 0, -- vertical offset from anchor in lines
    horizontal_offset = 0, -- vertical offset from anchor in columns
    max_win_height = 5, -- height of cybu window in lines
    max_win_width = 0.5, -- integer for absolute in columns
    -- float for relative to win/editor width
  },
  style = {
    path = 'relative', -- absolute, relative, tail (filename only)
    border = 'rounded', -- single, double, rounded, none
    separator = ' ', -- string used as separator
    prefix = '…', -- string used as prefix for truncated paths
    padding = 5, -- left & right padding in number of spaces
    hide_buffer_id = true, -- hide buffer IDs in window
    devicons = {
      enabled = true, -- enable or disable web dev icons
      colored = true, -- enable color for web dev icons
      truncate = true, -- truncate wide icons to one char width
    },
    highlights = { -- see highlights via :highlight
      current_buffer = 'CybuFocus', -- current / selected buffer
      adjacent_buffers = 'CybuAdjacent', -- buffers not in focus
      background = 'CybuBackground', -- window background
      border = 'CybuBorder', -- border of the window
    },
  },
  behavior = { -- set behavior for different modes
    mode = {
      default = {
        switch = 'immediate', -- immediate, on_close
        view = 'paging', -- paging, rolling
      },
      last_used = {
        switch = 'on_close', -- immediate, on_close
        view = 'paging', -- paging, rolling
      },
    },
  },
  display_time = 1250, -- time the cybu window is displayed
  exclude = { -- filetypes, cybu will not be active
    'neo-tree',
    'fugitive',
    'qf',
  },
  fallback = function() end, -- arbitrary fallback function
}

cybu.setup(cfg)
