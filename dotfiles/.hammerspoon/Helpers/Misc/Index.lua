local Misc = {}
Misc.__index = Misc

local DismissNotifications = require('Helpers.Misc.DismissNotifications')

function Misc.DismissNotifications()
    DismissNotifications.run()
end

function Misc.executeFromFuelingZsh(command)
    return hs.execute('~/.fuelingzsh/bin/' .. command)
end

function Misc.showSnippets()
    Modal.enter('MiscSnippets')
end

function Misc.moveMouse()
    -- Under System Preferences: Mouse & Trackpad, Enable Mouse Keys and set the Initial Delay option to Short
    -- original = hs.mouse.getAbsolutePosition()
    if is.chrome() and fn.window.titleContains('Prime Video') then
        hs.mouse.absolutePosition({x = 1900, y = 900})
        ks.key('pad6')
        hs.mouse.absolutePosition({x = 1900, y = 300})
        ks.key('pad6')
    elseif is.chrome() and fn.window.titleContains('TV') or fn.window.titleContains('Disney') then
        hs.mouse.absolutePosition({x = 600, y = 900})
        ks.key('pad6')
        hs.timer.doAfter(0.8, function()
            hs.mouse.absolutePosition({x = 160, y = 300})
            ks.key('pad6')
        end)
    else
        hs.mouse.absolutePosition({x = 600, y = 900})
        ks.key('pad6')
        hs.mouse.absolutePosition({x = 160, y = 300})
        ks.key('pad6')
    end
end

function Misc.open(url)
    hs.execute('open ' .. url)
end

return Misc
