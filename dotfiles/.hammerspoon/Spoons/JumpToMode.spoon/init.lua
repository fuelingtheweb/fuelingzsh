local JumpToMode = {}
JumpToMode.__index = JumpToMode

JumpToMode.timer = nil

function JumpToMode.pending(firstCallback, secondCallback)
    if not JumpToMode.timer or not JumpToMode.timer:running() then
        JumpToMode.timer = hs.timer.doAfter(0.2, function()
            firstCallback()
        end)
    else
        if JumpToMode.timer and JumpToMode.timer:running() then
            JumpToMode.timer:stop()
        end

        secondCallback()
    end
end

JumpToMode.lookup = {
    s = {mods = {}, key = "'"}, -- s -> single quotes
    d = {mods = {'shift'}, key = "'"}, -- d -> double quotes
    z = {mods = {'alt'}, key = '`'}, -- z -> back ticks
    f = {
        {mods = {'shift'}, key = '9'}, -- f -> opening parenthesis
        {mods = {'shift'}, key = '0'}, -- f -> closing parenthesis
    },
    c = {
        {mods = {'shift'}, key = '['}, -- c -> opening brace
        {mods = {'shift'}, key = ']'}, -- c -> closing brace
    },
    b = {
        {mods = {}, key = '['}, -- b -> opening bracket
        {mods = {}, key = ']'}, -- b -> closing bracket
    },
}

function JumpToMode.handle(key)
    if key == 't' then
        -- Previous block
        hs.eventtap.keyStroke({'shift'}, '[', 0)
    elseif has_value({'f', 'c', 'b'}, key) then
        local keystrokes = JumpToMode.lookup[key]
        JumpToMode.pending(
            function()
                JumpToMode.to(keystrokes[1])
            end,
            function()
                JumpToMode.to(keystrokes[2])
            end
        )
    elseif JumpToMode.lookup[key] then
        JumpToMode.to(JumpToMode.lookup[key])
    end
end

function JumpToMode.to(keystroke)
    hs.eventtap.keyStroke({}, 'f', 0)
    hs.eventtap.keyStroke(keystroke.mods, keystroke.key, 0)
end

return JumpToMode
