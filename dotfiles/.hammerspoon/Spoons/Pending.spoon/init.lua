local Pending = {}
Pending.__index = Pending

Pending.pressed = 0
Pending.callbacks = nil
Pending.delay = 0.17
Pending.timer = hs.timer.new(Pending.delay, function()
    Pending.trigger()
end)

function Pending.increment()
    Pending.pressed = Pending.pressed + 1
end

function Pending.restartTimer()
    Pending.timer:setNextTrigger(Pending.delay)
end

function Pending.trigger()
    Pending.callbacks[Pending.pressed]()
    Pending.reset()
end

function Pending.reset()
    Pending.stopTimer()
    Pending.pressed = 0
end

function Pending.stopTimer()
    Pending.timer:stop()
end

function Pending.run(callbacks)
    Pending.stopTimer()

    Pending.increment()
    Pending.callbacks = callbacks

    Pending.restartTimer()
end

return Pending
