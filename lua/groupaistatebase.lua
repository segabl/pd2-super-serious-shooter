local function register_special_types(gstate)
	gstate._special_unit_types.sniper = true
end

Hooks:PostHook(GroupAIStateBase, "_init_misc_data", "_init_misc_data_sss", register_special_types)
Hooks:PostHook(GroupAIStateBase, "on_simulation_started", "on_simulation_started_sss", register_special_types)
