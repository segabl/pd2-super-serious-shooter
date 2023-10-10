Hooks:PostHook(CarryTweakData, "init", "init_sss", function (self)
	for _, v in pairs(self.types) do
		v.can_run = true
		v.jump_modifier = v.move_speed_modifier ^ 0.5
	end
end)
