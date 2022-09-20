local nord_ok, nord = pcall(require, 'nord')

if not nord_ok then
  return
end

local M = {}

local function nord_theme_utils()
  vim.g.nord_contrast = true
  vim.g.nord_borders = true
  vim.g.nord_disable_background = false
  vim.g.nord_italic = false
  vim.g.nord_uniform_diff_background = false
end

local function nord_single_sources(theme)
  nord_theme_utils()
  nord.set()
  require('user.colorscheme_config.nord.utils').setup(theme)
end

function M.setup(theme)
  if theme == 'nord' then
    nord_single_sources(theme)
  elseif theme == 'base16-nord' then
    require('user.colorscheme_config.nord.utils').setup(theme)
  end
end

return M
