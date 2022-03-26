local SelectInside = {}
SelectInside.__index = SelectInside

SelectInside.lookup = {
    tab = nil,
    q = 'subword',
    w = 'word',
    e = nil,
    r = nil,
    t = 'withWrapperKey',
    caps_lock = nil,
    a = 'all',
    s = 'withWrapperKey',
    d = 'withWrapperKey',
    f = 'withWrapperKey',
    g = nil,
    left_shift = nil,
    z = 'withWrapperKey',
    x = 'character',
    c = 'withWrapperKey',
    v = 'line',
    b = 'withWrapperKey',
    spacebar = nil
}

function SelectInside.withWrapperKey(key)
    keystroke = TextManipulation.wrapperKeyLookup[key]

    ks.escape()
    ks.key('v')
    ks.key('i')
    ks.fire(keystroke.mods, keystroke.key)
end

function SelectInside.subword()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('v')
        ks.key('i')

        if appIs(vscode) then
            ks.key('\\')
            ks.key('w')
        else
            ks.key('q')
        end
    end
end

function SelectInside.word()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('v')
        ks.key('i')
        ks.key('w')
    else
        ks.shiftAlt('left')
    end
end

function SelectInside.line()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.shift('v')
    else
        ks.cmd('left')
        ks.shiftCmd('right')
    end
end

function SelectInside.character()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('v')
    else
        ks.shift('left')
    end
end

function SelectInside.all() ks.cmd('a') end

return SelectInside
