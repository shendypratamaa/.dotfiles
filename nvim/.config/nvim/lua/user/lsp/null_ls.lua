---@diagnostic disable: missing-parameter
local M = {}

local nls_ok, nls = pcall(require, "null-ls")

if not nls_ok then
    vim.notify(" 🤖 formatter not working", "error", {
        title   = "formatter log",
        timeout = 2000,
    })
    return
end

local formatting   = nls.builtins.formatting
local diagnostics  = nls.builtins.diagnostics
local code_actions = nls.builtins.code_actions

local prettierpth = "~/.config/prettier/.prettierrc.json"
local styluapth   = "~/.config/stylua/stylua.toml"

local sources = {
    -- swift
    formatting.swiftformat,

    -- js / ts
    formatting.prettier.with({
        extra_args = {
            "--config",
            vim.fn.expand(prettierpth),
        },
    }),
    diagnostics.eslint_d,
    code_actions.eslint_d,

    -- lua
    formatting.stylua.with({
        extra_args = {
            "--config-path",
            vim.fn.expand(styluapth),
        },
    }),

    -- py
    formatting.black.with({
        args = {
            "--stdin-filename",
            "$FILENAME",
            "--quiet",
            "-",
        },
        extra_args = {
            "--fast",
        },
    }),
    formatting.isort.with({
        args = {
            "--stdout",
            "--filename",
            "$FILENAME",
            "-",
        },
    }),
    diagnostics.flake8,

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
