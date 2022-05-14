local Make = {}
Make.__index = Make

Make.lookup = {
    tab = nil,
    q = nil,
    w = cm.Search.window,
    e = cm.Search.viaAlfred,
    r = 'lineBefore',
    t = 'tag',
    caps_lock = Brackets.startMulti,
    a = cm.Search.amazon,
    s = 'singleQuote',
    d = 'doubleQuote',
    f = 'parenthesis',
    g = cm.Search.google,
    left_shift = nil,
    z = 'backTick',
    x = cm.Search.files,
    c = 'braces',
    v = 'lineAfter',
    b = 'brackets',
    spacebar = 'space',
}

function Make.fallback(bracket)
    Brackets.print(bracket)
end

function Make.lineBefore()
    if is.vscode() and is.todoOrMarkdown() then
        ks.escape().slow().shift('o')
        md.Command.newTask()
    elseif is.vimMode() then
        ks.escape().shift('o')
    elseif is.googleSheet() then
        ks.ctrlAlt('i').key('r').enter()
    elseif is.chat() then
        md.Vi.moveToFirstCharacterOfLine()
        ks.shift('return').up()
    else
        md.Vi.moveToFirstCharacterOfLine()
        ks.enter().up()
    end
end

function Make.lineAfter()
    if is.vscode() and is.todoOrMarkdown() then
        ks.escape().slow().key('o')
        md.Command.newTask()
    elseif is.vimMode() then
        ks.escape().key('o')
    elseif is.googleSheet() then
        ks.ctrlAlt('i').key('r').key('b').enter()
    elseif is.chat() then
        md.Vi.moveToEndOfLine()
        ks.shift('return')
    else
        md.Vi.moveToEndOfLine()
        ks.enter()
    end
end

return Make
