local null_ls_status_ok, null_ls = pcall(require, 'null-ls')

if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local path = vim.fn.expand

local sources = {
  -- formatting
  formatting.stylua.with {
    extra_args = {
      '--config-path',
      path '~/.config/nvim/linter-config/stylua.toml',
    },
  },
  formatting.prettierd.with {
    env = {
      PRETTIERD_DEFAULT_CONFIG = vim.fn.expand '$HOME/.prettierrc',
    },
  },
  formatting.fixjson,
  formatting.markdownlint,

  -- diagnostics
  diagnostics.write_good.with { filetypes = { 'markdown', 'text' } },
  diagnostics.eslint_d.with {
    extra_args = {
      '--config',
      path '~/.eslintrc',
    },
  },
  diagnostics.selene.with {
    extra_args = {
      '--config',
      path '~/.config/nvim/linter-config/selene.toml',
    },
  },
  diagnostics.write_good,

  -- code-actions
  code_actions.eslint_d,
  code_actions.gitsigns,
}

null_ls.setup {
  debug = true,
  diagnostics_format = '[#{c}] #{m} (#{s})',
  sources = sources,
  on_attach = function()
    -- if client.resolved_capabilities.document_formatting then
    --   vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
    -- end
  end,
}
