local ts_utils_ok, ts_utils = pcall(require, "nvim-lsp-ts-utils")

if not ts_utils_ok then
    return
end

local M = {}

local cfg = {
    debug = false,
    disable_command = false,
    enable_import_on_completion = false,

    import_all_timeout = 5000,
    import_all_priorities = {
        same_file = 1,
        local_files = 2,
        buffer_cintent = 3,
        buffers = 4,
    },
    import_all_scan_bufferes = 100,
    import_all_select_source = false,
    always_organize_imports = true,

    filter_out_diagnostics_by_severity = {},
    filter_out_diagnostics_by_code = {},

    auto_inlay_hints = false,
    inlay_hints_highlight = "Comment",
    inlay_hints_priority = 200, -- priority of the hint extmarks
    inlay_hints_throttle = 150, -- throttle the inlay hint request
    inlay_hints_format = { -- format options for individual hint kind
        Type = {},
        Parameter = {},
        Enum = {},
    },

    update_imports_on_move = false,
    require_confirmation_on_move = false,
    watch_dir = nil,
}

local keymap = vim.keymap.set
local opts = { silent = true }

keymap("n", "gs", ":TSLspOrganize<CR>", opts)
keymap("n", "gr", ":TSLspRenameFile<CR>", opts)
keymap("n", "gi", ":TSLspImportAll<CR>", opts)

function M.setup(client)
    ts_utils.setup(cfg)
    ts_utils.setup_client(client)
end

return M
