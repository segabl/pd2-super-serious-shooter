Hooks:PostHook(WeaponFactoryTweakData, "init", "init_sss", function (self)
	self.parts.wpn_fps_upg_a_slug.stats.damage = -50
	self.parts.wpn_fps_upg_a_slug.custom_stats.ammo_pickup_min_mul = 0.35
	self.parts.wpn_fps_upg_a_slug.custom_stats.ammo_pickup_max_mul = 0.35

	self.parts.wpn_fps_upg_a_custom.custom_stats.rays = 6
	self.parts.wpn_fps_upg_a_custom_free.custom_stats.rays = 6

	self.parts.wpn_fps_upg_a_explosive.stats.damage = -50
	self.parts.wpn_fps_upg_a_explosive.custom_stats.ammo_pickup_min_mul = 0
	self.parts.wpn_fps_upg_a_explosive.custom_stats.ammo_pickup_max_mul = 0

	self.parts.wpn_fps_upg_a_piercing.custom_stats.ammo_pickup_min_mul = 0.35
	self.parts.wpn_fps_upg_a_piercing.custom_stats.ammo_pickup_max_mul = 0.35

	self.parts.wpn_fps_upg_a_dragons_breath.stats.damage = -20
	self.parts.wpn_fps_upg_a_dragons_breath.custom_stats.ammo_pickup_min_mul = 0
	self.parts.wpn_fps_upg_a_dragons_breath.custom_stats.ammo_pickup_max_mul = 0

	self.parts.wpn_fps_upg_a_rip.stats.damage = -20
	self.parts.wpn_fps_upg_a_rip.custom_stats.rays = 6
	self.parts.wpn_fps_upg_a_rip.custom_stats.ammo_pickup_min_mul = 0
	self.parts.wpn_fps_upg_a_rip.custom_stats.ammo_pickup_max_mul = 0
end)
