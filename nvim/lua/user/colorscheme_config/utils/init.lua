local colors = {
  c1 = "#3b4252",
  c2 = "#282a36",
  c3 = "#1e222b",
  c4 = "#eceff4",
  c5 = "#ff79c6",
  c6 = "#50fa7b",
  c7 = "#ff5555",
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
  TelescopeTitle        = {},
  TelescopePromptTitle  = {},
  TelescopePreviewTitle = {},
  TelescopeResultsTitle = {},
}

local border_default = function(args, value)
  local cfg = Telescope_cfg

  local function customize(
    selection,
    promptborder,
    promptnormal,
    promptcounter,
    prompttitle,
    previewtitle,
    previewborder,
    previewnormal,
    resultstitle,
    resultsnormal
  )
    print('shit fix this')
  end

  if args == "default" then
    cfg.TelescopePromptPrefix  = { fg = colors.c4 }
    cfg.TelescopeSelection     = { bg = colors.c2 }
    cfg.TelescopePromptCounter = { fg = colors.c4 }

    -- normal
    cfg.TelescopeNormal        = { fg = "NONE", bg = "NONE" }
    cfg.TelescopeResultsNormal = { bg = colors.c3 }
    cfg.TelescopePromptNormal  = { fg = colors.c4, bg = colors.c2 }
    cfg.TelescopePreviewNormal = { bg = colors.c3 }

    -- border
    cfg.TelescopeBorder        = { fg = "NONE", bg = "NONE" }
    cfg.TelescopePromptBorder  = { fg = colors.c2, bg = colors.c2 }
    cfg.TelescopePreviewBorder = { fg = colors.c2, bg = colors.c2 }
    cfg.TelescopeResultsBorder = { fg = colors.c2, bg = colors.c2 }

    -- title
    cfg.TelescopeTitle         = { fg = "NONE", bg = "NONE" }
    cfg.TelescopePromptTitle   = { fg = colors.c2, bg = colors.c5 }
    cfg.TelescopePreviewTitle  = { fg = colors.c2, bg = colors.c6 }
    cfg.TelescopeResultsTitle  = { fg = colors.c3, bg = colors.c7 }
  elseif args == "customize" then
    cfg.TelescopeSelection      = { bg = value }
  end

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
  }

  load_colors(cfg)
end

local nontext = function()
  local cfg = {
    CursorLine = {
      fg = "none",
      bg = "none",
    },
    NonText = {
      fg = "#F5EDDC",
      bold = true,
    },
    IndentBlanklineChar = {
      fg = "#F5EDDC",
      bold = true,
    },
  }

  load_colors(cfg)
end

return {
  colors = colors,
  border_default = border_default,
  illuminate = illuminate,
  nontext = nontext,
  load_colors = load_colors,
}
