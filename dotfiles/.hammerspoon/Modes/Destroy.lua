local Destroy = {}
Destroy.__index = Destroy

Destroy.lookup = {
    tab = 'untilBackward',
    q = 'subword',
    w = 'word',
    e = 'toEndOfWord',
    r = 'untilForward',
    t = 'withWrapperKey',
    caps_lock = 'backward',
    a = 'toEndOfLine',
    s = 'withWrapperKey',
    d = 'withWrapperKey',
    f = 'withWrapperKey',
    g = 'toBeginningOfLine',
    left_shift = nil,
    z = 'withWrapperKey',
    x = 'character',
    c = 'withWrapperKey',
    v = 'line',
    b = 'withWrapperKey',
    spacebar = 'simpleDelete'
}

function Destroy.withWrapperKey(key)
    keystroke = TextManipulation.wrapperKeyLookup[key]

    fastKeyStroke('escape')
    fastKeyStroke('d')
    fastKeyStroke('i')
    fastKeyStroke(keystroke.mods, keystroke.key)
end

function Destroy.simpleDelete()
    if inCodeEditor() then
        BracketMatching.cancel()
        BracketMatching.start()
    else
        fastKeyStroke('delete')
    end
end

function Destroy.toEndOfWord()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('d')
        fastKeyStroke('e')
    else
        fastKeyStroke({'shift', 'alt'}, 'right')
        fastKeyStroke('delete')
    end
end

function Destroy.subword()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('d')
        fastKeyStroke('i')

        if appIs(vscode) then
            fastKeyStroke('\\')
            fastKeyStroke('w')
        else
            fastKeyStroke('q')
        end
    end
end

function Destroy.word()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('d')
        fastKeyStroke('i')
        fastKeyStroke('w')
    elseif appIs(iterm) then
        fastKeyStroke({'ctrl'}, 'w')
    else
        fastKeyStroke({'alt'}, 'delete')
    end
end

function Destroy.toEndOfLine()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'd')
    else
        fastKeyStroke({'shift', 'cmd'}, 'right')
        fastKeyStroke('delete')
    end
end

function Destroy.toBeginningOfLine()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')

        if appIs(vscode) then
            md.SelectUntil.beginningOfLine()
        else
            fastKeyStroke({'shift', 'cmd'}, 'left')
        end

        fastKeyStroke('d')
    else
        fastKeyStroke({'shift', 'cmd'}, 'left')
        fastKeyStroke('delete')
    end
end

function Destroy.line()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('d')
        fastKeyStroke('d')
    else
        fastKeyStroke({'cmd'}, 'left')
        fastKeyStroke({'shift', 'cmd'}, 'right')
        fastKeyStroke('delete')
    end
end

function Destroy.character()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('x')
    else
        fastKeyStroke('delete')
    end
end

Destroy.direction = nil
Destroy.key = nil

Modal.add({
    key = 'Destroy',
    title = function()
        return 'Destroy: ' .. (Destroy.direction or '') .. ' ' ..
                   (Destroy.key or '')
    end,
    items = {[','] = 'backward', [';'] = 'forward', ['v'] = 'line'},
    callback = function(action) Destroy.actions[action]() end,
    exited = function()
        Destroy.direction = nil
        Destroy.key = nil
    end
})

function Destroy.triggerDirectionIfSet()
    if not Destroy.direction then return end

    if Destroy.direction == 'F' then
        action = 'forward'
    else
        action = 'backward'
    end
    Destroy.actions[action]()
end

function Destroy.enterModal(direction, key)
    Destroy.direction = direction or nil
    Destroy.key = key or nil
    Modal.enter('Destroy')
end

Destroy.actions = {
    backward = function()
        if not TextManipulation.canManipulateWithVim() then
            return Modal.exit()
        end

        Destroy.enterModal('B', Destroy.key)

        if not Destroy.key then return end

        if inCodeEditor() then
            Destroy.keymap[Destroy.key]()
            fastKeyStroke('k')
        end
    end,

    forward = function()
        if not TextManipulation.canManipulateWithVim() then
            return Modal.exit()
        end

        Destroy.enterModal('F', Destroy.key)

        if not Destroy.key then return end

        if inCodeEditor() then Destroy.keymap[Destroy.key]() end
    end,

    line = function()
        Destroy.enterModal(Destroy.direction, "v")

        Destroy.triggerDirectionIfSet()
    end
}

Destroy.keymap = {
    ['v'] = function()
        fastKeyStroke('d')
        fastKeyStroke('d')
    end
}

function Destroy.modeForward() Destroy.enterModal('F') end

function Destroy.mode() Destroy.enterModal() end

function Destroy.modeBackward() Destroy.enterModal('B') end

function Destroy.untilForward()
    fastKeyStroke('escape')
    fastKeyStroke('d')
    fastKeyStroke('t')
end

function Destroy.untilBackward()
    fastKeyStroke('escape')
    fastKeyStroke('d')
    fastKeyStroke({'shift'}, 't')
end

function Destroy.backward()
    if inCodeEditor() then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'v')
        fastKeyStroke('escape')
        fastKeyStroke('left')
        fastKeyStroke('x')
    end
end

return Destroy
