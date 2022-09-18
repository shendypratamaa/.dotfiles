local M = {}

local function nord_telescope_border()
  local TelescopePrompt = {
    TelescopeSelection = { bg = '#434c5e' },
    TelescopePromptBorder = {
      fg = '#3b4252',
      bg = '#3b4252',
    },
    TelescopePromptNormal = {
      fg = '#eceff4',
      bg = '#3b4252',
    },
    TelescopePromptCounter = {
      fg = '#eceff4',
    },
    TelescopeMatching = {
      fg = '#81a1c1',
    },
    TelescopePromptTitle = {
      fg = '#eceff4',
      bg = '#b48ead',
    },
    TelescopePreviewTitle = {
      fg = '#eceff4',
      bg = '#a3be8c',
    },
    TelescopeResultsTitle = {
      fg = '#eceff4',
      bg = '#d08770',
    },
    TelescopePreviewBorder = {
      fg = '#2e3440',
    },
    TelescopeResultsBorder = {
      fg = '#2e3440',
    },
  }

  for hl, col in pairs(TelescopePrompt) do
    vim.api.nvim_set_hl(0, hl, col)
  end
end

local function base16_nord_telescope_border()
  local TelescopePrompt = {
    TelescopeResultsTitle = {
      fg = '#eceff4',
      bg = '#d08770',
    },
    TelescopePromptCounter = {
      fg = '#eceff4',
    },
    TelescopeMatching = {
      fg = '#81a1c1',
    },
  }

  for hl, col in pairs(TelescopePrompt) do
    vim.api.nvim_set_hl(0, hl, col)
  end
end

-- PERF: Refactor

local function nord_sync(theme)
  local nord = {
    FocusedWindow = {
      bg = 'none',
    },
    UnfocusedWindow = {
      bg = '#434c5e',
    },
    TSplaygroundFocus = {
      bg = '#eceff4',
      fg = '#262626',
    },
    LineNr = {
      fg = '#4c566a',
    },
    NonText = {
      fg = '#b48ead',
    },
  }

  local base16_nord = {
    UnfocusedWindow = {
      bg = '#434c5e',
    },
    LineNr = {
      fg = '#4c566a',
    },
    TSplaygroundFocus = {
      bg = '#eceff4',
      fg = '#262626',
    },
    NonText = {
      fg = '#b48ead',
    },
  }

  local opts = {
    nord = 'nord',
    base16_nord = 'base16-nord',
  }

  local function fillter_color()
    for _, v in pairs(opts) do
      if theme == opts[v] then
        nord_telescope_border()
        for hl, col in pairs(nord) do
          local highlight = vim.api.nvim_set_hl
          highlight(0, hl, col)
        end
      else
        base16_nord_telescope_border()
        for hl, col in pairs(base16_nord) do
          local highlight = vim.api.nvim_set_hl
          highlight(0, hl, col)
        end
      end
    end
  end

  return { fillter_color() }
end

function M.setup(theme)
  nord_sync(theme)
end

return M
