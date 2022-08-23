local M = {}

local nls = require 'null-ls'
local nls_utils = require 'null-ls.utils'

local formatting = nls.builtins.formatting
local diagnostics = nls.builtins.diagnostics
local code_actions = nls.builtins.code_actions

local dotpath = '~/.dotfiles/nvim/'

local sources = {
  -- formatting
  formatting.stylua.with {
    extra_args = {
      '--config-path',
      vim.fn.expand(dotpath .. 'stylua.toml'),
    },
  },
  formatting.prettierd.with {
    env = {
      PRETTIERD_DEFAULT_CONFIG = vim.fn.expand '~/.prettierrc',
    },
  },
  formatting.markdownlint,
  formatting.black.with { extra_args = { { '--fast' } } },
  formatting.isort,

  -- diagnostics
  diagnostics.flake8.with { extra_args = { '--max-line-length=80' } },
  diagnostics.write_good.with { filetypes = { 'markdown', 'text' } },
  diagnostics.eslint_d.with {
    extra_args = {
      '--config',
      vim.fn.expand '~/.eslintrc',
    },
  },
  -- diagnostics.selene.with {
  --   extra_args = {
  --     '--config',
  --     vim.fn.expand(dotpath .. 'selene.toml'),
  --   },
  -- },
  diagnostics.markdownlint,

  -- code-actions
  code_actions.eslint_d,
  code_actions.gitsigns,
}

function M.setup(opts)
  nls.setup {
    -- debug = true,
    debounce = 150,
    diagnostics_format = '[#{c}] #{m}',
    sources = sources,
    on_attach = opts.on_attach,
    root_dir = nls_utils.root_pattern '.git',
  }
end

return M
