local notify_ok, notify = pcall(require, 'notify')

if not notify_ok then
  return
end

local notify_config = {
  stages = 'fade_in_slide_out',
  on_open = nil,
  on_close = nil,
  render = 'default',
  timeout = 175,
  minimum_width = 10,
  fps = 60,
  background_color = 'Normal',
  icons = {
    DEBUG = '',
    ERROR = '',
    INFO = '',
    TRACE = '✎',
    WARN = '',
  },
}

notify.setup(notify_config)

vim.notify = notify
