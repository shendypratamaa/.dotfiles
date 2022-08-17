local null_ls_status_ok, null_ls = pcall(require, "null-ls")

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
      "--config-path",
      path "~/.config/nvim/linter-config/.stylua.toml",
    },
  },
  formatting.prettier.with {
    extra_args = {
      "--config",
      path "~/.prettierrc",
    },
  },

  -- diagnostics
  diagnostics.eslint.with {
    "--config",
    path "~/.eslintrc",
  },
  diagnostics.write_good.with { filetypes = { "markdown", "text" } },

  -- code-actions
  code_actions.eslint,
  code_actions.gitsigns,
}

null_ls.setup {
  debug = true,
  diagnostics_format = "[#{c}] #{m} (#{s})",
  sources = sources,
  on_attach = function()
    -- if client.resolved_capabilities.document_formatting then
    --   vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
    -- end
  end,
}
