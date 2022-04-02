local Make = {}
Make.__index = Make

Make.lookup = {
    tab = nil,
    q = nil,
    w = cm.Search.window,
    e = cm.Search.viaAlfred,
    r = 'lineBefore',
    t = 'tag',
    caps_lock = Brackets.startMulti,
    a = cm.Search.amazon,
    s = 'singleQuote',
    d = 'doubleQuote',
    f = 'parenthesis',
    g = cm.Search.google,
    left_shift = nil,
    z = 'backTick',
    x = cm.Search.files,
    c = 'braces',
    v = 'lineAfter',
    b = 'brackets',
    spacebar = 'space',
}

function Make.fallback(bracket)
    Brackets.print(bracket)
end

function Make.lineBefore()
    if is.vimMode() then
        ks.escape().shift('o')
    end
end

function Make.lineAfter()
    if is.vimMode() then
        ks.escape().key('o')
    end
end

return Make
