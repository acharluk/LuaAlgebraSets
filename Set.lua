--- @class Set
--
local Set = {}
Set.__mt = {
    __index = Set,

    __bor = function(set1, set2)
        return set1:union(set2)
    end,
    __band = function(set1, set2)
        return set1:intersection(set2)
    end,

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

function Set:union(other)
    local result = self:asTable()

    for _, v in pairs(other.data) do
        local copy = true
        for _, v1 in pairs(result) do
            if v == v1 then copy = false end
        end

        if copy then
            table.insert(result, v)
        end
    end

    return Set:new(table.unpack(result))
end

function Set:intersection(other)
    -- WIP -> __eq
end

function Set:intersection(other)
    local result = {}

    for _, v in pairs(self.data) do
       for _, v1 in pairs(other.data) do
           if v == v1 then
               table.insert(result, v)
           end
       end
    end

    return Set:new(table.unpack(result))
end

return Set