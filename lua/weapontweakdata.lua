Hooks:PostHook(WeaponTweakData, "init", "init_sss", function (self, tweak_data)
	self.tweak_data = tweak_data

	local function kick_standing(val)
		return val * 1.25
	end
	local function kick_crouching(val)
		return val * 1
	end
	local function kick_steelsight(val)
		return val * 0.75
	end

	for _, v in pairs(self) do
		if type(v) == "table" and v.autohit then
			local c = table.list_to_set(v.categories)
			if c.flamethrower or c.minigun or c.grenade_launcher or c.bow or c.crossbow or c.akimbo and (not c.pistol or c.revolver) then
				v.AMMO_PICKUP = { 0, 0 }
				v.unlock_func = "super_serious_shooter"
				v.global_value = "super_serious_shooter_weapon"
			end

			if v.spread then
				v.spread.standing = 3
				v.spread.crouching = 2
				v.spread.steelsight = 1.5
				v.spread.moving_standing = 4
				v.spread.moving_crouching = 3
				v.spread.moving_steelsight = 1.5
			end

			if v.kick then
				local standing = v.kick.standing
				v.kick.standing = table.collect(standing, kick_standing)
				v.kick.crouching = table.collect(standing, kick_crouching)
				v.kick.steelsight = table.collect(standing, kick_steelsight)
			end
		end
	end

	self.sentry_gun.BAG_DMG_MUL = 1

	self.m14_sniper_npc.trail = "effects/particles/weapons/sniper_trail"
	self.svd_snp_npc.trail = "effects/particles/weapons/sniper_trail"
	self.svdsil_snp_npc.trail = "effects/particles/weapons/sniper_trail"
	self.heavy_snp_npc.trail = "effects/particles/weapons/sniper_trail"
	self.dmr_npc.trail = "effects/particles/weapons/sniper_trail"
end)

SuperSeriousShooter:difficulty_tweak(WeaponTweakData, function (self)
	local diff_i = self.tweak_data:difficulty_to_index(Global.game_settings and Global.game_settings.difficulty or "normal")
	local turret_damage_mul = {
		{ 0, 1 },
		{ 1500, 0.5 },
		{ 3000, 0.1 },
		{ 10000, 0 }
	}
	for weap_id, weap_data in pairs(self) do
		if weap_id:match("_turret_module") then
			weap_data.auto.fire_rate = 0.1
			weap_data.SPREAD = 10
			weap_data.DAMAGE = diff_i * 0.5
			weap_data.DAMAGE_MUL_RANGE = turret_damage_mul
			weap_data.HEALTH_INIT = 2000
			weap_data.SHIELD_HEALTH_INIT = 200
			weap_data.CLIP_SIZE = 300
			weap_data.BAG_DMG_MUL = 20
			weap_data.SHIELD_DMG_MUL = 1
			weap_data.FIRE_DMG_MUL = 1
			weap_data.EXPLOSION_DMG_MUL = 1
			weap_data.AUTO_REPAIR = nil
			weap_data.SHIELD_DAMAGE_CLAMP = nil
			weap_data.BODY_DAMAGE_CLAMP = nil
		end
	end
end)
