local M = {}

local nls_ok, nls = pcall(require, "null-ls")

if not nls_ok then
    vim.notify(" 🤖 formatter not working", "error", {
        title   = "formatter log",
        timeout = 2000,
    })
    return
end

local fn           = vim.fn
local formatting   = nls.builtins.formatting
local diagnostics  = nls.builtins.diagnostics
local code_actions = nls.builtins.code_actions

local prettierpth  = "~/.config/prettier/.prettierrc.json"
local styluapth    = "~/.config/stylua/stylua.toml"
local flake8       = "~/.config/flake8/.flake8"

local sources = {
    -- swift
    formatting.swiftformat,

    -- javascript / typescript
    formatting.prettier.with({
        extra_args = {
            "--config",
            fn.expand(prettierpth),
        },
    }),
    diagnostics.eslint_d,
    code_actions.eslint_d,

    -- lua
    formatting.stylua.with({
        extra_args = {
            "--config-path",
            fn.expand(styluapth),
        },
    }),

    -- python
    formatting.isort,
    formatting.black.with({
        extra_args = { "--fast" }
    }),
    diagnostics.flake8.with({
        extra_args = {
            "--config",
            fn.expand(flake8)
        }
    }),

    -- markdown
    formatting.markdownlint,
    diagnostics.markdownlint,

    -- json
    formatting.fixjson,

    -- code-actions
    code_actions.gitsigns,
}

function M.setup(on_attach)
    nls.setup({
        debug = true,
        debounce = 150,
        diagnostics_format = "[#{c}] #{m}",
        sources = sources,
        on_attach = on_attach,
    })
end

return M
