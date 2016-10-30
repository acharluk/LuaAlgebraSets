--- @class Set
--
local Set = {}
Set.__mt = {

    --- @brief
    __tostring = function(set1)
        local str = "{ "
        for _, v in ipairs(set1.data) do
            str = str .. tostring(v) .. ","
        end
        str = str:sub(1, #str-1) .. " }"
        return str
    end
}

function Set:new(...)
    local args = {...}

    local data = {}
    for i, v in ipairs(args) do
        if type(v) == "table" then
            if getmetatable(v) == Set.__mt then
                data[i] = v
            else
                data[i] = Set:new(table.unpack(v))
            end
        else
            data[i] = v
        end
    end

    local obj = setmetatable({data = data}, Set.__mt)
    return obj
end

return Set