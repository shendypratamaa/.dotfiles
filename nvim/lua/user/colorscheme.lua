local function pick_colorscheme(theme)
  local colorscheme = pcall(vim.cmd, 'colorscheme ' .. theme)
  require('user.colorscheme_config.init').setup(theme)
  require('user.lualine').setup(theme)
  return colorscheme
end

-- WARNING: Colorscheme Terms
-- colorscheme available base16-bundle include base16-nord and nord-single-source 📦
-- <cmd>Telecope colorscheme<cr> or ]g for seeing all options 📚
-- only specified coloschemes have telescope floating border config 💔

pick_colorscheme 'nord'
