-- author Pengbo Gai
-- date：2020/12/06
-- read a json file to lua table with one lua function
-- example
-- local jsonConfigTable = convertJsonToLuaTable(configJsonPath)
-- then do anything with jsonConfigTable just like a normal lua table

local convertJsonToLuaTable = function(file_name)
    local f, err = io.open(file_name, "r")
    local lineIterator = f:lines()
    local fileContent = ""
    local replace2quote = function(str)
        local returnStr = ""
        local equalIndex = str:find("=")

        if not equalIndex then
            return str
        end
        local index = 1
        local charIndex = str:find('"', index)
        while charIndex and charIndex < equalIndex do
            returnStr = returnStr .. str:sub(index, charIndex - 1)
            index = charIndex + 1
            charIndex = str:find('"', index)
        end
        if returnStr:len() > 0 then
            returnStr = returnStr .. str:sub(index, str:len())
        else
            returnStr = str
        end
        return returnStr
    end
    local haslines = true
    while haslines do
        local str = lineIterator()
        if str then
            str = string.gsub(str, ":", "=")
            str = replace2quote(str)
            fileContent = fileContent .. str
        end
        haslines = str
    end
    fileContent = "return " .. fileContent
    local jsonConfig = nil
    if loadstring then 
        jsonConfig = loadstring(fileContent)() 
    else
        jsonConfig = load(fileContent)()
    end
    return jsonConfig
end


