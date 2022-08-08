local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "🤬" },
    { name = "DiagnosticSignWarn", text = "⚠️" },
    { name = "DiagnosticSignHint", text = "ℹ️" },
    { name = "DiagnosticSignInfo", text = "🙋" },
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

local capabilities = vim.lsp.protocol.make_client_capabilities()

local serverList = {
  "tsserver",
}

local function disableDiagnosticstext(client)
  for _, v in pairs(serverList) do
    if v == client then
      vim.lsp.handlers["textDocument/publishDiagnostics"] = function()
        return false
      end
    end
  end
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

  keymap(bufnr, "n", "gS", ":TSLspOrganize<CR>", opts)
  keymap(bufnr, "n", "gR", ":TSLspRenameFile<CR>", opts)
  keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)

  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    local ts_utils = require "nvim-lsp-ts-utils"
    ts_utils.setup {
      debug = false,
      disable_commands = false,
      enable_import_on_completion = false,

      -- import all
      import_all_timeout = 5000, -- ms
      -- lower numbers = higher priority
      import_all_priorities = {
        same_file = 1, -- add to existing import statement
        local_files = 2, -- git files or files with relative path markers
        buffer_content = 3, -- loaded buffer content
        buffers = 4, -- loaded buffer names
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,
      -- if false will avoid organizing imports
      always_organize_imports = true,

      -- filter diagnostics
      filter_out_diagnostics_by_severity = {},
      filter_out_diagnostics_by_code = {},

      -- inlay hints
      auto_inlay_hints = true,
      inlay_hints_highlight = "Comment",
      inlay_hints_priority = 200, -- priority of the hint extmarks
      inlay_hints_throttle = 150, -- throttle the inlay hint request
      inlay_hints_format = { -- format options for individual hint kind
        Type = {},
        Parameter = {},
        Enum = {},
      },

      -- update imports on file move
      update_imports_on_move = false,
      require_confirmation_on_move = false,
      watch_dir = nil,
    }
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
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
  disableDiagnosticstext(client.name)
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
