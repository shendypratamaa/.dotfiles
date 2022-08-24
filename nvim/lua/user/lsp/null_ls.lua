local nls = require 'null-ls'

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
  formatting.black.with { extra_args = { { '--fast' } } },
  formatting.markdownlint,
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
  diagnostics.luacheck,
  diagnostics.markdownlint,

  -- code-actions
  code_actions.eslint_d,
  code_actions.gitsigns,
}

nls.setup {
  debug = true,
  debounce = 150,
  diagnostics_format = '[#{c}] #{m}',
  sources = sources,
}
