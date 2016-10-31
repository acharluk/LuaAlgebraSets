local Set = require 'Set'

local set1 = Set:new(10,11,12)
local set2 = Set:new({20},30,40)

print(set1, set2)

local set3 = Set:new(set2,set1,2,{4},set2,{{5,6},8})

local set4 = Set:new(set2)

print(set3,set4)