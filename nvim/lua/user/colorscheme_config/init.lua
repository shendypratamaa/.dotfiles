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
  "ukraine",
}

-- NOTE: load different colorscheme config
local function config_load_check(theme)
  local nord_check = function()
    if theme == "nord" or theme == "base16-nord" then
      require("user.colorscheme_config.nord").setup(theme)
      return
    end
  end

  local starry_check = function()
    for i = 1, #starry_lists do
      local starry = starry_lists[i]
      if theme == starry then
        require("user.colorscheme_config.starry").setup()
        return
      end
    end
  end

  local loaded = {
    nord = nord_check(),
    starry = starry_check(),
  }

  return loaded
end

function M.setup(theme)
  config_load_check(theme)
end

return M
