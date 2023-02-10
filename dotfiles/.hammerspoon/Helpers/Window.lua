local Window = {}
Window.__index = Window

local windows = {}

function Window.titleContains(needle)
    -- if is.In(sigma) then
    --     url = fn.clipboard.preserve(function()
    --             ks.cmd('l')
    --         end)

    --     -- hs.timer.doAfter(1, function()
    --     return str.contains(needle:gsub('-', '%%-'), url)
    --     -- end)
    -- end

    return str.contains(needle:gsub('-', '%%-'), Window.title())
end

function Window.pathContains(needle)
    return str.contains(needle:gsub('-', '%%-'), Window.path())
end

function Window.path()
    return Window.title():match('~%S+')
end

function Window.title()
    return Window.focused():title()
end

function Window.focused()
    return hs.window.frontmostWindow()
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
