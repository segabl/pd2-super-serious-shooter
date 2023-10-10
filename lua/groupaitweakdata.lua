Hooks:PostHook(GroupAITweakData, "init", "init_sss", function (self)
	self.smoke_and_flash_grenade_timeout = { 7.5, 15 }
	self.min_grenade_timeout = 10

	local force = self.besiege.assault.force
	self.besiege.assault.force = { force[1] * 0.35, force[2] * 0.35, force[3] * 0.35 }
	self.besiege.recurring_group_SO.recurring_cloaker_spawn.interval = { math.huge, math.huge }

	for special in pairs(self.special_unit_spawn_limits) do
		self.special_unit_spawn_limits[special] = special == "shield" and 2 or 0
	end

	for _, group in pairs(self.enemy_spawn_groups) do
		for _, data in pairs(group.spawn) do
			if self.unit_categories[data.unit].special_type ~= nil then
				data.amount_max = 1
				data.amount_min = math.min(data.amount_max, data.amount_min or 0)
			end
		end
	end

	self.enemy_spawn_groups.marshal_squad = nil

	self.phalanx.spawn_chance.start = 0
	self.phalanx.spawn_chance.increase = 0
	self.phalanx.spawn_chance.max = 0
end)
