local function selectedColorscheme(args)
  local colorscheme = pcall(vim.cmd, 'colorscheme ' .. args)
  require('user.lualine').setup 'auto'
  return colorscheme
end

selectedColorscheme 'base16-nord'
