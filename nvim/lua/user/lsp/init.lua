local lsp_ok, lsp_config = pcall(require, "lspconfig")
local navic_ok, navic = pcall(require, "nvim-navic")
local cmp_ok, cmp = pcall(require, "cmp_nvim_lsp")
local ts_ok, ts = pcall(require, "typescript")
local lv_ok, lv = pcall(require, "lua-dev")
local scheme_ok, scheme = pcall(require, "schemastore")

if not lsp_ok and navic_ok and cmp_ok and ts_ok and lv_ok and scheme_ok then
  return
end

local disable_diagnostics_lsp = function()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
end

local on_attach = function(client, bufnr)
  require("user.lsp.saga").setup()
  require("user.lsp.highlight").setup()
  require("user.lsp.lspkeymaps").setup(bufnr)

  if client.name == "sumneko_lua" then
    client.resolved_capabilities.document_formatting = false
    navic.attach(client, bufnr)
  end

  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
    navic.attach(client, bufnr)
    disable_diagnostics_lsp()
  end

  if client.name == "pyright" then
    client.resolved_capabilities.document_formatting = false
    navic.attach(client, bufnr)
    disable_diagnostics_lsp()
  end

  if client.name == "jsonls" then
    client.resolved_capabilities.document_formatting = false
    navic.attach(client, bufnr)
  end

  if client.name == "html" then
    client.resolved_capabilities.document_formatting = false
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
}

local formatter = {
  "stylua",
  "prettier",
  "markdownlint",
  "write-good",
  "eslint_d",
  "fixjson",
}

local flags = {
  debounce_text_changes = 150,
}

for server_name, _ in pairs(servers) do
  local lsp_opts = {
    flags = flags,
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lsp_opts = vim.tbl_deep_extend("force", lsp_opts, servers[server_name] or {})
  lsp_config[server_name].setup(lsp_opts)

  if server_name == "sumneko_lua" then
    lsp_config.sumneko_lua.setup(lv.setup {
      library = { plugins = { "neotest" }, types = true },
      lspconfig = lsp_opts,
    })
  end

  if server_name == "tsserver" then
    lsp_opts = ts.setup {
      debug_commands = false,
      debug = false,
      server = lsp_opts,
    }
  end
end

require("user.lsp.handlers").setup()
require("user.lsp.lsp_signature").setup()
require("user.lsp.null_ls").setup(on_attach)
require("user.lsp.mason").setup(servers, formatter)
