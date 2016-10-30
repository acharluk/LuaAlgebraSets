--- @class Set
--
local Set = {}
Set.__mt = {
}

function Set:new(...)
    local data = {...}
    local obj = setmetatable({data = data}, Set.__mt)
    return obj
end

return Set