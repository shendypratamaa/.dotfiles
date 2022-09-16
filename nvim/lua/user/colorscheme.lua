local function pick_colorscheme(theme)
  local colorscheme = pcall(vim.cmd, 'colorscheme ' .. theme)
  require('user.colorscheme_config.init').setup(theme)
  require('user.lualine').setup(theme)
  return colorscheme
end

-- WARNING: colorscheme terms
-- for now list colorscheme base16-bundle and nord-single-source 📦
-- <cmd>Telecope colorscheme<cr> or ]g for seeing all available colorschemes 📚
-- not all colorschemes have utility for telescope floating border 💔

pick_colorscheme 'base16-nebula'
