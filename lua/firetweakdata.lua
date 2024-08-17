Hooks:PostHook(FireTweakData, "init", "init_sss", function (self)
	for k, v in pairs(self.dot_entries.fire) do
		v.dot_damage = (k:match("^proj_") and 30 or 3) / v.dot_length
		v.dot_trigger_chance = k:match("^proj_") and 1 or 0.25
		v.dot_tick_period = 1
	end
end)
