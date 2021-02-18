local TestMode = {}
TestMode.__index = TestMode

TestMode.lookup = {
    -- Key: k
    k = function()
        if appIs(atom) then
            -- Atom PHPUnit: Test Class
            hs.eventtap.keyStroke({'alt', 'cmd'}, 't')
        end
    end,

    -- Key: l
    l = function()
        if appIs(atom) then
            -- Atom PHPUnit: Test All
            hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 't')
        end
    end,

    -- Key: m
    m = function()
        if appIs(atom) then
            -- Atom PHPUnit: Test Method
            hs.eventtap.keyStroke({'ctrl', 'alt'}, 't')
        end
    end,
}

return TestMode
