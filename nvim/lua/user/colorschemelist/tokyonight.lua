require('tokyonight').setup {
  style = 'night', -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value `:help attr-list`
    comments = 'italic',
    keywords = 'italic',
    functions = 'NONE',
    variables = 'NONE',
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = 'dark', -- style for sidebars, see below
    floats = 'dark', -- style for floating windows
  },
  sidebars = { 'qf', 'help' }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- fucntion will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- fucntion will be called with a Highlights and ColorScheme table
  on_highlights = function(hl, c)
    local prompt = '#2d3149'
    hl.TelescopeNormal = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopeBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopePromptNormal = {
      bg = prompt,
    }
    hl.TelescopePromptBorder = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopeSelection = {
      bg = c.bg_dark,
    }
    hl.TelescopePreviewTitle = {
      fg = '#f3f3f3',
      bg = '#D27E99',
    }
    hl.TelescopePromptTitle = {
      fg = '#f3f3f3',
      bg = '#957FB8',
    }
    hl.TelescopeResultsTitle = {
      bg = '#f3f3f3',
      fg = '#ffa066',
    }
    hl.TelescopePreviewMatch = {
      fg = '#a39f83',
      bg = '#d27e99',
    }
    hl.TelescopeMatching = {
      bg = '#d27222',
    }
  end,
}
