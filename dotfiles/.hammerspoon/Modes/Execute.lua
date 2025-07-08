local Execute = {}
Execute.__index = Execute

Execute.lookup = {
    y = 'openFactory',
    -- u
    i = nil,
    o = 'openLink',
    p = nil,
    open_bracket = nil,
    close_bracket = nil,
    h = nil,
    j = 'scrollDown',
    k = 'scrollUp',
    l = 'goToDefinition',
    semicolon = 'openHerdDumps',
    quote = 'openHerdLogs',
    return_or_enter = nil,
    n = 'nextOccurrence',
    m = 'openHerdMail',
    comma = nil,
    period = 'openPath',
    slash = nil,
    right_shift = nil,
    spacebar = 'openLink',
}

function Execute.goToDefinition()
    local text = str.selected()

    if not text then
        md.Yank.word()
        hs.timer.doAfter(0.2, function()
            text = fn.clipboard.get()
        end)
    end

    hs.timer.doAfter(0.4, function()
        if is.js() or is.blade() then
            text = text .. '.js'
        elseif is.php() then
            text = text .. '.php'
        end

        fn.Code.openFile(text)
    end)
end

function Execute.openLink()
    if is.vscode() then
        ks.altCmd('return')
    end
end

function Execute.openPath()
    if not is.codeEditor() then
        return
    end

    ks.alt('p')
end

function Execute.nextOccurrence()
    ks.escape().shift('8')
end

function Execute.openFactory()
    local text = str.selected()

    if not text then
        md.Yank.word()
        hs.timer.doAfter(0.2, function()
            text = fn.clipboard.get()
        end)
    end

    hs.timer.doAfter(0.4, function()
        fn.Code.openFile(text .. 'Factory')
    end)
end

function Execute.scrollDown()
    ks.shiftCtrlAlt('j')
end

function Execute.scrollUp()
    ks.shiftCtrlAlt('k')
end

function Execute.openHerdDumps()
    ks.super('d')
end

function Execute.openHerdLogs()
    ks.super('l')
end

function Execute.openHerdMail()
    ks.super('m')
end

return Execute
