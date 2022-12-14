local lsp_ok, lsp_config = pcall(require, "lspconfig")
local navic_ok, navic    = pcall(require, "nvim-navic")
local cmp_ok, cmp        = pcall(require, "cmp_nvim_lsp")
local lv_ok, lv          = pcall(require, "lua-dev")
local scheme_ok, scheme  = pcall(require, "schemastore")
local root_pattern       = lsp_config.util.root_pattern

if not lsp_ok and navic_ok and cmp_ok and lv_ok and scheme_ok then
    return
end

local on_attach = function(client, bufnr)
    require("user.lsp.saga").setup()
    require("user.lsp.highlight").setup()
    require("user.lsp.lspkeymaps").setup(bufnr)
    require("user.lsp.typescript-utils").setup(client)

    if client.name == "tsserver" then
        client.resolved_capabilities.document_formatting = false
        navic.attach(client, bufnr)
    end

    if client.name == "gopls" then
        client.resolved_capabilities.document_formatting = false
        navic.attach(client, bufnr)
    end

    if client.name == "bashls" then
        client.resolved_capabilities.document_formatting = false
        navic.attach(client, bufnr)
    end

    if client.name == "sumneko_lua" then
        client.resolved_capabilities.document_formatting = false
        navic.attach(client, bufnr)
    end

    if client.name == "pyright" then
        client.resolved_capabilities.document_formatting = false
        navic.attach(client, bufnr)
    end

    if client.name == "jsonls" then
        client.resolved_capabilities.document_formatting = false
        navic.attach(client, bufnr)
    end

    if client.name == "html" then
        client.resolved_capabilities.document_formatting = false
        navic.attach(client, bufnr)
    end
end

local update_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp.update_capabilities(update_capabilities)

local servers = {
    jsonls = {
        settings = {
            json = {
                schemas = scheme.json.schemas(),
            },
        },
    },
    sumneko_lua = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
            },
        },
    },
    tsserver = { disable_formatting = true },
    pyright = {
        analysis = {
            typeCheckingMode = "off",
        },
    },
    html = {},
    prosemd_lsp = {},
    cssls = {},
    tailwindcss = {},
    emmet_ls = {},
    yamlls = {},
    bashls = {},
    gopls = {}
}

local formatter = {
    "stylua",
    "prettier",
    "markdownlint",
    "write-good",
    "eslint_d",
    "fixjson",
    "shfmt",
    "shellcheck",
    "golangci-lint",
    "gofumpt",
    "goimports",
    "goimports-reviser",
    "golines"
}

local lsp_flags = {
    debounce_text_changes = 150,
}

for server_name, _ in pairs(servers) do
    local lsp_opts = {
        flags = lsp_flags,
        on_attach = on_attach,
        capabilities = capabilities,
    }

    lsp_opts =
        vim.tbl_deep_extend("force", lsp_opts, servers[server_name] or {})
    lsp_config[server_name].setup(lsp_opts)

    if server_name == "sumneko_lua" then
        lsp_config.sumneko_lua.setup(lv.setup({
            library = { plugins = { "neotest" }, types = true },
            lspconfig = lsp_opts,
        }))
    end
end

lsp_config.sourcekit.setup({
    cmd          = { "sourcekit-lsp" },
    filetypes    = { "swift" },
    root_dir     = root_pattern(".git", "*.swift"),
    on_attach    = on_attach,
    capabilities = capabilities,
    flags        = lsp_flags,
})

require("user.lsp.handlers").setup()
require("user.lsp.lsp_signature").setup()
require("user.lsp.null_ls").setup(on_attach)
require("user.lsp.mason").setup(servers, formatter)
