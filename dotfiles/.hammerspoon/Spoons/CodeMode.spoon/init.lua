local Code = {}
Code.__index = Code

Code.lookup = {
    -- Key: Y
    y = function()
        hs.eventtap.keyStrokes(' && ')
    end,

    -- Key: U
    u = function()
        if appIs(iterm) then
            -- Git: Discard changes
            typeAndEnter('nah')
        else
            -- Atom: Add use statement
            hs.eventtap.keyStroke({'ctrl', 'alt'}, 'u')
        end
    end,

    -- Key: I
    i = function()
        -- Multiple cursors up
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt'}, 'up')
    end,

    -- Key: O
    o = function()
        if appIs(iterm) then
            -- Git: Checkout
            typeAndEnter('gco')
        else
            hs.eventtap.keyStrokes(' != ')
        end
    end,

    -- Key: P
    p = function()
        if appIs(iterm) then
            -- Git: Push
            typeAndEnter('gps')
        else
            hs.eventtap.keyStrokes(' || ')
        end
    end,

    -- Key: [
    open_bracket = function()
        -- Fold
        hs.eventtap.keyStroke({'alt', 'cmd'}, '[')
    end,

    -- Key: ]
    close_bracket = function()
        -- Unfold
        hs.eventtap.keyStroke({'alt', 'cmd'}, ']')
    end,

    -- Key: h
    h = function()
        if appIs(iterm) then
            -- Git: Status
            typeAndEnter('gs')
        else
            hs.eventtap.keyStrokes(' == ')
        end
    end,

    -- Key: j
    j = function()
        if appIs(iterm) then
            -- iTerm: Autocomplete next word
            hs.eventtap.keyStroke({'shift', 'alt', 'cmd'}, 'J')
        elseif appIs(notion) then
            hs.eventtap.keyStroke({'shift', 'cmd'}, 'Down')
        elseif appIs(atom) or appIs(sublime) then
            -- Atom, Sublime: Move line down
            hs.eventtap.keyStroke({'ctrl', 'cmd'}, 'Down')
        end
    end,

    -- Key: k
    k = function()
        if appIs(notion) then
            hs.eventtap.keyStroke({'shift', 'cmd'}, 'Up')
            hs.eventtap.keyStroke({'shift', 'cmd'}, 'Up')
        elseif appIs(atom) or appIs(sublime) then
            -- Atom, Sublime: Move line up
            hs.eventtap.keyStroke({'ctrl', 'cmd'}, 'Up')
        end
    end,

    -- Key: l
    l = function()
        if appIs(iterm) then
            -- Git: Pull
            typeAndEnter('gpl')
        else
            -- Atom: Go to definition
            hs.eventtap.keyStroke({'alt', 'cmd'}, 'down')
        end
    end,

    -- Key: ;
    semicolon = function()
        -- Atom: Toggle semicolon at end of line
        hs.eventtap.keyStroke({'alt'}, ';')
    end,

    -- Key: '
    quote = function()
        hs.eventtap.keyStrokes(' = ')
    end,

    -- Key: return_or_enter
    return_or_enter = function()
        if appIs(iterm) then
            ProjectManager.serveCurrent()
        else
            hs.eventtap.keyStrokes('return')
        end
    end,

    -- Key: b
    b = function()
        if appIs(sublime) then
            hs.eventtap.keyStroke({'alt', 'cmd'}, 'x')
        elseif appIs(atom) then
            -- Toggle Boolean
            hs.eventtap.keyStroke({}, '-')
        end
    end,

    -- Key: n
    n = function()
        -- Select next word
        hs.eventtap.keyStroke({'cmd'}, 'd')
    end,

    -- Key: m
    m = function()
        if appIs(iterm) then
            -- Git: Merge
            typeAndEnter('gm')
        else
            -- Multiple cursors down
            hs.eventtap.keyStroke({'shift', 'ctrl', 'alt'}, 'down')
        end
    end,

    -- Key: ,
    comma = function()
        -- Atom: Toggle comma at end of line
        hs.eventtap.keyStroke({'alt'}, ',')
    end,

    -- Key: .
    period = function()
        hs.eventtap.keyStrokes(' => ')
    end,

    -- Key: /
    slash = function()
        -- Atom: Go to matching bracket
        hs.eventtap.keyStroke({'ctrl'}, 'm')
    end,

    -- Key: spacebar
    spacebar = function()
        -- Comment
        hs.eventtap.keyStroke({'cmd'}, '/')
    end,
}

hs.urlevent.bind('code', function(eventName, params)
    if Code.lookup[params.key] then
        Code.lookup[params.key]()
    end
end)

return Code
