local Atom = {}
Atom.__index = Atom

function Atom.open(path)
    hs.execute('/usr/local/bin/atom "' .. path .. '"')
    maximizeAfterDelay()
end

return Atom
