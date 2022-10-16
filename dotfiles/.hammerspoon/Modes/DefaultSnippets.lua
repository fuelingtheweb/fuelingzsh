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
    h = fn.misc.showSnippets,
    j = 'generalSnippetsModal',
    k = 'k',
    l = 'log',
    semicolon = ' : ',
    quote = 'equals',
    return_or_enter = 'return',
    n = nil,
    m = 'm',
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
            if is.Function(callable) then
                callable()
            elseif DefaultSnippets[callable] then
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

function DefaultSnippets.k()
    if is.In('85C27NK92C.com.flexibits.fantastical2.mac.helper') then
        ks.type('/Todo ')
        ks.sequence({',', ',', 't', 'd'})
        hs.timer.doAfter(0.1, function()
            ks.type(' ')
        end)
    end
end

function DefaultSnippets.m()
    if is.In('85C27NK92C.com.flexibits.fantastical2.mac.helper') then
        ks.type('/Deliveries ')
        ks.sequence({',', ',', 'p', 'h'})
        hs.timer.doAfter(0.1, function()
            ks.type(' ')
        end)
    end
end

function DefaultSnippets.log()
    if is.In('85C27NK92C.com.flexibits.fantastical2.mac.helper') then
        ks.type('/Deliveries ')
        ks.sequence({',', ',', 'p', 'p'})
        hs.timer.doAfter(0.1, function()
            ks.type(' ')
        end)
    else
        ks.type('console.log()')
    end
end

return DefaultSnippets
