local SelectUntilMode = {}
SelectUntilMode.__index = SelectUntilMode

SelectUntilMode.lookup = {
    e = 'endOfWord',
    w = 'next-word',
    s = 'single-quote',
    d = 'double-quote',
    z = 'back-tick',
    caps_lock = 'mode',
    left_shift = 'mode-backward',
    f = 'parenthesis',
    c = 'braces',
    b = 'brackets',
    a = 'endOfLine',
    i = 'beginningOfLine',
    t = 'previousBlock',
}

function SelectUntilMode.handle(key)
    if SelectUntilMode.lookup[key] then
        hs.execute("open -g 'hammerspoon://select-until-" .. SelectUntilMode.lookup[key] .. "'")
    end
end

return SelectUntilMode
