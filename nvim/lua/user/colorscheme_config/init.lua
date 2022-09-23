local M = {}

local starry_lists = {
  "darker",
  "darksolar",
  "earlysummer",
  "earlysummer_lighter",
  "emerald",
  "moonlight",
  "dracula",
  "dracula_blood",
  "monokai",
  "monokai_lighter",
  "mariana",
  "mariana_lighter",
  "middlenight_blue",
  "limestone",
  "oceanic",
  "palenight",
}

-- NOTE: load different colorscheme config
local function config_load_check(theme)
  if theme == "nord" then
    require("user.colorscheme_config.nord").setup()
  end

  for i = 1, #starry_lists do
    local starry = starry_lists[i]
    if theme == starry then
      require("user.colorscheme_config.starry").setup()
    end
  end

  if theme == "kanagawa" then
    require('user.colorscheme_config.kanagawa').setup()
  end

  if theme == "catppuccin" then
    require('user.colorscheme_config.catppuccin').setup()
  end
end

function M.setup(theme)
  config_load_check(theme)
end

return M
