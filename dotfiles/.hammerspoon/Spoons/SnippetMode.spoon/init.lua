local obj = {}
obj.__index = obj

function snippet(name)
    if appIs(sublime) then
        typeAndTab('snippet-' .. name)
    else
        typeAndEnter('snippet-' .. name)
    end
end

hs.urlevent.bind('snippet-method', function()
    if appIs(atom) and titleContains('Test.php') then
        snippet('testmethod')
    else
        snippet('method')
    end
end)

hs.urlevent.bind('snippet', function(eventName, params)
    snippet(params.name)
end)

return obj
