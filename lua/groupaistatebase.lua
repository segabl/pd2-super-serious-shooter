local function register_special_types(gstate)
	gstate._special_unit_types.sniper = true
end

Hooks:PostHook(GroupAIStateBase, "_init_misc_data", "_init_misc_data_sss", register_special_types)
Hooks:PostHook(GroupAIStateBase, "on_simulation_started", "on_simulation_started_sss", register_special_types)

function GroupAIStateBase:has_room_for_police_hostage()
	local task_data = self._task_data.assault
	local is_assault = task_data.active and task_data.phase ~= "fade" and task_data.phase ~= "anticipation"
	return not is_assault and self._police_hostage_headcount < 4 or false
end

function GroupAIStateBase:_process_recurring_grp_SO() end
