local Is = {}
Is.__index = Is

function Is.codeEditor()
    return fn.app.codeEditor()
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

    local bundles = table.pack(...)

    table.insert(bundles, bundle)

    return fn.app.includes(bundles)
end

function Is.notIn(...)
    local bundles = table.pack(...)

    return not Is.In(bundles)
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
