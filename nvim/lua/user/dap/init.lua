local dap_ok, dap = pcall(require, "dap")
local dapui_ok, dapui = pcall(require, "dapui")
local daptext_ok, daptext = pcall(require, "nvim-dap-virtual-text")

if not dap_ok and dapui_ok and daptext_ok then
  return
end

local function sign_define(...)
  vim.fn.sign_define(...)
end

local dap_breakpoint = {
  error = {
    text = "",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
  },
  rejected = {
    text = "",
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl = "",
  },
  stopped = {
    text = "",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "LspDiagnosticsSignInformation",
  },
}

sign_define("DapBreakpoint", dap_breakpoint.error)
sign_define("DapStopped", dap_breakpoint.stopped)
sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

daptext.setup {
  commented = true,
}

dapui.setup() -- use default

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("user.dap.lua").setup()
require("user.dap.jsts").setup()
require("user.dap.python").setup()
require("user.dap.dapkeymaps").setup()
