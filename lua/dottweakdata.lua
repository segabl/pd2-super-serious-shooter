Hooks:PostHook(DOTTweakData, "init", "init_sss", function (self)
	for k, v in pairs(self.dot_entries.poison) do
		v.dot_damage = (k:match("_cloud$") and 30 or 3) / v.dot_length
		v.hurt_animation_chance = 0.25
		v.dot_tick_period = 1
	end
end)
