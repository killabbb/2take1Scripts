local modulesParent = menu.add_feature("Script Repository", "parent", 0)

local function downloadModule(moduleName, moduleLink)
    local responseCode, list = web.get(moduleLink)

    if responseCode == 200 then
        local file = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Rimuru\\libs\\modules\\"..moduleName..".lua", "wb")
        file:write(""..list)
        file:close()
    end
end

local function executeModule(moduleName)
    local fake_env = setmetatable({}, {__index = _G})
    fake_env.func = setmetatable({}, {__index = func})
    fake_env.menu = setmetatable({}, {__index = menu})

   
    getmetatable(fake_env).__newindex = _G

    assert(loadfile(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\Rimuru\\libs\\modules\\"..moduleName..".lua", "tb", fake_env))()
end

local function getAllModules() 
    menu.create_thread(function()
        local responseCode, list = web.get("https://raw.githubusercontent.com/Rimmuru/Rimurus-2T1-Scripts/main/Rimurus%20Scripts/Modules/moduleList.lua")
        
        if responseCode == 200 then
            local chunk, err = load(list, "https://raw.githubusercontent.com/Rimmuru/Rimurus-2T1-Scripts/main/Rimurus%20Scripts/Modules/moduleList.lua")
            assert(chunk, string.format("Failed to load GitHub file: %s", err))
            local success, result = pcall(chunk)
            assert(success, string.format("Failed to exec GitHub file: %s", result))
            --result is the table
            if success then
                for key, scriptName in pairs(result) do
                    menu.create_thread(function ()
                        menu.add_feature(scriptName.name, "action", modulesParent.id, function()
                            downloadModule(scriptName.name, scriptName.link)
                            executeModule(scriptName.name)
                            menu.notify("Loaded "..scriptName.name.."\nAuthor: "..scriptName.author)
                        end)     
                    end)
                end
            end
        end

    end)
end
getAllModules()
