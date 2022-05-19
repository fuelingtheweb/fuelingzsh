local String = {}
String.__index = String

function String.startsWith(needle, haystack)
    return haystack:sub(1, #needle) == needle
end

function String.contains(needle, haystack)
    return string.find(haystack, needle)
end

function String.trim(s)
    return s:gsub('^%s*(.-)%s*$', '%1')
end

function String.trimRight(s)
    return s:gsub('(.-)%s*$', '%1')
end

function String.selected()
    return fn.clipboard.preserve(md.Yank.normal, function(value)
        for k, v in pairs(hs.pasteboard.contentTypes()) do
            if v == 'public.file-url' then
                value = nil
            end
        end

        return value
    end)
end

return String
