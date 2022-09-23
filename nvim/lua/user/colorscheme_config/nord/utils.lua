local M = {}

local function nord_telescope_border()
  local TelescopePrompt = {
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
      fg = "#eceff4",
      bg = "#b48ead",
    },
    TelescopePreviewTitle = {
      fg = "#eceff4",
      bg = "#a3be8c",
    },
    TelescopeResultsTitle = {
      fg = "#eceff4",
      bg = "#d08770",
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

  for hl, col in pairs(TelescopePrompt) do
    vim.api.nvim_set_hl(0, hl, col)
  end
end

local function nord_sync(theme)
  local both_opts = {
    TreesitterContext = {
      fg = "#eceff4",
      bg = "#1e222b",
    },
    TreesitterContextLineNumber = {
      fg = "#eceff4",
      bg = "#1e222b",
    },
  }

  local nord_opts = {}

  local base16_nord_opts = {}

  local function filter_sync()
    local highlight = vim.api.nvim_set_hl

    for hl, col in pairs(both_opts) do
      highlight(0, hl, col)
    end

    if theme == "nord" then
      nord_telescope_border()
      for hl, col in pairs(nord_opts) do
        highlight(0, hl, col)
        return
      end
    elseif theme == "base16-nord" then
      nord_telescope_border()
      for hl, col in pairs(base16_nord_opts) do
        highlight(0, hl, col)
        return
      end
    end
  end

  return filter_sync()
end

function M.setup(theme)
  nord_sync(theme)
end

return M
