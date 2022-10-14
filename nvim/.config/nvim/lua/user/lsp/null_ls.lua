---@diagnostic disable: missing-parameter
local M = {}

local nls_ok, nls = pcall(require, "null-ls")

if not nls_ok then
  return
end

local formatting   = nls.builtins.formatting
local diagnostics  = nls.builtins.diagnostics
local code_actions = nls.builtins.code_actions

local dotpath = "~/.dotfiles/config/nvim/"

local sources = {
  -- formatting
  formatting.swiftformat,
  formatting.stylua.with {
    extra_args = {
      "--config-path",
      vim.fn.expand(dotpath .. "stylua.toml"),
    },
  },
  formatting.prettier.with {
    extra_args = {
      "--config",
      vim.fn.expand "~/.prettierrc",
    },
  },
  formatting.black.with {
    args = {
      "--stdin-filename",
      "$FILENAME",
      "--quiet",
      "-",
    },
    extra_args = {
      "--fast",
    },
  },
  formatting.isort.with {
    args = {
      "--stdout",
      "--filename",
      "$FILENAME",
      "-",
    },
  },
  formatting.markdownlint,
  formatting.fixjson,

  -- diagnostics
  diagnostics.write_good.with { filetypes = { "markdown", "text" } },
  diagnostics.eslint_d.with {
    extra_args = {
      "--config",
      vim.fn.expand "~/.eslintrc",
    },
  },
  diagnostics.flake8,
  diagnostics.markdownlint,

  -- code-actions
  code_actions.eslint_d,
  code_actions.gitsigns,
}

function M.setup(on_attach)
  nls.setup {
    debug              = true,
    debounce           = 150,
    diagnostics_format = "[#{c}] #{m}",
    sources            = sources,
    on_attach          = on_attach,
  }
end

return M
