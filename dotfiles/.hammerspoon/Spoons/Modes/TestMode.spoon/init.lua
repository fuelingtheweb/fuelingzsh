local TestMode = {}
TestMode.__index = TestMode

function TestMode.k()
    if appIs(atom) then
        -- Atom PHPUnit: Test Class
        hs.eventtap.keyStroke({'alt', 'cmd'}, 't')
    end
end

function TestMode.l()
    if appIs(atom) then
        -- Atom PHPUnit: Test All
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 't')
    end
end

function TestMode.m()
    if appIs(atom) then
        -- Atom PHPUnit: Test Method
        hs.eventtap.keyStroke({'ctrl', 'alt'}, 't')
    end
end

return TestMode
