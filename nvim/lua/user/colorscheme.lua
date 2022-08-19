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
      local result = ck
      local load = pcall(require, path .. result)
      local value = pcall(vim.cmd, 'colorscheme ' .. result)
      require('user.lualine').setup(result)
      return load, value
    end
  end
end

-- NOTE :
colorscheme 'kanagawa'
