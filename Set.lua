--- @class Set
--
local Set = {}
Set.__mt = {
    __index = Set,
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

    if #args == 1 and getmetatable(args[1]) == Set.__mt then
       args = args[1].data
    end

    for _, v in ipairs(args) do
        if type(v) == "table" then
            if getmetatable(v) == Set.__mt then
                table.insert(data, Set:new(v))
            else
                table.insert(data, Set:new(table.unpack(v)))
            end
        else
            table.insert(data, v)
        end
    end

    local obj = setmetatable({data = data}, Set.__mt)
    return obj
end

function Set:asTable()
    local result = {}
    for _, v in ipairs(self.data) do
        if type(v) == "number" then
            table.insert(result, v)
        else
            table.insert(result, v:asTable())
        end
    end
    return result
end

return Set