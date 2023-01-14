local instantSellDraw = function(feat)
    local pos = v2()
    local global = 262145

    local hash = gameplay.get_hash_key("gb_contraband_sell")

    --[[
    pos.y = pos.y + 0.02
    d3d.draw_text("local " .. tostring(script.get_local_i(hash, 540 + 7)), pos, v2(), 1.0, 0xFF0000FF, 5)
    pos.y = pos.y + 0.02
    d3d.draw_text("local " .. tostring(script.get_local_i(hash, 540 + 1)), pos, v2(), 1.0, 0xFF0000FF, 5)
    ]]

    -- Instantly sell
    pos.y = pos.y + 0.02
    d3d.draw_text("set local " .. tostring(script.set_local_i(hash, 540 + 7, 7)), pos, v2(), 1.0, 0xFF0000FF, 5)
    pos.y = pos.y + 0.02
    d3d.draw_text("set local " .. tostring(script.set_local_i(hash, 540 + 1, 67230)), pos, v2(), 1.0, 0xFF0000FF, 5)

    if feat.on then
        return HANDLER_CONTINUE
    end
end

local instantBuyDraw = function(feat)
    local pos = v2()
    local global = 262145
    
    
    --x = script.get_global_i(global + crates[i])

    local hash = gameplay.get_hash_key("gb_contraband_buy")

    script.set_local_i(hash, 598 + 5, 1)
    script.set_local_i(hash, 598 + 1, 3) -- Number of crates
    script.set_local_i(hash, 598 + 191, 6)
    script.set_local_i(hash, 598 + 192, 4)

    if feat.on then
        return HANDLER_CONTINUE
    end
end

local removeCoolDown = function(feat)
    local global = 262145
    -- Set cooldown
    script.set_global_i(global + 15553, 1) -- Buy CD 300000
    script.set_global_i(global + 15554, 1) -- Sell CD 1800000

    if feat.on then
        return HANDLER_CONTINUE
    end
end

local crates = {
    [15788] = 1;
    [15789] = 2;
    [15790] = 3;
    [15791] = 5;
    [15792] = 7;
    [15793] = 9;
    [15794] = 14;
    [15795] = 19;
    [15796] = 24;
    [15797] = 29;
    [15798] = 34;
    [15799] = 39;
    [15800] = 44;
    [15801] = 49;
    [15802] = 59;
    [15803] = 69;
    [15804] = 79;
    [15805] = 89;
    [15806] = 99;
    [15807] = 110;
    [15808] = 111;
}

local increasePrices = function(feat)
    local pos = v2()
    local global = 262145
    
    for k, v in pairs(crates) do
        script.set_global_i(global + k, math.floor(4000000 / v))
    end

    --[[for i = 1, #crates do
        local x = script.get_global_i(global + crates[i])
        local newValue = math.floor(3000000 / i)
        d3d.draw_text("crate " .. i .. ":  " .. tostring(x) .. " | " .. newValue, pos, v2(), 1.0, 0xFF0000FF, 5)
        script.set_global_i(global + crates[i], newValue)
        x = script.get_global_i(global + crates[i])
        pos.y = pos.y + 0.02
        d3d.draw_text("crate " .. i .. ":  " .. tostring(x), pos, v2(), 1.0, 0xFF0000FF, 5)
        pos.y = pos.y + 0.02
    end]]

    if feat.on then
        return HANDLER_CONTINUE
    end
end

menu.add_feature("instantSell", "toggle", 0, nil).renderer = instantSellDraw
menu.add_feature("instantBuy", "toggle", 0, nil).renderer = instantBuyDraw
menu.add_feature("remove cooldown", "toggle", 0, nil).renderer = removeCoolDown
menu.add_feature("increasePrices", "toggle", 0, nil).renderer = increasePrices
