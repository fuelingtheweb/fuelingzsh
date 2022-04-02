local Code = {}
Code.__index = Code

function Code.null()
    if is.lua() then
        ks.type('nil')
    else
        ks.type('null')
    end
end

return Code
