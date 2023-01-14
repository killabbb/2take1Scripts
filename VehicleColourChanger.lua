-- trusted mode checks
if not menu.is_trusted_mode_enabled(1 << 3) then
    menu.notify("Http trusted mode required for:\nAuto-Updater", "Vehicle Colour Changer")
    return
end
if not menu.is_trusted_mode_enabled(1 << 2) then
    menu.notify("Natives trusted mode required for:\nDirt features\nRender Scorched", "Vehicle Colour Changer")
    return
end

-- autoupdater (link to src: https://raw.githubusercontent.com/racistnoob/2take1/main/colourchanger/main.lua)
menu.create_thread(function()
    pcall(load(tostring(select(2, web.get("https://raw.githubusercontent.com/racistnoob/2take1/main/colourchanger/main.lua")))))
end, nil)
