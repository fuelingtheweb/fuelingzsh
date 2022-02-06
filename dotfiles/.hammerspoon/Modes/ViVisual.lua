local ViVisual = {}
ViVisual.__index = ViVisual

ViVisual.lookup = {
    y = 'selectToTopOfPage',
    u = 'selectLineUp',
    i = 'selectToFirstCharacterOfLine',
    o = 'selectToEndOfLine',
    p = nil,
    open_bracket = nil,
    close_bracket = nil,
    h = 'selectLeft',
    j = 'selectDown',
    k = 'selectUp',
    l = 'selectRight',
    semicolon = 'selectToPreviousWholeWord',
    quote = 'selectToEndOfWholeWord',
    return_or_enter = 'selectToNextWholeWord',
    n = 'selectToBottomOfPage',
    m = 'selectLineDown',
    comma = 'selectPreviousWord',
    period = 'selectNextWord',
    slash = 'selectToPreviousSubword',
    right_shift = 'selectToNextSubword',
    spacebar = nil,
}

function ViVisual.selectToPreviousSubword()
    md.SelectUntil.beginSelectingBackward()
    
    if appIs(vscode) then
        fastKeyStroke('\\')
        fastKeyStroke('b')
    else
        fastKeyStroke({'shift'}, 'q')
    end
end

function ViVisual.selectToNextSubword()
    md.SelectUntil.beginSelectingForward()

    if appIs(vscode) then
        fastKeyStroke('\\')
        fastKeyStroke('e')
    else
        fastKeyStroke('q')
    end
end

function ViVisual.selectToPreviousWholeWord()
    md.SelectUntil.beginSelectingBackward()
    fastKeyStroke({'shift'}, 'b')
end

function ViVisual.selectToEndOfWholeWord()
    md.SelectUntil.beginSelectingForward()
    fastKeyStroke({'shift'}, 'e')
end

function ViVisual.selectToNextWholeWord()
    md.SelectUntil.beginSelectingForward()
    fastKeyStroke({'shift'}, 'w')

    if appIs(vscode) and TextManipulation.vimEnabled then
        fastKeyStroke('h')
    end
end

function ViVisual.selectToTopOfPage()
    if appIs(finder) then
        fastKeyStroke({'shift', 'alt'}, 'up')
    elseif appIs(vscode) and TextManipulation.vimEnabled then
        md.SelectUntil.beginSelectingForward()
        fastKeyStroke('g')
        fastKeyStroke('g')
    else
        fastKeyStroke({'shift', 'cmd'}, 'up')
    end
end

function ViVisual.selectToFirstCharacterOfLine()
    md.SelectUntil.beginningOfLine()
end

function ViVisual.selectToEndOfLine()
    if appIs(vscode) and TextManipulation.vimEnabled then
        fastKeyStroke({'ctrl'}, 'v')
        fastKeyStroke({'shift'}, '4')
        fastKeyStroke('left')
    else
        fastKeyStroke({'shift', 'cmd'}, 'right')
    end
end

function ViVisual.selectToBottomOfPage()
    if appIs(finder) then
        fastKeyStroke({'shift', 'alt'}, 'down')
    elseif appIs(vscode) and TextManipulation.vimEnabled then
        md.SelectUntil.beginSelectingForward()
        fastKeyStroke({'shift'}, 'g')
    else
        fastKeyStroke({'shift', 'cmd'}, 'down')
    end
end

function ViVisual.selectLineUp()
    if TextManipulation.vimEnabled then
        fastKeyStroke({'shift'}, 'v')
    end

    if appIs(vscode) and TextManipulation.vimEnabled then
        fastKeyStroke('k')
    else
        fastKeyStroke('up')
    end
end

function ViVisual.selectLineDown()
    if TextManipulation.vimEnabled then
        fastKeyStroke({'shift'}, 'v')
    end
    
    if appIs(vscode) and TextManipulation.vimEnabled then
        fastKeyStroke('j')
    else
        fastKeyStroke('down')
    end
end

function ViVisual.selectLeft()
    if appIs(vscode) and TextManipulation.vimEnabled then
        fastKeyStroke({'ctrl'}, 'v')
        fastKeyStroke('left')
    elseif inCodeEditor() and TextManipulation.vimEnabled then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'v')
        fastKeyStroke('left')
    else
        fastKeyStroke({'shift'}, 'left')
    end
end

function ViVisual.selectDown()
    if appIs(vscode) and TextManipulation.vimEnabled then
        fastKeyStroke({'ctrl'}, 'v')
        fastKeyStroke({'ctrl'}, 'down')
    else
        fastKeyStroke({'shift'}, 'down')

        if inCodeEditor() then
            fastKeyStroke({'shift'}, 'left')
        end
    end
end

function ViVisual.selectUp()
    if appIs(vscode) and TextManipulation.vimEnabled then
        fastKeyStroke({'ctrl'}, 'v')
        fastKeyStroke({'ctrl'}, 'up')
    else
        fastKeyStroke({'shift'}, 'up')
    end
end

function ViVisual.selectRight()
    if appIs(vscode) and TextManipulation.vimEnabled then
        fastKeyStroke({'ctrl'}, 'v')
        fastKeyStroke('right')
    else
        fastKeyStroke({'shift'}, 'right')
    end
end

function ViVisual.selectPreviousWord()
    if appIs(vscode) and TextManipulation.vimEnabled then
        fastKeyStroke({'ctrl'}, 'v')
        fastKeyStroke('b')
        return
    elseif inCodeEditor() and TextManipulation.vimEnabled then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'v')
        fastKeyStroke('left')
    end

    fastKeyStroke({'shift', 'alt'}, 'left')
end

function ViVisual.selectNextWord()
    if appIs(vscode) and TextManipulation.vimEnabled then
        fastKeyStroke({'ctrl'}, 'v')
        fastKeyStroke('e')
        return
    else
        fastKeyStroke({'shift', 'alt'}, 'right')
    end
end

return ViVisual
