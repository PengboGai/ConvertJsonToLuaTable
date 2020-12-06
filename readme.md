## An lua Funciton Convert Json File To Lua Table 
example:
A json file: jsonfile.json with content {a=1}
pass the file name to the funtion, then you will get the json file content: A LUA TABLE

local luatable = convertJsonToLuaTable("jsonfile.json")
print(luatable.a) -- will print 1