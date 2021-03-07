local TestMode = {}
TestMode.__index = TestMode

function TestMode.k()
    if appIs(atom) then
        -- Atom PHPUnit: Test Class
        fastKeyStroke({'alt', 'cmd'}, 't')
    end
end

function TestMode.l()
    if appIs(atom) then
        -- Atom PHPUnit: Test All
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 't')
    end
end

function TestMode.m()
    if appIs(atom) then
        -- Atom PHPUnit: Test Method
        fastKeyStroke({'ctrl', 'alt'}, 't')
    end
end

return TestMode
