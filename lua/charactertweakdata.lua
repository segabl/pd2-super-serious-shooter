local _presets_original = CharacterTweakData._presets
function CharacterTweakData:_presets(tweak_data, ...)
	local presets = _presets_original(self, tweak_data, ...)

	presets.gang_member_damage.MIN_DAMAGE_INTERVAL = 0.05
	presets.gang_member_damage.REGENERATE_TIME = 2
	presets.gang_member_damage.REGENERATE_TIME_AWAY = 2
	presets.gang_member_damage.hurt_severity.bullet.health_reference = "full"
	presets.gang_member_damage.hurt_severity.bullet.zones = {
		{
			health_limit = StreamHeist and 0 or 0.1,
			light = 1
		},
		{
			health_limit = StreamHeist and 0.05 or 0.15,
			light = 0.5,
			moderate = 0.5
		},
		{
			health_limit = StreamHeist and 0.1 or 0.2,
			moderate = 0.5
		}
	}

	presets.surrender.easy = {
		base_chance = 0,
		significant_chance = -1,
		reasons = {
			pants_down = 0.5,
			weapon_down = 0.35,
			isolated = 0.2
		},
		factors = {
			health = {
				[1.0] = 0,
				[0.0] = 0.75
			},
			aggressor_dis = {
				[100] = 0.15,
				[1000] = 0
			}
		}
	}
	presets.surrender.normal = {
		base_chance = 0,
		significant_chance = -1,
		reasons = {
			pants_down = 0.45,
			weapon_down = 0.25,
			isolated = 0.15
		},
		factors = {
			health = {
				[0.75] = 0,
				[0.0] = 0.5
			},
			aggressor_dis = {
				[100] = 0.1,
				[1000] = 0
			}
		}
	}
	presets.surrender.hard = {
		base_chance = 0,
		significant_chance = -1,
		reasons = {
			pants_down = 0.4,
			weapon_down = 0.15,
			isolated = 0.1
		},
		factors = {
			health = {
				[0.5] = 0,
				[0.0] = 0.25
			},
			aggressor_dis = {
				[100] = 0.05,
				[1000] = 0
			}
		}
	}

	for _, preset in pairs(presets.weapon) do
		for _, weapon in pairs(preset) do
			weapon.use_laser = nil
		end
	end

	return presets
end

SuperSeriousShooter:difficulty_tweak(CharacterTweakData, function(self)
	local diff_i = self.tweak_data:difficulty_to_index(Global.game_settings and Global.game_settings.difficulty or "normal")
	self.presets.gang_member_damage.HEALTH_INIT = 32 + (diff_i ^ 2) * 2

	self.biker_boss.HEALTH_INIT = 300
	self.biker_boss.player_health_scaling_mul = 1.25
	self.chavez_boss.HEALTH_INIT = 300
	self.chavez_boss.player_health_scaling_mul = 1.25
	self.drug_lord_boss.HEALTH_INIT = 300
	self.drug_lord_boss.player_health_scaling_mul = 1.25
	self.hector_boss.HEALTH_INIT = 300
	self.hector_boss.player_health_scaling_mul = 1.25
	self.mobster_boss.HEALTH_INIT = 300
	self.mobster_boss.player_health_scaling_mul = 1.25
	self.triad_boss.HEALTH_INIT = 300
	self.triad_boss.player_health_scaling_mul = 1.25
	self.deep_boss.HEALTH_INIT = 300
	self.deep_boss.player_health_scaling_mul = 1.25

	self.swat.surrender = self.presets.surrender.normal
	self.heavy_swat.surrender = self.presets.surrender.hard
	self.fbi_swat.surrender = self.presets.surrender.normal
	self.fbi_heavy_swat.surrender = self.presets.surrender.hard
	self.city_swat.surrender = self.presets.surrender.normal
	self.heavy_swat_sniper.surrender = self.presets.surrender.hard

	self.tank_armor_damage_mul = 0.75
	self.tank_glass_damage_mul = 1

	self.flashbang_multiplier = 1

	for _, char_name in pairs(self._enemy_list) do
		local char_tweak = self[char_name]
		if char_tweak and char_tweak.weapon then
			local is_sniper = char_tweak.tags and table.contains(char_tweak, "sniper")
			for _, preset in pairs(char_tweak.weapon) do
				if preset._sss_modified then
				elseif preset.autofire_rounds then
					local autofire = (preset.autofire_rounds[1] + preset.autofire_rounds[2]) / 2
					preset.focus_delay = preset.focus_delay * autofire ^ 0.5
				elseif is_sniper then
					local min_delay = math.max(preset.aim_delay[1], math.map_range_clamped(diff_i, 2, 8, 1, 0.5))
					preset.aim_delay = { min_delay, min_delay * 1.5 }
				end
				preset._sss_modified = true
			end
		end
	end
end)
