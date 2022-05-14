local Window = {}
Window.__index = Window

local windows = {}

function Window.openWithCache(name, callback)
    local window = windows[name]

    if window and window:isVisible() and stringContains(name, window:title():lower()) then
        return window:focus()
    end

    callback()

    hs.timer.doAfter(0.5, function()
        windows[name] = hs.window.frontmostWindow()
    end)
end

return Window
