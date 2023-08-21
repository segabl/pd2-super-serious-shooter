Hooks:PostHook(WeaponFactoryTweakData, "init", "init_sss", function (self)
	self.parts.wpn_fps_upg_a_explosive.global_value = "super_serious_shooter_part"
	self.parts.wpn_fps_upg_a_dragons_breath.global_value = "super_serious_shooter_part"
	self.parts.wpn_fps_upg_a_rip.global_value = "super_serious_shooter_part"
	self.parts.wpn_fps_lmg_kacchainsaw_flamethrower.global_value = "super_serious_shooter_part"

	self.parts.wpn_fps_upg_a_slug.stats.total_ammo_mod = -5
	self.parts.wpn_fps_upg_a_slug.custom_stats.ammo_pickup_min_mul = 0.3
	self.parts.wpn_fps_upg_a_slug.custom_stats.ammo_pickup_max_mul = 0.3

	self.parts.wpn_fps_upg_a_custom.custom_stats.rays = 6
	self.parts.wpn_fps_upg_a_custom_free.custom_stats.rays = 6
end)
