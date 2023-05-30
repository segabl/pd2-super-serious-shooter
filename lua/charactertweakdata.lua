Hooks:PostHook(CharacterTweakData, "init", "init_sss", function (self)
	self.presets.gang_member_damage.MIN_DAMAGE_INTERVAL = 0.05
	self.presets.gang_member_damage.REGENERATE_TIME = 5
	self.presets.gang_member_damage.REGENERATE_TIME_AWAY = 5
	self.presets.gang_member_damage.hurt_severity.bullet.health_reference = "full"
	self.presets.gang_member_damage.hurt_severity.bullet.zones = {
		{
			health_limit = 0,
			light = 1
		},
		{
			health_limit = 0.1,
			light = 0.5,
			moderate = 0.5
		},
		{
			health_limit = 0.2,
			moderate = 0.5
		}
	}
end)

SuperSeriousShooter:difficulty_tweak(CharacterTweakData, function (self)
	local diff_i = self.tweak_data:difficulty_to_index(Global.game_settings and Global.game_settings.difficulty or "normal")
	self.presets.gang_member_damage.HEALTH_INIT = 40 + (diff_i - 2) * 10

	self.biker_boss.HEALTH_INIT = 400
	self.biker_boss.player_health_scaling_mul = 1.25
	self.chavez_boss.HEALTH_INIT = 400
	self.chavez_boss.player_health_scaling_mul = 1.25
	self.drug_lord_boss.HEALTH_INIT = 400
	self.drug_lord_boss.player_health_scaling_mul = 1.25
	self.hector_boss.HEALTH_INIT = 400
	self.hector_boss.player_health_scaling_mul = 1.25
	self.mobster_boss.HEALTH_INIT = 400
	self.mobster_boss.player_health_scaling_mul = 1.25
	self.triad_boss.HEALTH_INIT = 400
	self.triad_boss.player_health_scaling_mul = 1.25
end)
