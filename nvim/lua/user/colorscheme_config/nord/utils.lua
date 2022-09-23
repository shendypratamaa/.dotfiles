local highlight = vim.api.nvim_set_hl

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

  for hl, col in pairs(TelescopePrompt) do
    highlight(0, hl, col)
  end
end

local function nord_sync()
  local nord_opts = {
    TreesitterContext = {
      fg = "#eceff4",
      bg = "#1e222b",
    },
    TreesitterContextLineNumber = {
      fg = "#eceff4",
      bg = "#1e222b",
    },
    CursorLine = {
      bg = "none",
    },
    NonText = {
      fg = "#413F42",
    },
    IndentBlanklineChar = {
      fg = "#413f42",
    },
  }

  local function filter_sync()
    for hl, col in pairs(nord_opts) do
      highlight(0, hl, col)
    end
    nord_telescope_border()
  end

  return filter_sync()
end

function M.setup()
  nord_sync()
end

return M
