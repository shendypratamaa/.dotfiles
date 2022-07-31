local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(
      sign.name,
      { texthl = sign.name, text = sign.text, numhl = "" }
    )
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap

  -- Lspsaga
  keymap(bufnr, "n", "gh", ":Lspsaga lsp_finder<CR>", opts)
  keymap(bufnr, "n", "<leader>ca", ":Lspsaga code_action<CR>", opts)
  keymap(bufnr, "n", "K", ":Lspsaga hover_doc<CR>", opts)
  keymap(bufnr, "n", "gs", ":Lspsaga signature_help<CR>", opts)
  keymap(bufnr, "n", "gr", ":Lspsaga rename<CR>", opts)
  keymap(bufnr, "n", "gD", ":Lspsaga preview_definition<CR>", opts)
  keymap(bufnr, "n", "[d", ":Lspsaga diagnostic_jump_next<CR>", opts)
  keymap(bufnr, "n", "]d", ":Lspsaga diagnostic_jump_prev<CR>", opts)
  keymap(bufnr, "n", "gl", ":Lspsaga show_line_diagnostics<CR>", opts)
  -- keymap(bufnr, "v", "va", ":Lspsaga range_code_action<CR>", opts)

  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end
  if client.name == "sumneko_lua" then
    client.resolved_capabilities.document_formatting = false
  end
  if client.name == "jsonls" then
    client.resolved_capabilities.document_formatting = false
  end
  if client.name == "cssls" then
    client.resolved_capabilities.document_formatting = false
  end
  if client.name == "html" then
    client.resolved_capabilities.document_formatting = false
  end
  if client.name == "emmet_ls" then
    client.resolved_capabilities.document_formatting = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
