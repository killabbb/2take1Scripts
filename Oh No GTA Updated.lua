
local glbls = {}
glbls.ver_text = "Gee-Skid v2.00"
local qk={}
qk.math_abs = math.abs
qk.get_i = script.get_global_i
qk.get_f = script.get_global_f
qk.trigger = script.trigger_script_event

function qk.to_int(_num)
	local first, second = tostring(_num):find('%.')
	if first then
		return tonumber(tostring(_num):sub(1, first-1))
	end
	return second
end

function glbls.team_rgb_int(_pid)
	--local associate_id = qk.get_i(1892703 + 1 + 10 + 2 + (_pid*599)) -- could be used to determine actual ceo/mc, but i cant figure out how to determine if its mc or ceo
	-- qk.get_i(1892703 + 1 + 10 + (_pid*599)) --returns the current tally of ceos or mcs that have been in session when that ceo/mc was made
	if qk.get_i(1892703 + 1 + 10 + (_pid*599)) > -1 then -- iirc the previous org color int shows up if not in org
		return qk.get_i(1892703 + 1 + 10 + 104 + (_pid*599)) --sometimes a player has a org color of -1 (white) even when in a org (briefly)
	end
	return -1
end


function glbls.is_mission_active(_pid)
	return (qk.get_i(1892703 + 1 + 10 + 103 + (_pid*599)) == 8)
end


function glbls.is_pid_otr(_pid)
	return (qk.get_i(2689235 + 1 + 208 + (_pid*453)) == 1)
end

function glbls.get_pid_rank(_pid)
	return (qk.get_i(1853348  + (1 + (_pid * 834)) + 205 + 6) or 0)
end

function glbls.get_pid_kd(_pid)
	return (qk.get_f(1853348  + (1 + (_pid * 834)) + 205 + 26) or 0)
end

function glbls.get_pid_total_money(_pid)
	local val = qk.get_i(1853348  + (1 + (_pid * 834)) + 205 + 56)
	if val == nil then
		return 0
	end
	-- local function getUint32(val) -- need to test proddy code....doesnt seem to show anumber highher than 2,147,483,647
		return val & 0xffffffff
	-- end
	--return qk.math_abs(val) --gta reports a lot of money as a negative
end

function glbls.get_pid_veh(_pid)
	return qk.get_i(2703735  + 1 + 173 + (_pid * 1))
end

function glbls.kick_from_veh(_pid)
	qk.trigger(-714268990, _pid, {0, 4294967295, 4294967295, 4294967295})
end

function glbls.send_to_cayo(_pid)
	qk.trigger(1361475530, _pid, {1, 1})
end

function glbls.give_bounty(_pid,_val)
	for i = 0, 31 do
		qk.trigger(1915499503, i, {69, _pid, 1, _val, 0, 1,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, qk.get_i(1920255 + 9), qk.get_i(1920255 + 10)})
	end
end

function glbls.drone_emp(trgt_pid,blame_pid)
	qk.trigger(-1427892428, trgt_pid, {blame_pid, qk.to_int(player.get_player_coords(trgt_pid).x), qk.to_int(player.get_player_coords(trgt_pid).y), qk.to_int(player.get_player_coords(trgt_pid).z), 0})
end

function glbls.remove_wanted(_pid)
	qk.trigger(-1388926377, _pid, {_pid, 125033661})
end

return glbls