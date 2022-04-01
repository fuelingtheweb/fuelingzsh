local Sublime = {}
Sublime.__index = Sublime

function Sublime.open(path)
    hs.execute('/usr/local/bin/subl "' .. path .. '"')
    cm.Window.maximizeAfterDelay()
end

return Sublime
