local Window = {}
Window.__index = Window

local windows = {}

function Window.titleContains(needle)
    return str.contains(needle:gsub('-', '%%-'), Window.title())
end

function Window.pathContains(needle)
    return str.contains(needle:gsub('-', '%%-'), Window.path())
end

function Window.path()
    return Window.title():match('~%S+')
end

function Window.title()
    local app = hs.application.frontmostApplication()
    local title = ''

    for k, v in pairs(app:visibleWindows()) do
        if title == '' then
            title = v:title()
        end
    end

    return title
end

function Window.openWithCache(name, callback)
    local window = windows[name]

    if window and window:isVisible() and str.contains(name, window:title():lower()) then
        return window:focus()
    end

    callback()

    hs.timer.doAfter(0.5, function()
        windows[name] = hs.window.frontmostWindow()
    end)
end

return Window
