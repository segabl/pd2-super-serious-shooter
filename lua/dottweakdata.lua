Hooks:PostHook(DOTTweakData, "init", "init_sss", function (self)
	for k, v in pairs(self.dot_entries.poison) do
		v.dot_damage = (k:match("^ammo_") and 3 or 30) / v.dot_length
		v.hurt_animation_chance = 0.25
		v.dot_tick_period = 1
	end
end)
