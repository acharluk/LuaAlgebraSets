local Set = require 'Set'

local set1 = Set:new(10,11,12)
local set2 = Set:new({20},30,40)

print(set1, set2)

local set3 = Set:new(set2,2,{4},set1,{{5,6},8})

local set4 = Set:new(set2)

print("\n\n",set3,"\n",set4,"\n\n")

print("Union: ", set3 | set4)

