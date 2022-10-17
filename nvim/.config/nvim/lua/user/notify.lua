local notify_ok, notify = pcall(require, "notify")

if not notify_ok then
    return
end

local cfg = {
    stages = "fade_in_slide_out",
    on_open = nil,
    on_close = nil,
    render = "default",
    timeout = 200,
    minimum_width = 40,
    background_colour = "#000000",
    fps = 256,
    icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
    },
}

notify.setup(cfg)

vim.notify = notify
