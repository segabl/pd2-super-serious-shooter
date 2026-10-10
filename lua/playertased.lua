Hooks:PreHook(PlayerTased, "_check_action_shock", "_check_action_shock_sss", function(self, t)
	if not self._fatal_delayed_clbk or not self._next_shock or t <= self._next_shock or not self._unit:character_damage().damage_health then
		return
	end

	self._unit:character_damage():damage_health({
		damage = 0.02,
		is_percentage = true
	})
end)
