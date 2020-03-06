local obj = {}
obj.__index = obj

function snippet(name)
    typeAndTab('snippet-' .. name)
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
