vim.cmd [[
    if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
   endif
]]

require 'user.colorschemelist.gruvbox'
require 'user.colorschemelist.kanagawa'
require 'user.colorschemelist.tokyonight'
require 'user.colorschemelist.catppuccin'

-- opts | tokyonight -- kanagawa -- gruvbox-material -- catppuccin
local default_colorscheme = 'kanagawa'
local colorscheme = 'kanagawa'

local colorscheme_available, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)

if not colorscheme_available then
  local valueInfo =
    print('return back to default_colorscheme ' .. default_colorscheme)
  local valueDefault = vim.cmd('colorscheme ' .. default_colorscheme)
  return valueInfo, valueDefault
end
