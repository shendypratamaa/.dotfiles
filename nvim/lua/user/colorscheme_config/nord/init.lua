local M = {}

local function nord_theme_utils()
  vim.g.nord_contrast = true
  vim.g.nord_borders = true
  vim.g.nord_disable_background = false
  vim.g.nord_uniform_diff_background = false
  vim.g.nord_italic = false
  vim.g.nord_cursorline_transparent = true
end

function M.setup()
  nord_theme_utils()
  require('nord').set()
  require('user.colorscheme_config.nord.utils').setup()
end

return M
