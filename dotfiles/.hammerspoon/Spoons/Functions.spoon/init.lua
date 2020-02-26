local obj = {}
obj.__index = obj

function isDisplay(name)
    return hs.screen.primaryScreen():name() == name
end

function isMacbookDisplay()
    return isDisplay(macbookScreen)
end

function appIncludes(bundles)
    return has_value(bundles, hs.application.frontmostApplication():bundleID())
end

function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function appIs(bundle)
    return hs.application.frontmostApplication():bundleID() == bundle
end

function getSelectedText(copying)
    original = hs.pasteboard.getContents()
    hs.pasteboard.clearContents()
    hs.eventtap.keyStroke({'cmd'}, 'C')
    text = hs.pasteboard.getContents()
    finderFileSelected = false
    for k,v in pairs(hs.pasteboard.contentTypes()) do
        if v == 'public.file-url' then
            finderFileSelected = true
        end
    end

    if not copying and finderFileSelected then
        text = 'finderFileSelected'
    end

    if not copying then
        hs.pasteboard.setContents(original)
    end

    return text
end

function startsWith(needle, haystack)
    return haystack:sub(1, #needle) == needle
end

function stringContains(needle, haystack)
    return string.find(haystack, needle)
end

function openDiscordChannel(name)
    hs.eventtap.keyStroke({'cmd'}, 'K')
    hs.eventtap.keyStrokes(name)
    hs.timer.doAfter(0.1, function()
        hs.eventtap.keyStroke({}, 'return')
    end)
end

function openNotionPage(name)
    hs.eventtap.keyStroke({'cmd'}, 'P')
    hs.eventtap.keyStrokes(name)
    hs.timer.doAfter(0.3, function()
        hs.eventtap.keyStroke({}, 'return')
    end)
end

function openInAtom(name)
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'P')
    hs.eventtap.keyStrokes(name)
    hs.timer.doAfter(0.3, function()
        hs.eventtap.keyStroke({}, 'return')
    end)
end

function typeAndEnter(string)
    hs.eventtap.keyStrokes(string)
    hs.eventtap.keyStroke({}, 'return')
end

function triggerAlfredSearch(search)
    hs.osascript.applescript('tell application id "com.runningwithcrayons.Alfred" to search "' .. search ..' "')
end

function triggerAlfredWorkflow(trigger, workflow)
    hs.osascript.applescript('tell application id "com.runningwithcrayons.Alfred" to run trigger "' .. trigger .. '" in workflow "' .. workflow .. '"')
end

function openInAtom(path)
    hs.execute('/usr/local/bin/atom "' .. path .. '"')
end

function currentTitle()
    app = hs.application.frontmostApplication()

    title = ''
    for k,v in pairs(app:visibleWindows()) do
        if title == '' then
            title = v:title()
        end
    end

    return title
end

function windowCount(app)
    if app == nil then
        return 0
    end

    count = 0
    for k,v in pairs(app:visibleWindows()) do
        if (appIs(preview) or appIs(finder)) and v:title() == '' then
        else
            count = count + 1
        end
    end

    return count
end

function hasWindows(app)
    return windowCount(app) > 0
end

function multipleWindows(app)
    return windowCount(app) > 1
end

return obj
