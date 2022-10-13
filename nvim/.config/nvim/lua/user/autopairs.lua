local status_ok, npairs = pcall(require, 'nvim-autopairs')
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
local cmp_status_ok, cmp = pcall(require, 'cmp')

if not status_ok and cmp_status_ok then
  return
end

local cfg = {
  check_ts = true,
  ts_config = {
    lua = { 'string', 'source' },
    javascript = { 'string', 'template_string' },
    java = false,
  },
  disable_filetype = { 'TelescopePrompt' },
  fast_wrap = {
    map = '<C-t>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'Search',
    highlight_grey = 'Comment',
  },
}

npairs.setup(cfg)

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
