local Atom = {}
Atom.__index = Atom

function Atom.open(path)
    hs.execute('/usr/local/bin/atom "' .. path .. '"')
    cm.Window.maximizeAfterDelay()
end

return Atom
