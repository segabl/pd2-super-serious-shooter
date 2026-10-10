Hooks:PreHook(PlayerMovement, "on_SPOOCed", "on_SPOOCed_sss", function(self)
	if not self._unit:character_damage().damage_health then
		return
	end

	self._unit:character_damage():damage_health({
		damage = 0.2,
		is_percentage = true
	})
end)
