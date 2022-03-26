local Paste = {}
Paste.__index = Paste

Paste.lookup = {
    tab = 'pasteNext',
    q = 'subword',
    w = 'word',
    e = 'toEndOfWord',
    r = nil,
    t = 'withWrapperKey',
    caps_lock = 'pasteSurround',
    a = 'toEndOfLine',
    s = 'withWrapperKey',
    d = 'withWrapperKey',
    f = 'withWrapperKey',
    g = 'toBeginningOfLine',
    left_shift = {'primaryVim', 'secondaryVim'},
    z = 'withWrapperKey',
    x = 'character',
    c = 'withWrapperKey',
    v = 'line',
    b = 'withWrapperKey',
    spacebar = ks.paste
}

function Paste.before() spoon.KarabinerHandler.currentKey = nil end

function Paste.withWrapperKey(key)
    if not TextManipulation.canManipulateWithVim() then return end

    Paste.pastePending(function()
        keystroke = TextManipulation.wrapperKeyLookup[key]

        ks.sequence({'v', 'i'}).fire(keystroke.mods, keystroke.key)
    end)
end

function Paste.toEndOfWord()
    Paste.pastePending(function() ks.sequence({'v', 'e'}) end,
                       function() ks.shiftAlt('right') end)
end

function Paste.subword()
    Paste.pastePending(function() md.SelectInside.subword() end,
                       function() ks.shiftAlt('left') end)
end

function Paste.word()
    Paste.pastePending(function() ks.sequence({'v', 'i', 'w'}) end,
                       function() ks.shiftAlt('left') end)
end

function Paste.toEndOfLine()
    Paste.pastePending(function() ks.key('v').shiftCmd('right') end,
                       function() ks.shiftCmd('right') end)
end

function Paste.toBeginningOfLine()
    Paste.pastePending(function() ks.shiftCmd('left') end,
                       function() ks.shiftCmd('left') end)
end

function Paste.line()
    Paste.pastePending(function() ks.shift('v') end,
                       function() ks.cmd('left').shiftCmd('right') end)
end

function Paste.character()
    Paste.pastePending(function() ks.key('v') end,
                       function() ks.shift('left') end)
end

function Paste.pastePending(selectTextWhenInVim, selectTextWhenInDefault)
    Paste.selectText(selectTextWhenInVim, selectTextWhenInDefault)
    Paste.pasteFirst()
end

function Paste.selectText(selectTextWhenInVim, selectTextWhenInDefault)
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        selectTextWhenInVim()
    else
        selectTextWhenInDefault()
    end
end

function Paste.pasteFirst()
    if TextManipulation.canManipulateWithVim() then
        Paste.primaryVim()
    else
        Paste.default()
    end
end

function Paste.pasteNext()
    triggerAlfredWorkflow('paste:next', 'com.fuelingtheweb.commands')
end

function Paste.primaryVim() ks.key('p') end

function Paste.secondaryVim() ks.shift('p') end

function Paste.backward() if inCodeEditor() then ks.shift('p') end end

-- Modal.add({
--     key: 'PasteSurround',
--     title: 'Paste Surround',
--     items: Paste.lookup,
--     callback = function(key)
--         Modal.exit()

--         keystroke = TextManipulation.wrapperKeyLookup[key]

--         ks.escape()
--         ks.key('c')
--         ks.key('a')
--         ks.fire(keystroke.mods, keystroke.key)

--         if not hasValue({'s', 'd', 't'}, key) then
--             BracketMatching.start()
--         end
--     end,
-- })

-- function Paste.pasteSurround()
--     if inCodeEditor() then
--         ks.shift('p')
--     end
-- end

return Paste
