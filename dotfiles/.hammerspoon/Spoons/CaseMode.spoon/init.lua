local CaseMode = {}
CaseMode.__index = CaseMode

CaseMode.lookup = {
    y = 'to=upperFirst&key=y',
    u = 'to=upper&key=u',
    i = 'to=constant&key=i',
    o = 'to=kebab&key=o',
    p = 'to=pascal&key=p',
    h = 'to=title&key=h',
    j = 'to=sentence&key=j',
    k = 'to=snake&key=k',
    l = 'to=lower&key=l',
    m = 'to=camel&key=m',
    period = 'to=dot&key=.',
    slash = 'to=path&key=/',
}

function CaseMode.handle(key)
    if CaseMode.lookup[key] then
        hs.execute("open -g 'hammerspoon://case-change?" .. CaseMode.lookup[key] .. "'")
    end
end

return CaseMode
