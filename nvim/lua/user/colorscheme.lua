local path = 'user.colorschemelist.'

local colorscheme_list = {
  'kanagawa',
  'onenord',
  'gruvbox-material',
  'catppuccin',
  'tokyonight',
}

local colorscheme = function(selected)
  for k, _ in pairs(colorscheme_list) do
    local ck = colorscheme_list[k]
    if selected == ck then
      local v = ck
      local load = require(path .. v)
      local value = vim.cmd('colorscheme ' .. v)
      require('user.lualine').setup(v)
      return load, value
    end
  end
end

-- NOTE :
colorscheme 'tokyonight'
