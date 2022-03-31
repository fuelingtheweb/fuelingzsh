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
    spacebar = nil,
}

function Pane.destroy()
    if is.In(atom, sublime) then
        ks.super('p').sequence({'o', 'd', 's'})
    elseif is.vscode() then
        ks.super('p').super('d')
    elseif is.iterm() then
        ks.close()
    end
end

function Pane.splitRight()
    if is.In(atom, sublime) then
        ks.super('p').sequence({'o', 'c', 'l'})
    elseif is.vscode() then
        ks.super('p').super('l')
    elseif is.iterm() then
        ks.cmd('d')
    end
end

function Pane.splitBottom()
    if is.In(atom, sublime) then
        ks.super('p').sequence({'o', 'c', 'j'})
    end
end

function Pane.toggleZoom()
    if is.In(atom, sublime) then
        ks.super('p').sequence({'o', 'z'})
    elseif is.iterm() then
        ks.shiftCmd('return')
    end
end

function Pane.focusPrevious()
    if is.chrome() and stringContains('Google Sheets', currentTitle()) then
        ks.alt('up')
    elseif is.In(atom, sublime) then
        ks.super('p').sequence({'o', 'h'})
    elseif is.vscode() then
        ks.super('p').super('k')
    elseif is.In(transmit) then
        ks.altCmd('left')
    elseif is.In(tableplus) then
        ks.altCmd('[')
    else
        ks.cmd('[')
    end
end

function Pane.focusNext()
    if is.chrome() and stringContains('Google Sheets', currentTitle()) then
        ks.alt('down')
    elseif is.In(atom, sublime) then
        ks.super('p').sequence({'o', 'l'})
    elseif is.vscode() then
        ks.super('p').super('j')
    elseif is.In(transmit) then
        ks.altCmd('right')
    elseif is.In(tableplus) then
        ks.altCmd(']')
    else
        ks.cmd(']')
    end
end

function Pane.focusOtherSide()
    if is.vscode() then
        ks.super('p').super(';')
    end
end

return Pane
