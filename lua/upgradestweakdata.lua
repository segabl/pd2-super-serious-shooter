Hooks:PostHook(UpgradesTweakData, "init", "init_sss", function (self)
	self.sentry_gun_base_armor = 50

	for i in ipairs(self.values.player.body_armor.armor) do
		self.values.player.body_armor.armor[i] = 3 * (i - 1)
	end

	for i in ipairs(self.values.player.body_armor.movement) do
		self.values.player.body_armor.movement[i] = 1.2 - 0.1 * (i - 1)
	end

	for i in ipairs(self.values.player.body_armor.concealment) do
		self.values.player.body_armor.concealment[i] = 30 - 4 * (i - 1)
	end

	for i in ipairs(self.values.player.body_armor.dodge) do
		self.values.player.body_armor.dodge[i] = 0.15 - 0.05 * (i - 1)
	end

	for i in ipairs(self.values.player.body_armor.damage_shake) do
		self.values.player.body_armor.damage_shake[i] = 1 - 0.1 * (i - 1)
	end

	for i in ipairs(self.values.player.body_armor.stamina) do
		self.values.player.body_armor.stamina[i] = 1 - 0.05 * (i - 1)
	end

	self.weapon_movement_penalty.lmg = 0.85
	self.weapon_movement_penalty.minigun = 0.75
end)
