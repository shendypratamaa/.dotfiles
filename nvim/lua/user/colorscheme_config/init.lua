local M = {}

-- NOTE: load different colorscheme config
local function config_load_check(theme)
  require('user.colorscheme_config.nord').setup(theme)
end

function M.setup(theme)
  config_load_check(theme)
end

return M
