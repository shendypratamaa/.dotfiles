local dapvs_ok, dapvs = pcall(require, "dap-vscode-js")
local dap             = require("dap")
local daputil         = require("dap.utils").pick_process

if not dapvs_ok then
    return
end

local M = {}

local function config_jsts()
    dapvs.setup({
        adapters = { "pwa-node" },
    })

    for _, language in ipairs({ "typescript", "javascript" }) do
        dap.configurations[language] = {
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
            },
            {
                type = "pwa-node",
                request = "attach",
                name = "Attach",
                processId = daputil,
                cwd = "${workspaceFolder}",
            },
        }
    end
end

function M.setup()
    config_jsts()
end

return M
