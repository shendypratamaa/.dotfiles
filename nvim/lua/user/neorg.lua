local neorg = require 'neorg'

neorg.setup {
  load = {
    ['core.defaults'] = {},
    ['core.norg.concealer'] = {},
    ['core.integrations.nvim-cmp'] = {},
    ['core.integrations.treesitter'] = {},
    ['core.keybinds'] = {
      config = {
        default_keybinds = true,
      },
    },
    ['core.export'] = {},
    ['core.export.markdown'] = {
      config = {
        extensions = 'all',
      },
    },
    ['core.norg.completion'] = {
      config = {
        engine = 'nvim-cmp',
      },
    },
    ['core.norg.dirman'] = {
      config = {
        workspaces = {
          work = '~/.notes/',
        },
      },
    },
    ['core.presenter'] = {
      config = {
        zen_mode = 'truezen',
      },
    },
  },
}

--- Loads the Neorg completion module
local function load_completion()
  neorg.modules.load_module('core.norg.completion', nil, {
    engine = 'nvim-cmp', -- Choose your completion engine here
  })
end

-- If Neorg is loaded already then don't hesitate and load the completion
if neorg.is_loaded() then
  load_completion()
end
