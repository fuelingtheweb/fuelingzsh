local Discord = {}
Discord.__index = Discord

function Discord.openChannel(name)
    ks.slow().cmd('k').type(name)
    hs.timer.doAfter(0.1, ks.enter)
end

return Discord
