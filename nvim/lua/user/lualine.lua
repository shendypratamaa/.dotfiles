---@diagnostic disable: missing-parameter, redundant-parameter
local lualine_ok, lualine = pcall(require, 'lualine')
local navic_ok, navic = pcall(require, 'nvim-navic')

if not lualine_ok and navic_ok then
  return
end

local M = {}

local navic_info = {
  navic.get_location,
  cond = navic.is_available,
}

local hide_in_width = function()
  return vim.fn.winwidth(0) > 50
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
  symbols = { added = ' ', modified = ' ', removed = ' ' },
  cond = hide_in_width,
}

local filetype = {
  'filetype',
  icons_enabled = true,
  padding = 1,
}

local mode = {
  function()
    return '  '
  end,
}

local location = {
  'location',
  padding = 1,
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

local branch = {
  'branch',
  icons_enabled = true,
  icon = '',
  padding = 2,
  fmt = function(str)
    if str == '' or str == nil then
      return '!= vcs'
    end
    return str
  end,
}

local filename = {
  'filename',
  icon = ' ',
  icons_enabled = true,
  padding = 1,
  colored = true,
  symbols = {
    modified = '[+]',
    readonly = '[-]',
    unnamed = '[No Name]',
  },
  fmt = function()
    local str = vim.fn.expand('%:p')
    local sort = vim.fn.pathshorten(str)
    local res = string.lower(sort)
    return res
  end,
}

local encoding = {
  'encoding',
  padding = 1,
}

local function spaces()
  return 'spaces: ' .. vim.api.nvim_buf_get_option(0, 'shiftwidth')
end

local function cb_theme(theme)
  if not theme then
    return 'auto'
  end
end

function M.setup(theme)
  lualine.setup {
    options = {
      theme = cb_theme(theme),
      icons_enabled = true,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {},
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { mode },
      lualine_b = { branch },
      lualine_c = { filename, navic_info },
      lualine_x = { diff, diagnostics, spaces, encoding, filetype },
      lualine_y = { location },
      lualine_z = { progress },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { filename },
      lualine_x = { location },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  }
end

return M
