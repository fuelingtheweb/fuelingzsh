local Code = {}
Code.__index = Code

function Code.run(name)
    ks.slow().shiftCmd('p').type(name)
    hs.timer.doAfter(0.3, ks.enter)
end

function Code.openFile(file)
    ks.slow().cmd('t').type(file)
    hs.timer.doAfter(0.3, ks.enter)
end

function Code.open(path)
    hs.execute('/usr/local/bin/code "' .. path:gsub('~', '/Users/nathan') .. '"')
    cm.Window.maximizeAfterDelay()
end

return Code
