local M = {}

local navic = require 'nvim-navic'

local navic_info = {
  navic.get_location,
  cond = navic.is_available,
}

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  sections = { 'error', 'warn' },
  symbols = {
    error = ' ',
    warn = ' ',
  },
  colored = true,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  'diff',
  colored = true,
  symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
  cond = hide_in_width,
}

local mode = {
  'mode',
  fmt = function(str)
    return '-- ' .. str .. ' --'
  end,
}

local filetype = {
  'filetype',
  icons_enabled = true,
  icon = nil,
}

local branch = {
  'branch',
  icons_enabled = true,
  icon = '',
}

local location = {
  'location',
  padding = 0,
}

local progress = function()
  local current_line = vim.fn.line '.'
  local total_lines = vim.fn.line '$'
  local chars = {
    '__',
    '▁▁',
    '▂▂',
    '▃▃',
    '▄▄',
    '▅▅',
    '▆▆',
    '▇▇',
    '██',
  }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local filePath = {
  'filename',
  icons_enabled = true,
  icon = '',
  file_status = true,
  path = 0,
  symbols = {
    modified = '[+]', -- Text to show when the file is modified.
    readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
    unnamed = '[No Name]', -- Text to show for unnamed buffers.
  },
}

function M.setup(theme)
  require('lualine').setup {
    options = {
      theme = theme,
      icons_enabled = true,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {},
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { mode },
      lualine_b = { branch },
      lualine_c = { filePath, navic_info },
      lualine_x = { diagnostics, diff, filetype, 'encoding' },
      lualine_y = { location },
      lualine_z = { progress },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  }
end

return M
