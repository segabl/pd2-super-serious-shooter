function PlayerBleedOut:_check_change_weapon()
	return false
end

function PlayerBleedOut:_check_action_equip()
	return false
end

local exit_original = PlayerBleedOut.exit
function PlayerBleedOut:exit(...)
	local exit_data = exit_original(self, ...)

	exit_data.equip_weapon = nil

	return exit_data
end
