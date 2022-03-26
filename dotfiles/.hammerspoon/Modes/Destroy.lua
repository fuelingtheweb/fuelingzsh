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

    ks.escape()
    ks.key('d')
    ks.key('i')
    ks.fire(keystroke.mods, keystroke.key)
end

function Destroy.simpleDelete()
    if inCodeEditor() then
        BracketMatching.cancel()
        BracketMatching.start()
    else
        ks.key('delete')
    end
end

function Destroy.toEndOfWord()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('d')
        ks.key('e')
    else
        ks.shiftAlt('right')
        ks.key('delete')
    end
end

function Destroy.subword()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('d')
        ks.key('i')

        if appIs(vscode) then
            ks.key('\\')
            ks.key('w')
        else
            ks.key('q')
        end
    end
end

function Destroy.word()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('d')
        ks.key('i')
        ks.key('w')
    elseif appIs(iterm) then
        ks.ctrl('w')
    else
        ks.alt('delete')
    end
end

function Destroy.toEndOfLine()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.shift('d')
    else
        ks.shiftCmd('right')
        ks.key('delete')
    end
end

function Destroy.toBeginningOfLine()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()

        if appIs(vscode) then
            md.SelectUntil.beginningOfLine()
        else
            ks.shiftCmd('left')
        end

        ks.key('d')
    else
        ks.shiftCmd('left')
        ks.key('delete')
    end
end

function Destroy.line()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('d')
        ks.key('d')
    else
        ks.cmd('left')
        ks.shiftCmd('right')
        ks.key('delete')
    end
end

function Destroy.character()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('x')
    else
        ks.key('delete')
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
            ks.key('k')
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
        ks.key('d')
        ks.key('d')
    end
}

function Destroy.modeForward() Destroy.enterModal('F') end

function Destroy.mode() Destroy.enterModal() end

function Destroy.modeBackward() Destroy.enterModal('B') end

function Destroy.untilForward()
    ks.escape()
    ks.key('d')
    ks.key('t')
end

function Destroy.untilBackward()
    ks.escape()
    ks.key('d')
    ks.shift('t')
end

function Destroy.backward()
    if inCodeEditor() then
        ks.super('v')
        ks.escape()
        ks.key('left')
        ks.key('x')
    end
end

return Destroy
