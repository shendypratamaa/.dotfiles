local null_ls_status_ok, null_ls = pcall(require, "null-ls")

if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local codeactions = null_ls.builtins.code_actions

local sources = {
  -- formatting
  formatting.stylua.with {
    extra_args = {
      "--config-path",
      vim.fn.expand "~/.config/nvim/linter-config/.stylua.toml",
    },
  },
  formatting.prettier.with {
    extra_args = {
      "--config",
      vim.fn.expand "~/.prettierrc",
    },
  },

  -- diagnostics
  diagnostics.eslint.with {
    "--config",
    vim.fn.expand "~/.eslintrc",
  },

  -- code-actions
  codeactions.gitsigns,
}

null_ls.setup {
  debug = true,
  diagnostics_format = "[#{c}] #{m} (#{s})",
  sources = sources,
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
    end
  end,
}
