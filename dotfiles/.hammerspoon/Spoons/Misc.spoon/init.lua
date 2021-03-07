local obj = {}
obj.__index = obj

hs.urlevent.bind('misc-optionPressedOnce', function()
    if appIs(spotify) then
        spoon.WindowManager.next()
    else
        spoon.MediaMode.showVideoBar()
    end
end)

hs.urlevent.bind('misc-optionPressedTwice', function()
    app = hs.application.get(spotify)

    if app and app:isRunning() then
        app:activate()
    end
end)

return obj
