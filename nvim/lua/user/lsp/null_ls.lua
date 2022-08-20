local M = {}

local nls = require 'null-ls'
local nls_utils = require 'null-ls.utils'

local formatting = nls.builtins.formatting
local diagnostics = nls.builtins.diagnostics
local code_actions = nls.builtins.code_actions

local sources = {
  -- formatting
  formatting.stylua.with {
    extra_args = {
      '--config-path',
      vim.fn.expand '~/.dotfiles/nvim/linter-config/stylua.toml',
    },
  },
  formatting.prettierd.with {
    env = {
      PRETTIERD_DEFAULT_CONFIG = vim.fn.expand '~/.prettierrc',
    },
  },
  formatting.fixjson,
  formatting.markdownlint,

  -- diagnostics
  diagnostics.write_good.with { filetypes = { 'markdown', 'text' } },
  diagnostics.eslint_d.with {
    extra_args = {
      '--config',
      vim.fn.expand '~/.eslintrc',
    },
  },
  diagnostics.selene,
  diagnostics.markdownlint,

  -- code-actions
  code_actions.eslint_d,
  code_actions.gitsigns,
}

function M.setup(opts)
  nls.setup {
    debug = true,
    debounce = 150,
    diagnostics_format = '[#{c}] #{m} (#{s})',
    sources = sources,
    on_attach = opts.on_attach,
    -- on_attach = function(client)
    --   if client.resolved_capabilities.document_formatting then
    --     vim.cmd 'autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()'
    --   end
    -- end,
  }
end

return M
