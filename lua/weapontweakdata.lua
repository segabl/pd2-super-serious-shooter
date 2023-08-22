Hooks:PostHook(WeaponTweakData, "init", "init_sss", function (self, tweak_data)
	self.tweak_data = tweak_data

	self.lemming.CLIP_AMMO_MAX = 10

	for i = 1, #self.stats.recoil do
		self.stats.recoil[i] = 1 + (#self.stats.recoil - i) * 0.05
	end

	for i = 1, #self.stats.spread do
		self.stats.spread[i] = 0.02 + (#self.stats.spread - i) * 0.08
	end

	local function kick_standing(up, down, left, right)
		return { up * 1.25, down * 1.25, left * 1.25, right * 1.25 }
	end
	local function kick_crouching(up, down, left, right)
		return { up, down, left, right }
	end
	local function kick_steelsight(up, down, left, right)
		return { up * 0.75, down * 0.75, left * 0.75, right * 0.75 }
	end

	for _, v in pairs(self) do
		if type(v) == "table" and v.autohit then
			local c = table.list_to_set(v.categories)
			local dmg = self.stats.damage[math.min(v.stats.damage, #self.stats.damage)] * (v.stats_modifiers and v.stats_modifiers.damage or 1)

			if c.flamethrower or c.minigun or c.grenade_launcher or c.bow or c.crossbow or c.akimbo and (not c.pistol or c.revolver) then
				v.AMMO_PICKUP = { 0, 0 }
				v.unlock_func = "super_serious_shooter"
				v.global_value = "super_serious_shooter_weapon"
			end

			if c.akimbo then
				v.stats.spread = math.max(1, math.floor(v.stats.spread * 0.75))
			end

			if c.shotgun and v.rays then
				v.rays = 8
			end

			if v.can_shoot_through_shield then
				v.NR_CLIPS_MAX = math.max(2, math.floor(15 / math.max(2, v.CLIP_AMMO_MAX)))
				v.AMMO_MAX = v.CLIP_AMMO_MAX * v.NR_CLIPS_MAX
			end

			-- steelsight spread is applied as a multiplier of (1 + 1 - spread) on top of standing or crouching
			if v.spread then
				v.spread.standing = c.snp and 12 or 3
				v.spread.crouching = c.snp and 8 or 2
				v.spread.steelsight = c.snp and 1.875 or 1.5
				v.spread.moving_standing = c.snp and 24 or 4
				v.spread.moving_crouching = c.snp and 18 or 3
				v.spread.moving_steelsight = c.snp and 1.875 or 1.5
			end

			if v.kick then
				local up, down, left, right = unpack(v.kick.standing)
				local sum = math.abs(up) + math.abs(down) + math.abs(left) + math.abs(right)
				if sum > 0 then
					local mul = (dmg ^ 0.2) * 3
					up = (up / sum) * mul
					down = (down / sum) * mul
					left = (left / sum) * mul
					right = (right / sum) * mul
				end
				v.kick.standing = kick_standing(up, down, left, right)
				v.kick.crouching = kick_crouching(up, down, left, right)
				v.kick.steelsight = kick_steelsight(up, down, left, right)
			end

			if v.AMMO_PICKUP and v.AMMO_PICKUP[2] > 0 then
				local ref = (dmg ^ 1.2) * (v.can_shoot_through_shield and 3 or 1) * (v.rays and 2 or 1)
				if c.flamethrower then
					ref = ref * 3
				elseif c.grenade_launcher then
					ref = ref * 2
				elseif c.pistol then
					ref = ref * 1.5
				end
				v.AMMO_PICKUP = { 35 / ref, 70 / ref }
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
