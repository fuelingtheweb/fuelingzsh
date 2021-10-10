local Execute = {}
Execute.__index = Execute

Execute.lookup = {
    y = nil,
    u = nil,
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
    n = nil,
    m = nil,
    comma = nil,
    period = 'openPath',
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

function Execute.goToDefinition()
    text = getSelectedText()
    if not text then
        md.Yank.word()
        text = hs.pasteboard.getContents()
    end

    hs.timer.doAfter(0.2, function()
        goToFileInAtom(text)
    end)
end

function Execute.openLink()
    if appIs(sublime) then
        fastKeyStroke({'alt', 'cmd'}, 'return')
    end
end

function Execute.openPath()
    if not inCodeEditor() then
        return
    end

    fastKeyStroke('escape')
    fastKeyStroke('y')
    fastKeyStroke('i')
    fastKeyStroke("'")

    path = hs.pasteboard.getContents()

    if not stringContains('/', path) then
        path = path:gsub('%.', '/')
    end

    path = path:gsub('^/', '')

    hs.timer.doAfter(0.2, function()
        goToFileInAtom(path)
    end)
end

return Execute