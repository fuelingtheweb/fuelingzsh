local Sublime = {}
Sublime.__index = Sublime

function Sublime.open(path)
    hs.execute('/usr/local/bin/subl "' .. path .. '"')
    maximizeAfterDelay()
end

return Sublime
