local filter = {
	"gtagta.cc",
	--[[
	You can add more blacklisted phrases here, separated by commas
	--]]
}

local f = function(s)
	for k,v in pairs(filter) do
		if s:find(v) then
			return true
		end
	end
	return false
end

event.add_event_listener("chat", function(e)
	if f(e.body) then
		--menu.notify("kick")
		network.force_remove_player(e.sender)
	end
end)

hook.register_script_event_hook(function(source, target, params, count)
	if #params < 3 then
		return
	end
	
	if (params[1] & 0xFFFFFFFF) ~= 0x6396E29C then
		return
	end
	
	local t = {}
	table.move(params, 3, #params, 1, t)
	local s = utils.vecu64_to_str(t)

	if f(s) then
		--menu.notify("kick")
		network.force_remove_player(source)
	end
end)
