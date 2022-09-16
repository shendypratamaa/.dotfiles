local function nord_telescope()
  local TelescopePrompt = {
    TelescopeSelection = {
      bg = '#434c5e',
    },
    TelescopePromptBorder = {
      fg = '#3b4252',
      bg = '#3b4252',
    },
    TelescopePromptNormal = {
      fg = '#eceff4',
      bg = '#3b4252',
    },
    TelescopeMatching = {
      fg = '#eceff4',
      bg = '#81a1c1',
    },
    TelescopePromptTitle = {
      fg = '#eceff4',
      bg = '#b48ead',
    },
    TelescopePreviewTitle = {
      fg = '#eceff4',
      bg = '#a3be8c',
    },
    TelescopeResultsTitle = {
      fg = '#eceff4',
      bg = '#d08770',
    },
    TelescopePreviewBorder = {
      fg = '#2e3440',
    },
    TelescopeResultsBorder = {
      fg = '#2e3440',
    },
  }
  for hl, col in pairs(TelescopePrompt) do
    vim.api.nvim_set_hl(0, hl, col)
  end
end

local function nord_props()
  vim.g.nord_contrast = true
  vim.g.nord_borders = true
  vim.g.nord_disable_background = false
  vim.g.nord_uniform_diff_background = false
  vim.g.nord_italic = false
  vim.g.nord_cursorline_transparent = true
end

local function nord_setup()
  nord_props()
  require('nord').set()
  nord_telescope()
end

local function selectedColorscheme(theme)
  local colorscheme = pcall(vim.cmd, 'colorscheme ' .. theme)
  if theme == 'nord' then
    nord_setup()
  end
  require('user.lualine').setup 'auto'
  return colorscheme
end

-- WARNING: if prefer using base16 e.g :colorscheme {base16-{name}} | nord
selectedColorscheme 'nord'
