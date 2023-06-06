Hooks:PostHook(LootDropTweakData, "init", "init_sss", function (self)
	self.global_values.super_serious_shooter_weapon = {
		name_id = "bm_menu_sss_weapon_locked",
		unlock_id = "bm_menu_sss_weapon_locked",
		color = Color(255, 255, 51, 51) / 255,
		dlc = true,
		chance = 1,
		value_multiplier = 1,
		durability_multiplier = 1,
		drops = true,
		track = false,
		sort_number = 100,
		unique_lock_icon = "guis/textures/pd2/blackmarket/important_lock",
		unique_lock_color = Color(255, 255, 51, 51) / 255
	}
	self.global_values.super_serious_shooter_part = clone(self.global_values.super_serious_shooter_weapon)
	self.global_values.super_serious_shooter_part.name_id = "bm_menu_sss_part_locked"
	self.global_values.super_serious_shooter_part.unlock_id = "bm_menu_sss_part_locked"
end)
