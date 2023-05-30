Hooks:PostHook(GroupAITweakData, "init", "init_sss", function (self)
	self.min_grenade_timeout = 10

	self.spawn_cooldown_mul = 0.5

	local force = self.besiege.assault.force
	self.besiege.assault.force = { force[1] * 0.375, force[2] * 0.375, force[3] * 0.375 }
	self.besiege.assault.force_balance_mul = { 1, 1.5, 2, 2.5 }
	self.besiege.assault.force_pool_balance_mul = { 1, 1.5, 2, 2.5 }
	self.besiege.recurring_group_SO.recurring_cloaker_spawn.interval = { math.huge, math.huge }

	local enable_reenforce = true
	for _, group in pairs(self.besiege.reenforce.groups) do
		for _, weight in pairs(group) do
			if weight > 0 then
				enable_reenforce = false
				break
			end
		end
		if not enable_reenforce then
			break
		end
	end
	if enable_reenforce then
		self.besiege.reenforce.interval = { 60, 45, 30 }
		self.besiege.reenforce.groups = {
			tac_swat_shotgun_rush = { 1, 1, 1 },
			tac_swat_shotgun_flank = { 1, 1, 1 },
			tac_swat_rifle = { 1, 1, 1 },
			tac_swat_rifle_flank = { 1, 1, 1 }
		}
	end

	self.special_unit_spawn_limits.shield = 2
	self.special_unit_spawn_limits.medic = 0
	self.special_unit_spawn_limits.taser = 0
	self.special_unit_spawn_limits.tank = 0
	self.special_unit_spawn_limits.spooc = 0

	self.enemy_spawn_groups.marshal_squad = nil

	self.phalanx.spawn_chance.start = 0
	self.phalanx.spawn_chance.increase = 0
	self.phalanx.spawn_chance.max = 0
end)
