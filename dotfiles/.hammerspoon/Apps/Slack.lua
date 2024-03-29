local Slack = {}
Slack.__index = Slack

function Slack.openChannel(channel)
    hs.urlevent.openURL('slack://channel?' .. channel)
end

function Slack.react(emoji)
    ks.slow().key('r')

    if emoji then
        ks.type(emoji)
        hs.timer.doAfter(0.5, function()
            ks.slow().enter()
        end)
    end
end

return Slack
