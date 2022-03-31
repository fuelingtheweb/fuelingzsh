local obj = {}
obj.__index = obj

function hasValue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function getSelectedText(copying)
    original = hs.pasteboard.getContents()
    hs.pasteboard.clearContents()

    if is.vscode() then
        ks.slow().shiftAltCmd('c')
    else
        ks.slow().copy()
    end

    text = hs.pasteboard.getContents()
    finderFileSelected = false
    for k, v in pairs(hs.pasteboard.contentTypes()) do
        if v == 'public.file-url' then finderFileSelected = true end
    end

    if not copying then
        hs.pasteboard.setContents(original)

        if finderFileSelected then text = nil end
    end

    return text
end

function startsWith(needle, haystack)
    return haystack:sub(1, #needle) == needle
end

function titleContains(needle)
    return stringContains(needle:gsub('-', '%%-'), currentTitle())
end

function stringContains(needle, haystack)
    return string.find(haystack, needle)
end

function showChooser(callback, choices)
    hs.chooser
        .new(function(item)
            callback(item['subText'])
        end)
        :choices(choices)
        :show()
end

function maximizeAfterDelay()
    hs.timer.doAfter(0.5, function()
        md.WindowManager.moveTo('maximize')
    end)
end

function currentTitle()
    app = hs.application.frontmostApplication()

    title = ''
    for k, v in pairs(app:visibleWindows()) do
        if title == '' then
            title = v:title()
        end
    end

    return title
end

function windowCount(app)
    if app == nil then return 0 end

    count = 0
    for k, v in pairs(app:visibleWindows()) do
        if (is.In(preview) or is.finder()) and v:title() == '' then
        else
            count = count + 1
        end
    end

    return count
end

function countTable(table)
    if not table then return 0 end

    local count = 0
    each(table, function()
        count = count + 1
    end)

    return count
end

function hasWindows(app)
    return windowCount(app) > 0
end

function multipleWindows(app)
    return windowCount(app) > 1
end

function toggleAppStatic()
    output = hs.execute('/Users/nathan/Development/FuelingTheWeb/bin/toggle-app-static.sh')
    hs.notify.new({title = 'Env Variable Updated', informativeText = output}):send()
end

function each(table, callback)
    for key, value in pairs(table) do
        callback(value, key)
    end
end

function executeFromFuelingZsh(command)
    return hs.execute('~/.fuelingzsh/bin/' .. command)
end

function trim(s)
    return (s:gsub('^%s*(.-)%s*$', '%1'))
end

function handleApp(callback, lookup)
    local bundle = hs.application.frontmostApplication():bundleID()

    if is.Table(callback) then
        lookup = callback
        callback = nil
    end

    if lookup[bundle] then
        if callback then
            callback(table.unpack(lookup[bundle]))
        else
            lookup[bundle]()
        end
    end
end

function handleConditional(conditional, callback, lookup)
    if is.Table(callback) then
        lookup = callback
        callback = nil
    end

    for key, value in pairs(lookup) do
        if conditional(value.condition) or value.condition == 'fallback' then
            if callback then
                if is.Table(value.value) then
                    callback(table.unpack(value.value))
                else
                    callback(value.value)
                end
            else
                value()
            end

            return
        end
    end
end

function _(callback, ...)
    local params = table.pack(...)

    return function()
        callback(table.unpack(params))
    end
end

return obj
