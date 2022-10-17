local dap = require("dap")

local M = {}

local a = 10
local b = 20
local x = a + b

function M.setup()
    dap.configurations.lua = {
        {
            type = "nlua",
            request = "attach",
            name = "Attach to running Neovim instance",
        },
    }

    dap.adapters.nlua = function(callback, config)
        callback({
            type = "server",
            host = config.host or "127.0.0.1",
            port = config.port or 8088,
        })
    end
end

return M
