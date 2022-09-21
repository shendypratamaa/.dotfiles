
-- BUG: Features
-- added features toggling, increase decrease padding

local function foldsigns()
  local a = {
    foldopen = '',
    foldclose = '',
    foldsep = '',
  }

  local b = {
    foldcolumn = 'auto',
    foldmethod = 'manual',
  }

  local c = {
    key = 'nofoldenable',
  }

  local function fd(x)
    for k, v in pairs(x) do
      if x == a then
        local r = 'set ' .. 'fillchars+=' .. k .. ':' .. v .. ','
        vim.cmd(r)
      elseif x == b then
        local r = 'set ' .. k .. '=' .. v
        vim.cmd(r)
      elseif x == c then
        local r = 'set ' .. v
        vim.cmd(r)
      end
    end
  end

  return {
    fd(a),
    fd(b),
    fd(c),
  }
end

local pretty_opts = {
  keep_indentation = false,
  fill_char = '━',
  sections = {
    left = {
      '━ ',
      function()
        return string.rep('*', vim.v.foldlevel)
      end,
      ' ━┫',
      'content',
      '┣',
    },
    right = {
      '┫ ',
      'number_of_folded_lines',
      ': ',
      'percentage',
      ' ┣━━',
    },
  },
  matchup_pattern = {
    { '^%s*do$', 'end' },
    { '^%s*if', 'end' },
    { '^%s*for', 'end' },
    { 'function%s*%(', 'end' },
    { '{', '}' },
    { '%(', ')' },
    { '%[', ']' },
  },
}

return {
  foldsigns(),
  require('pretty-fold').setup(pretty_opts)
}
