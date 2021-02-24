local Pending = {}
Pending.__index = Pending

Pending.pressed = 0
Pending.timer = nil

function Pending.increment()
    Pending.pressed = Pending.pressed + 1
end

function Pending.newTimer(callback)
    Pending.stopTimer()
    Pending.timer = hs.timer.doAfter(0.2, function()
        Pending.trigger(callback)
    end)
end

function Pending.trigger(callback)
    Pending.reset()
    callback()
end

function Pending.reset()
    Pending.stopTimer()
    Pending.pressed = 0
end

function Pending.stopTimer()
    if Pending.timer and Pending.timer:running() then
        Pending.timer:stop()
    end
end

function Pending.run(callbacks)
    local count = countTable(callbacks)

    Pending.increment()

    each(callbacks, function(callback, index)
        if Pending.pressed ~= index then
            return
        end

        if index == count then
            return Pending.trigger(callback)
        end

        Pending.newTimer(callback)
    end)
end

return Pending
