local function register_special_types(gstate)
	gstate._special_unit_types.sniper = true
end

Hooks:PostHook(GroupAIStateBase, "_init_misc_data", "_init_misc_data_sss", register_special_types)
Hooks:PostHook(GroupAIStateBase, "on_simulation_started", "on_simulation_started_sss", register_special_types)

local has_room_for_police_hostage_original = GroupAIStateBase.has_room_for_police_hostage
function GroupAIStateBase:has_room_for_police_hostage(...)
	return not self:get_assault_mode() and has_room_for_police_hostage_original(self, ...) or false
end
