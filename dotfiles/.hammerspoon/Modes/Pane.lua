local Pane = {}
Pane.__index = Pane

Pane.lookup = {
    y = nil,
    u = nil,
    i = nil,
    o = nil,
    p = nil,
    open_bracket = nil,
    close_bracket = nil,
    h = nil,
    j = 'focusPrevious',
    k = 'focusNext',
    l = 'splitRight',
    semicolon = 'toggleZoom',
    quote = 'focusOtherSide',
    return_or_enter = nil,
    n = 'splitBottom',
    m = 'destroy',
    comma = nil,
    period = nil,
    slash = nil,
    right_shift = nil,
    spacebar = nil
}

function Pane.destroy()
    if appIncludes({atom, sublime}) then
        ks.super('p')
        ks.sequence({'o', 'd', 's'})
    elseif appIs(vscode) then
        ks.super('p')
        ks.super('d')
    elseif appIs(iterm) then
        ks.close()
    end
end

function Pane.splitRight()
    if appIncludes({atom, sublime}) then
        ks.super('p')
        ks.sequence({'o', 'c', 'l'})
    elseif appIs(vscode) then
        ks.super('p')
        ks.super('l')
    elseif appIs(iterm) then
        ks.cmd('d')
    end
end

function Pane.splitBottom()
    if appIncludes({atom, sublime}) then
        ks.super('p')
        ks.sequence({'o', 'c', 'j'})
    end
end

function Pane.toggleZoom()
    if appIncludes({atom, sublime}) then
        ks.super('p')
        ks.sequence({'o', 'z'})
    elseif appIs(iterm) then
        ks.shiftCmd('return')
    end
end

function Pane.focusPrevious()
    if appIs(chrome) and stringContains('Google Sheets', currentTitle()) then
        ks.alt('up')
    elseif appIncludes({atom, sublime}) then
        ks.super('p')
        ks.sequence({'o', 'h'})
    elseif appIs(vscode) then
        ks.super('p')
        ks.super('k')
    elseif appIs(transmit) then
        ks.altCmd('left')
    elseif appIs(tableplus) then
        ks.altCmd('[')
    else
        ks.cmd('[')
    end
end

function Pane.focusNext()
    if appIs(chrome) and stringContains('Google Sheets', currentTitle()) then
        ks.alt('down')
    elseif appIncludes({atom, sublime}) then
        ks.super('p')
        ks.sequence({'o', 'l'})
    elseif appIs(vscode) then
        ks.super('p')
        ks.super('j')
    elseif appIs(transmit) then
        ks.altCmd('right')
    elseif appIs(tableplus) then
        ks.altCmd(']')
    else
        ks.cmd(']')
    end
end

function Pane.focusOtherSide()
    if appIs(vscode) then
        ks.super('p')
        ks.super(';')
    end
end

return Pane
