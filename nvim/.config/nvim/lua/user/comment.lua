local status_ok, comment = pcall(require, "Comment")
local c_uts              = require("Comment.utils")
local uts                = require("ts_context_commentstring.utils")
local utsi               = require("ts_context_commentstring.internal")

if not status_ok then
    return
end

local get_location = uts.get_cursor_location()
local get_visual = uts.get_visual_start_location()

local function get_internal(...)
    local internal = utsi.calculate_commentstring(...)
    return internal
end

local cfg = {
    pre_hook = function(ctx)
        local U = c_uts
        local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"
        local location = nil

        if ctx.ctype == U.ctype.block then
            location = get_location
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = get_visual
        end

        return get_internal({
            key = type,
            location = location,
        })
    end,
}

comment.setup(cfg)
