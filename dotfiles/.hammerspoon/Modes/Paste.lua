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
    spacebar = 'default',
}

function Paste.withWrapperKey(key)
    if not TextManipulation.canManipulateWithVim() then
        return
    end

    Paste.pastePending(
        function()
            keystroke = TextManipulation.wrapperKeyLookup[key]

            fastKeyStroke('v')
            fastKeyStroke('i')
            fastKeyStroke(keystroke.mods, keystroke.key)
        end
    )
end

function Paste.toEndOfWord()
    Paste.pastePending(
        function()
            fastKeyStroke('v')
            fastKeyStroke('e')
        end,
        function()
            fastKeyStroke({'shift', 'alt'}, 'right')
        end
    )
end

function Paste.subword()
    Paste.pastePending(
        function()
            fastKeyStroke('v')
            fastKeyStroke('i')
            fastKeyStroke('q')
        end,
        function()
            fastKeyStroke({'shift', 'alt'}, 'left')
        end
    )
end

function Paste.word()
    Paste.pastePending(
        function()
            fastKeyStroke('v')
            fastKeyStroke('i')
            fastKeyStroke('w')
        end,
        function()
            fastKeyStroke({'shift', 'alt'}, 'left')
        end
    )
end

function Paste.toEndOfLine()
    Paste.pastePending(
        function()
            fastKeyStroke('v')
            fastKeyStroke({'shift', 'cmd'}, 'right')
        end,
        function()
            fastKeyStroke({'shift', 'cmd'}, 'right')
        end
    )
end

function Paste.toBeginningOfLine()
    Paste.pastePending(
        function() fastKeyStroke({'shift', 'cmd'}, 'left') end,
        function() fastKeyStroke({'shift', 'cmd'}, 'left') end
    )
end

function Paste.line()
    Paste.pastePending(
        function()
            fastKeyStroke({'shift'}, 'v')
        end,
        function()
            fastKeyStroke({'cmd'}, 'left')
            fastKeyStroke({'shift', 'cmd'}, 'right')
        end
    )
end

function Paste.character()
    Paste.pastePending(
        function() fastKeyStroke('v') end,
        function() fastKeyStroke({'shift'}, 'left') end
    )
end

function Paste.pastePending(selectTextWhenInVim, selectTextWhenInDefault)
    Pending.run({
        function()
            Paste.selectText(selectTextWhenInVim, selectTextWhenInDefault)
            Paste.pasteFirst()
        end,
        function()
            Paste.selectText(selectTextWhenInVim, selectTextWhenInDefault)
            Paste.pasteNext()
        end,
    })
end

function Paste.selectText(selectTextWhenInVim, selectTextWhenInDefault)
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
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

function Paste.default()
    fastKeyStroke({'cmd'}, 'v')
end

function Paste.primaryVim()
    fastKeyStroke('p')
end

function Paste.secondaryVim()
    fastKeyStroke({'shift'}, 'p')
end

function Paste.backward()
    if inCodeEditor() then
        fastKeyStroke({'shift'}, 'p')
    end
end

-- Modal.add({
--     key: 'PasteSurround',
--     title: 'Paste Surround',
--     items: Paste.lookup,
--     callback = function(key)
--         Modal.exit()

--         keystroke = TextManipulation.wrapperKeyLookup[key]

--         fastKeyStroke('escape')
--         fastKeyStroke('c')
--         fastKeyStroke('a')
--         fastKeyStroke(keystroke.mods, keystroke.key)

--         if not hasValue({'s', 'd', 't'}, key) then
--             BracketMatching.start()
--         end
--     end,
-- })

-- function Paste.pasteSurround()
--     if inCodeEditor() then
--         fastKeyStroke({'shift'}, 'p')
--     end
-- end

return Paste
