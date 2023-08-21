Hooks:PostHook(UpgradesTweakData, "init", "init_sss", function (self)
	self.sentry_gun_base_armor = 50

	self.values.player.body_armor.damage_shake[1] = 1
	self.values.player.body_armor.damage_shake[2] = 0.9
	self.values.player.body_armor.damage_shake[3] = 0.8
	self.values.player.body_armor.damage_shake[4] = 0.7
	self.values.player.body_armor.damage_shake[5] = 0.6
	self.values.player.body_armor.damage_shake[6] = 0.5
	self.values.player.body_armor.damage_shake[7] = 0.4

	self.weapon_movement_penalty.lmg = 0.8
	self.weapon_movement_penalty.minigun = 0.8
end)
