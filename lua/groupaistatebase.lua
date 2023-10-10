local function register_special_types(gstate)
	gstate._special_unit_types.sniper = true
end

Hooks:PostHook(GroupAIStateBase, "_init_misc_data", "_init_misc_data_sss", register_special_types)
Hooks:PostHook(GroupAIStateBase, "on_simulation_started", "on_simulation_started_sss", register_special_types)

function GroupAIStateBase:has_room_for_police_hostage()
	return not self:get_assault_mode() and self._police_hostage_headcount + table.size(self._converted_police) < 4 or false
end

function GroupAIStateBase:_process_recurring_grp_SO() end
