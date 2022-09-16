local M = {}

local function config_load_check(args)
  local function nord_check()
    if args == 'nord' then
      print('run', args)
      require('user.colorscheme_config.nord').setup()
    elseif args == 'base16-nord' then
      print('run', args)
      require('user.colorscheme_config.nord.utils').setup()
    end
  end

  return {
    nord_check(),
  }
end

function M.setup(args)
  config_load_check(args)
end

return M
