local telescope_border = function()
  local cfg = {
    TelescopeSelection = {
      bg = "#3b4252",
    },
    TelescopePromptBorder = {
      fg = "#3b4252",
      bg = "#3b4252",
    },
    TelescopePromptNormal = {
      fg = "#eceff4",
      bg = "#3b4252",
    },
    TelescopePromptCounter = {
      fg = "#eceff4",
    },
    TelescopePromptTitle = {
      fg = "#282a36",
      bg = "#ff79c6",
    },
    TelescopePreviewTitle = {
      fg = "#282a36",
      bg = "#50fa7b",
    },
    TelescopeResultsTitle = {
      fg = "#1e222b",
      bg = "#ff5555",
    },
    TelescopePreviewBorder = {
      fg = "#1e222b",
      bg = "#1e222b",
    },
    TelescopeResultsBorder = {
      fg = "#1e222b",
      bg = "#1e222b",
    },
    TelescopePreviewNormal = {
      bg = "#1e222b",
    },
    TelescopeResultsNormal = {
      bg = "#1e222b",
    },
  }
  return cfg
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

  return cfg
end

local nontext = function()
  local cfg = {
    CursorLine = {
      fg = 'none',
      bg = 'none'
    },
    NonText = {
      fg = "#FFE6F7",
      bold = true,
    },
    IndentBlanklineChar = {
      fg = "#FFE6F7",
      bold = true,
    },
  }

  return cfg
end

local function load_colors(opts)
  for hl, col in pairs(opts) do
    vim.api.nvim_set_hl(0, hl, col)
  end
end

return {
  telescope_border = telescope_border,
  load_colors = load_colors,
  illuminate = illuminate,
  nontext = nontext
}
