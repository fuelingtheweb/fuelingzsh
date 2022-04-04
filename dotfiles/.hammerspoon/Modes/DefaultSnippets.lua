local DefaultSnippets = {}
DefaultSnippets.__index = DefaultSnippets

Modal.load('CodeSnippets.General')
Modal.load('CodeSnippets.Equals')

DefaultSnippets.lookup = {
    e = 'elseif',
    t = '$this->',

    y = '&&',
    u = nil,
    i = 'if () {}',
    o = ' + ',
    p = '||',
    open_bracket = 'echo',
    close_bracket = nil,
    h = nil,
    j = 'generalSnippetsModal',
    k = nil,
    l = 'console.log()',
    semicolon = ' : ',
    quote = 'equals',
    return_or_enter = 'return',
    n = nil,
    m = nil,
    comma = ', ',
    period = nil,
    slash = ' ? ',
    right_shift = nil,
    spacebar = nil,
}

function DefaultSnippets.handle(key)
    lookup = DefaultSnippets.lookup

    if lookup and lookup[key] then
        local callable = lookup[key]

        if callable then
            if DefaultSnippets[callable] then
                DefaultSnippets[callable](key)
            elseif DefaultSnippets.fallback then
                DefaultSnippets.fallback(callable, key)
            end
        end
    end
end

function DefaultSnippets.fallback(value)
    ks.type(value)
end

function DefaultSnippets.equals()
    Modal.enter('CodeSnippets:equals')
end

function DefaultSnippets.generalSnippetsModal()
    Modal.enter('CodeSnippets:generalSnippets')
end

return DefaultSnippets
