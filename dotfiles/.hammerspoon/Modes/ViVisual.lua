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
    cm.ViVisual.beginSelectingBackward()

    if is.vscode() then
        ks.sequence({'\\', 'b'})
    else
        ks.shift('q')
    end
end

function ViVisual.selectToNextSubword()
    cm.ViVisual.beginSelectingForward()

    if is.vscode() then
        ks.sequence({'\\', 'e'})
    else
        ks.key('q')
    end
end

function ViVisual.selectToPreviousWholeWord()
    cm.ViVisual.beginSelectingBackward()
    ks.shift('b')
end

function ViVisual.selectToEndOfWholeWord()
    cm.ViVisual.beginSelectingForward()
    ks.shift('e')
end

function ViVisual.selectToNextWholeWord()
    cm.ViVisual.beginSelectingForward()
    ks.shift('w')

    if is.vscode() and is.vimMode() then
        ks.key('h')
    end
end

function ViVisual.selectToTopOfPage()
    if is.finder() then
        ks.shiftAlt('up')
    elseif is.vscode() and is.vimMode() then
        ks.escape().shift('v').sequence({'g', 'g'})
    else
        ks.shiftCmd('up')
    end
end

function ViVisual.selectToFirstCharacterOfLine()
    md.SelectUntil.beginningOfLine()
end

function ViVisual.selectToEndOfLine()
    if is.vscode() and is.vimMode() then
        ks.ctrl('v').shift('4').left()
    else
        ks.shiftCmd('right')
    end
end

function ViVisual.selectToBottomOfPage()
    if is.finder() then
        ks.shiftAlt('down')
    elseif is.vscode() and is.vimMode() then
        ks.escape().shift('v').shift('g')
    else
        ks.shiftCmd('down')
    end
end

function ViVisual.selectLineUp()
    if is.vimMode() then
        ks.shift('v')
    end

    if is.vscode() and is.vimMode() then
        ks.key('k')
    else
        ks.up()
    end
end

function ViVisual.selectLineDown()
    if is.vimMode() then
        ks.shift('v')
    end

    if is.vscode() and is.vimMode() then
        ks.key('j')
    else
        ks.down()
    end
end

function ViVisual.selectLeft()
    if is.vscode() and is.vimMode() then
        ks.ctrl('v').left()
    elseif is.vimMode() then
        ks.super('v').left()
    else
        ks.shift('left')
    end
end

function ViVisual.selectDown()
    if is.vscode() and is.vimMode() then
        ks.ctrl('v').ctrl('down')
    else
        ks.shift('down')

        if is.codeEditor() then
            ks.shift('left')
        end
    end
end

function ViVisual.selectUp()
    if is.vscode() and is.vimMode() then
        ks.ctrl('v').ctrl('up')
    else
        ks.shift('up')
    end
end

function ViVisual.selectRight()
    if is.vscode() and is.vimMode() then
        ks.ctrl('v').right()
    else
        ks.shift('right')
    end
end

function ViVisual.selectPreviousWord()
    if is.vscode() and is.vimMode() then
        ks.ctrl('v').key('b')
        return
    elseif is.vimMode() then
        ks.super('v').left()
    end

    ks.shiftAlt('left')
end

function ViVisual.selectNextWord()
    if is.vscode() and is.vimMode() then
        ks.ctrl('v').key('e')
        return
    else
        ks.shiftAlt('right')
    end
end

return ViVisual
