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
    spacebar = nil
}

function ViVisual.selectToPreviousSubword()
    md.SelectUntil.beginSelectingBackward()

    if appIs(vscode) then
        ks.sequence({'\\', 'b'})
    else
        ks.shift('q')
    end
end

function ViVisual.selectToNextSubword()
    md.SelectUntil.beginSelectingForward()

    if appIs(vscode) then
        ks.sequence({'\\', 'e'})
    else
        ks.key('q')
    end
end

function ViVisual.selectToPreviousWholeWord()
    md.SelectUntil.beginSelectingBackward()
    ks.shift('b')
end

function ViVisual.selectToEndOfWholeWord()
    md.SelectUntil.beginSelectingForward()
    ks.shift('e')
end

function ViVisual.selectToNextWholeWord()
    md.SelectUntil.beginSelectingForward()
    ks.shift('w')

    if appIs(vscode) and TextManipulation.vimEnabled then ks.key('h') end
end

function ViVisual.selectToTopOfPage()
    if appIs(finder) then
        ks.shiftAlt('up')
    elseif appIs(vscode) and TextManipulation.vimEnabled then
        md.SelectUntil.beginSelectingForward()
        ks.sequence({'g', 'g'})
    else
        ks.shiftCmd('up')
    end
end

function ViVisual.selectToFirstCharacterOfLine() md.SelectUntil
    .beginningOfLine() end

function ViVisual.selectToEndOfLine()
    if appIs(vscode) and TextManipulation.vimEnabled then
        ks.ctrl('v').shift('4').left()
    else
        ks.shiftCmd('right')
    end
end

function ViVisual.selectToBottomOfPage()
    if appIs(finder) then
        ks.shiftAlt('down')
    elseif appIs(vscode) and TextManipulation.vimEnabled then
        md.SelectUntil.beginSelectingForward()
        ks.shift('g')
    else
        ks.shiftCmd('down')
    end
end

function ViVisual.selectLineUp()
    if TextManipulation.vimEnabled then ks.shift('v') end

    if appIs(vscode) and TextManipulation.vimEnabled then
        ks.key('k')
    else
        ks.up()
    end
end

function ViVisual.selectLineDown()
    if TextManipulation.vimEnabled then ks.shift('v') end

    if appIs(vscode) and TextManipulation.vimEnabled then
        ks.key('j')
    else
        ks.down()
    end
end

function ViVisual.selectLeft()
    if appIs(vscode) and TextManipulation.vimEnabled then
        ks.ctrl('v').left()
    elseif inCodeEditor() and TextManipulation.vimEnabled then
        ks.super('v').left()
    else
        ks.shift('left')
    end
end

function ViVisual.selectDown()
    if appIs(vscode) and TextManipulation.vimEnabled then
        ks.ctrl('v').ctrl('down')
    else
        ks.shift('down')

        if inCodeEditor() then ks.shift('left') end
    end
end

function ViVisual.selectUp()
    if appIs(vscode) and TextManipulation.vimEnabled then
        ks.ctrl('v').ctrl('up')
    else
        ks.shift('up')
    end
end

function ViVisual.selectRight()
    if appIs(vscode) and TextManipulation.vimEnabled then
        ks.ctrl('v').right()
    else
        ks.shift('right')
    end
end

function ViVisual.selectPreviousWord()
    if appIs(vscode) and TextManipulation.vimEnabled then
        ks.ctrl('v').key('b')
        return
    elseif inCodeEditor() and TextManipulation.vimEnabled then
        ks.super('v').left()
    end

    ks.shiftAlt('left')
end

function ViVisual.selectNextWord()
    if appIs(vscode) and TextManipulation.vimEnabled then
        ks.ctrl('v').key('e')
        return
    else
        ks.shiftAlt('right')
    end
end

return ViVisual
