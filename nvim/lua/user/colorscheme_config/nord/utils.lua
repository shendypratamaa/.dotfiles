local M = {}

local function nord_telescope_border()
  local TelescopePrompt = {
    TelescopeSelection = {
      bg = '#3b4252',
    },
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
      fg = '#1e222b',
      bg = '#1e222b',
    },
    TelescopeResultsBorder = {
      fg = '#1e222b',
      bg = '#1e222b',
    },
    TelescopePreviewNormal = {
      bg = '#1e222b',
    },
    TelescopeResultsNormal = {
      bg = '#1e222b',
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

local function nord_sync(theme)
  local both_opts = {
    NonText = {
      fg = '#d8dee9',
    },
  }

  local nord = {}

  local base16_nord = {}

  local opts = {
    nord = 'nord',
    base16_nord = 'base16-nord',
  }

  local function fillter_color()
    local highlight = vim.api.nvim_set_hl
    for hl, col in pairs(both_opts) do
      highlight(0, hl, col)
    end
    for _, v in pairs(opts) do
      if theme == opts[v] then
        nord_telescope_border()
        for hl, col in pairs(nord) do
          highlight(0, hl, col)
        end
      else
        base16_nord_telescope_border()
        for hl, col in pairs(base16_nord) do
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
