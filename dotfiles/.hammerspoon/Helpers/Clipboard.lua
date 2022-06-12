local Clipboard = {}
Clipboard.__index = Clipboard

function Clipboard.contains(needle)
    return str.contains(needle, Clipboard.get())
end

function Clipboard.trimmed()
    return str.trim(Clipboard.get())
end

function Clipboard.trimmedRight()
    return str.trimRight(Clipboard.get())
end

function Clipboard.get()
    return hs.pasteboard.getContents()
end

function Clipboard.set(value)
    hs.pasteboard.setContents(value)
end

function Clipboard.clear()
    hs.pasteboard.clearContents()
end

function Clipboard.paste(value)
    if value then
        Clipboard.set(value:sub('$|$', Clipboard.get()))
    end

    ks.paste()
end

function Clipboard.pasteTrimmed(value)
    if value then
        Clipboard.set(value:sub('$|$', Clipboard.trimmed()))
    end

    ks.paste()
end

function Clipboard.pasteTrimmedRight(value)
    if value then
        Clipboard.set(value:gsub('{clipboard}', Clipboard.trimmedRight()))
    end

    ks.paste()
end

function Clipboard.preserve(callback, cleanupCallback)
    local original = Clipboard.get()
    Clipboard.clear()

    callback()

    local value = Clipboard.get()

    if cleanupCallback then
        value = cleanupCallback(value)
    end

    Clipboard.set(original)

    return value
end

return Clipboard
