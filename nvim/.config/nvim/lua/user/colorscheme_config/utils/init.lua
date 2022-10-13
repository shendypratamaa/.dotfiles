local colors = {
  c1 = "#3b4252",
  c2 = "#222831",
  c3 = "#1e222b",
  c4 = "#eceff4",
  c5 = "#b48ead",
  c6 = "#a3be8c",
  c7 = "#bf616a",
}

local function load_colors(opts)
  for hl, col in pairs(opts) do
    vim.api.nvim_set_hl(0, hl, col)
  end
end

local Telescope_cfg = {
  TelescopePromptPrefix  = {},
  TelescopeSelection     = {},
  TelescopePromptCounter = {},

  -- normal
  TelescopeNormal        = {},
  TelescopePreviewNormal = {},
  TelescopePromptNormal  = {},
  TelescopeResultsNormal = {},

  -- border
  TelescopeBorder        = {},
  TelescopePromptBorder  = {},
  TelescopeResultsBorder = {},
  TelescopePreviewBorder = {},

  -- title
  TelescopeTitle         = {},
  TelescopePromptTitle   = {},
  TelescopePreviewTitle  = {},
  TelescopeResultsTitle  = {},
}

local border_default = function()
  local cfg = Telescope_cfg

  cfg.TelescopePromptPrefix  = { fg = colors.c4 }
  cfg.TelescopePromptCounter = { fg = colors.c4 }
  cfg.TelescopeSelection     = { fg = colors.c4, bg = colors.c1 }

  -- normal
  cfg.TelescopeNormal        = { fg = "white", bg = "white" }
  cfg.TelescopePromptNormal  = { fg = colors.c4, bg = colors.c2 }
  cfg.TelescopeResultsNormal = { bg = colors.c2 }
  cfg.TelescopePreviewNormal = { bg = colors.c2 }

  -- border
  cfg.TelescopeBorder        = { fg = "white", bg = "white" }
  cfg.TelescopePromptBorder  = { fg = colors.c2, bg = colors.c2 }
  cfg.TelescopePreviewBorder = { fg = colors.c2, bg = colors.c2 }
  cfg.TelescopeResultsBorder = { fg = colors.c2, bg = colors.c2 }

  -- title
  cfg.TelescopeTitle         = { fg = "white", bg = "white" }
  cfg.TelescopePromptTitle   = { fg = colors.c4, bg = colors.c5 }
  cfg.TelescopePreviewTitle  = { fg = colors.c4, bg = colors.c6 }
  cfg.TelescopeResultsTitle  = { fg = colors.c4, bg = colors.c7 }

  load_colors(cfg)
end

local illuminate = function()
  local cfg = {
    IlluminatedWord = {
      link = "PmenuSel",
    },
    IlluminatedWordText = {
      link = "PmenuSel",
    },
    IlluminatedWordRead = {
      link = "PmenuSel",
    },
    Focusedsymbol = {
      link = "PmenuSel",
    },
    BqfPreviewFloat = {
      link = "TelescopePromptBorder"
    },
    BqfPreviewBorder = {
      link = "Definitions"
    },
    BqfPreviewRange = {
      link = "Definitions"
    },
  }

  load_colors(cfg)
end

local nontext = function()
  local cfg = {
    Normal = {
      fg = "none",
      bg = "none",
    },
    SignColumn = {
      bg = "none",
    },
    CursorLine = {
      fg = "none",
      bg = "none",
    },
    NonText = {
      fg = "#616e88",
      bold = true,
    },
    IndentBlanklineChar = {
      fg = "#616e88",
      bold = true,
    },
  }

  load_colors(cfg)
end

return {
  colors         = colors,
  border_default = border_default,
  illuminate     = illuminate,
  nontext        = nontext,
  load_colors    = load_colors,
}
