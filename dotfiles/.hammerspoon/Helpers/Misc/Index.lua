local Misc = {}
Misc.__index = Misc

local DismissNotifications = require('Helpers.Misc.DismissNotifications')

function Misc.DismissNotifications()
    DismissNotifications.run()
end

function Misc.executeFromFuelingZsh(command)
    return hs.execute('~/.fuelingzsh/bin/' .. command)
end

return Misc
