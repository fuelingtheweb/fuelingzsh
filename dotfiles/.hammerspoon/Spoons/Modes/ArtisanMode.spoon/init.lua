local ArtisanMode = {}
ArtisanMode.__index = ArtisanMode

ArtisanMode.lookup = {
    y = nil,
    u = nil,
    i = nil,
    o = nil,
    p = nil,
    open_bracket = nil,
    close_bracket = nil,
    h = nil,
    j = nil,
    k = nil,
    l = nil,
    semicolon = nil,
    quote = nil,
    return_or_enter = nil,
    n = 'migrateFreshAndSeed',
    m = nil,
    comma = nil,
    period = nil,
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

function ArtisanMode.handle(key)
    if ArtisanMode.lookup[key] then
        ArtisanMode[ArtisanMode.lookup[key]]()
    end
end

function ArtisanMode.migrateFreshAndSeed()
    typeAndEnter('amgfs')
end

return ArtisanMode
