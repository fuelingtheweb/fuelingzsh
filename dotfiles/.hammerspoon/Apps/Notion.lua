local Notion = {}
Notion.__index = Notion

function Notion.openPage(name)
    ks.slow().cmd('p').type(name)
    hs.timer.doAfter(0.3, ks.enter)
end

return Notion
