local Is = {}
Is.__index = Is

function Is.codeEditor()
    return fn.app.codeEditor()
end

function Is.vimMode()
    return TextManipulation.canManipulateWithVim()
end

function Is.notVimMode()
    return not Is.vimMode()
end

function Is.chrome()
    return Is.In(chrome)
end

function Is.finder()
    return Is.In(finder)
end

function Is.iterm()
    return Is.In(iterm)
end

function Is.sublime()
    return Is.In(sublime)
end

function Is.vscode()
    return Is.In(vscode)
end

function Is.In(bundle, ...)
    if Is.Table(bundle) then
        return fn.app.includes(bundle)
    end

    return fn.app.includes(table.pack(bundle, ...))
end

function Is.notIn(...)
    return not Is.In(table.pack(...))
end

function Is.String(value)
    return type(value) == 'string'
end

function Is.Table(value)
    return type(value) == 'table'
end

function Is.Function(value)
    return type(value) == 'function'
end

function Is.lua()
    return titleContains('.lua')
end

return Is
