local M = {}

-- BUG: Features
-- added features toggling, increase decrease padding

local function foldsigns()
  local opts_a = {
    foldopen = '',
    foldclose = '',
    foldsep = '',
  }

  local opts_b = {
    foldcolumn = 'auto',
    foldmethod = 'manual',
  }

  local opts_c = {
    key = 'nofoldenable',
  }

  local function fd(a)
    for k, v in pairs(a) do
      if a == opts_a then
        local result = 'set ' .. 'fillchars+=' .. k .. ':' .. v .. ','
        vim.cmd(result)
      elseif a == opts_b then
        local result = 'set ' .. k .. '=' .. v
        vim.cmd(result)
      elseif a == opts_c then
        local result = 'set ' .. v
        vim.cmd(result)
      end
    end
  end

  return {
    fd(opts_a),
    fd(opts_b),
    fd(opts_c),
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

function M.setup()
  foldsigns()
  require('pretty-fold').setup(pretty_opts)
end

return M
