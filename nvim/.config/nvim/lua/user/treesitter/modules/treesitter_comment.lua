local comment = {
    enable = true,
    enable_autocmd = false,
    config = {
        lua        = "-- %s",
        css        = "// %s",
        json       = "// %s",
        javascript = {
            __default     = "// %s",
            jsx_element   = "{/* %s */}",
            jsx_fragment  = "{/* %s */}",
            jsx_attribute = "// %s",
            comment       = '// %s'
        },
    },
}

return {
    comment = comment,
}
