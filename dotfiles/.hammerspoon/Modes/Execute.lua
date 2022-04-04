local Execute = {}
Execute.__index = Execute

Execute.lookup = {
    y = nil,
    u = 'openFactory',
    i = nil,
    o = 'openLink',
    p = nil,
    open_bracket = nil,
    close_bracket = nil,
    h = nil,
    j = nil,
    k = nil,
    l = 'goToDefinition',
    semicolon = nil,
    quote = nil,
    return_or_enter = nil,
    n = 'nextOccurrence',
    m = nil,
    comma = nil,
    period = 'openPath',
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

function Execute.goToDefinition()
    local text = getSelectedText()

    if not text then
        md.Yank.word()
        hs.timer.doAfter(0.2, function()
            text = hs.pasteboard.getContents()
        end)
    end

    hs.timer.doAfter(0.4, function()
        fn.Code.openFile(text)
    end)
end

function Execute.openLink()
    if is.In(sublime, vscode) then
        ks.altCmd('return')
    end
end

function Execute.openPath()
    if not is.codeEditor() then
        return
    end

    ks.escape().sequence({'y', 'i', "'"})

    hs.timer.doAfter(0.2, function()
        path = hs.pasteboard.getContents()

        if not stringContains('/', path) then
            path = path:gsub('%.', '/')
        end

        path = path:gsub('^/', '')

        hs.timer.doAfter(0.4, function()
            fn.Code.openFile(path)
        end)
    end)
end

function Execute.nextOccurrence()
    ks.escape().shift('8')
end

function Execute.openFactory()
    local text = getSelectedText()

    if not text then
        md.Yank.word()
        hs.timer.doAfter(0.2, function()
            text = hs.pasteboard.getContents()
        end)
    end

    hs.timer.doAfter(0.4, function()
        fn.Code.openFile(text .. 'Factory')
    end)
end

return Execute
