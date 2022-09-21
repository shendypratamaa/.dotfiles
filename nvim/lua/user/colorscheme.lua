local function colorscheme(theme)
  local cmd_colors = pcall(vim.cmd, 'colorscheme ' .. theme)
  require('user.colorscheme_config.init').setup(theme)
  require('user.lualine').setup(theme)
  return cmd_colors
end

-- WARNING: Colorscheme Terms
-- colorscheme available base16-bundle include base16-nord and nord-single-source 📦
-- press <leader> T and choose change colorscheme for see all list 📚
-- only specified coloschemes have telescope floating border config 💔

colorscheme "nord"
