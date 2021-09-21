local PasteMode = {}
PasteMode.__index = PasteMode

PasteMode.lookup = {
    tab = 'pasteNext',
    q = 'subword',
    w = 'word',
    e = 'toEndOfWord',
    r = nil,
    t = 'withWrapperKey',
    caps_lock = 'backward',
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

function PasteMode.withWrapperKey(key)
    if not TextManipulation.canManipulateWithVim() then
        return
    end

    PasteMode.pastePending(
        function()
            keystroke = TextManipulation.wrapperKeyLookup[key]

            fastKeyStroke('v')
            fastKeyStroke('i')
            fastKeyStroke(keystroke.mods, keystroke.key)
        end
    )
end

function PasteMode.toEndOfWord()
    PasteMode.pastePending(
        function()
            fastKeyStroke('v')
            fastKeyStroke('e')
        end,
        function()
            fastKeyStroke({'shift', 'alt'}, 'right')
        end
    )
end

function PasteMode.subword()
    PasteMode.pastePending(
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

function PasteMode.word()
    PasteMode.pastePending(
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

function PasteMode.toEndOfLine()
    PasteMode.pastePending(
        function()
            fastKeyStroke('v')
            fastKeyStroke({'shift', 'cmd'}, 'right')
        end,
        function()
            fastKeyStroke({'shift', 'cmd'}, 'right')
        end
    )
end

function PasteMode.toBeginningOfLine()
    PasteMode.pastePending(
        function() fastKeyStroke({'shift', 'cmd'}, 'left') end,
        function() fastKeyStroke({'shift', 'cmd'}, 'left') end
    )
end

function PasteMode.line()
    PasteMode.pastePending(
        function()
            fastKeyStroke({'shift'}, 'v')
        end,
        function()
            fastKeyStroke({'cmd'}, 'left')
            fastKeyStroke({'shift', 'cmd'}, 'right')
        end
    )
end

function PasteMode.character()
    PasteMode.pastePending(
        function() fastKeyStroke('v') end,
        function() fastKeyStroke({'shift'}, 'left') end
    )
end

function PasteMode.pastePending(selectTextWhenInVim, selectTextWhenInDefault)
    Pending.run({
        function()
            PasteMode.selectText(selectTextWhenInVim, selectTextWhenInDefault)
            PasteMode.pasteFirst()
        end,
        function()
            PasteMode.selectText(selectTextWhenInVim, selectTextWhenInDefault)
            PasteMode.pasteNext()
        end,
    })
end

function PasteMode.selectText(selectTextWhenInVim, selectTextWhenInDefault)
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        selectTextWhenInVim()
    else
        selectTextWhenInDefault()
    end
end

function PasteMode.pasteFirst()
    if TextManipulation.canManipulateWithVim() then
        PasteMode.primaryVim()
    else
        PasteMode.default()
    end
end

function PasteMode.pasteNext()
    triggerAlfredWorkflow('paste:next', 'com.fuelingtheweb.commands')
end

function PasteMode.default()
    fastKeyStroke({'cmd'}, 'v')
end

function PasteMode.primaryVim()
    fastKeyStroke('p')
end

function PasteMode.secondaryVim()
    fastKeyStroke({'shift'}, 'p')
end

function PasteMode.backward()
    if inCodeEditor() then
        fastKeyStroke({'shift'}, 'p')
    end
end

return PasteMode
