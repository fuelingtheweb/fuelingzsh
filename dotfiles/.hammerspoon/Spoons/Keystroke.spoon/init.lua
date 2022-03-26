local Keystroke = {}
Keystroke.__index = Keystroke

ks = Keystroke

function Keystroke.escape() Keystroke.key('escape') end

function Keystroke.shift(key) Keystroke.fire({'shift'}, key) end
function Keystroke.shiftCtrl(key) Keystroke.fire({'shift', 'ctrl'}, key) end
function Keystroke.shiftCtrlAlt(key)
    Keystroke.fire({'shift', 'ctrl', 'alt'}, key)
end
function Keystroke.shiftAlt(key) Keystroke.fire({'shift', 'alt'}, key) end
function Keystroke.shiftAltCmd(key) Keystroke.fire({'shift', 'alt', 'cmd'}, key) end
function Keystroke.shiftCmd(key) Keystroke.fire({'shift', 'cmd'}, key) end
function Keystroke.ctrl(key) Keystroke.fire({'ctrl'}, key) end
function Keystroke.ctrlAlt(key) Keystroke.fire({'ctrl', 'alt'}, key) end
function Keystroke.ctrlCmd(key) Keystroke.fire({'ctrl', 'cmd'}, key) end
function Keystroke.super(key) Keystroke.fire({'ctrl', 'alt', 'cmd'}, key) end
function Keystroke.alt(key) Keystroke.fire({'alt'}, key) end
function Keystroke.altCmd(key) Keystroke.fire({'alt', 'cmd'}, key) end
function Keystroke.cmd(key) Keystroke.fire({'cmd'}, key) end
function Keystroke.key(key) Keystroke.fire({}, key) end
function Keystroke.solo(key) Keystroke.fire({}, key) end

function Keystroke.fire(modifiers, key)
    if type(modifiers) == 'string' then
        key = modifiers
        modifiers = {}
    end

    hs.eventtap.keyStroke(modifiers, key, Keystroke.delay)

    Keystroke.reset()
end

function Keystroke.slow(delay)
    Keystroke.delay = delay or nil

    return Keystroke
end

function Keystroke.reset() Keystroke.delay = 0 end

Keystroke.reset()

return Keystroke
