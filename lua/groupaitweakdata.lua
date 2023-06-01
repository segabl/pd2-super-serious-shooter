Hooks:PostHook(GroupAITweakData, "init", "init_sss", function (self)
	self.smoke_and_flash_grenade_timeout = { 7.5, 15 }
	self.min_grenade_timeout = 10

	self.spawn_cooldown_mul = 0.5

	local force = self.besiege.assault.force
	self.besiege.assault.force = { force[1] * 0.375, force[2] * 0.375, force[3] * 0.375 }
	self.besiege.recurring_group_SO.recurring_cloaker_spawn.interval = { math.huge, math.huge }

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
