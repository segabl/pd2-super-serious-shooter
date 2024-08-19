Hooks:PostHook(WeaponTweakData, "init", "init_sss", function (self, tweak_data)
	self.tweak_data = tweak_data

	self.lemming.CLIP_AMMO_MAX = 10

	for i = 1, #self.stats.recoil do
		self.stats.recoil[i] = 0.5 + (#self.stats.recoil - i) * 0.05
	end

	for i = 1, #self.stats.spread do
		self.stats.spread[i] = 0.02 + (#self.stats.spread - i) * 0.06
	end

	-- so we don't have to use stats_modifiers to increase damage on guns and affect weapon mods too
	self.stats.damage = {}
	for i = 1, 1000 do
		table.insert(self.stats.damage, i * 0.1)
	end

	local function kick(up, down, left, right, mul)
		return { up * mul, down * mul, left * mul, right * mul }
	end

	for _, v in pairs(self) do
		if type(v) == "table" and v.autohit ~= nil then
			local c = table.list_to_set(v.categories)
			local dmg = self.stats.damage[math.min(v.stats.damage, #self.stats.damage)] * (v.stats_modifiers and v.stats_modifiers.damage or 1)

			if c.shotgun and v.rays then
				v.rays = 8
				v.stats.damage = math.ceil(v.stats.damage * 2.5)
			elseif c.flamethrower then
				v.AMMO_MAX = v.CLIP_AMMO_MAX
				v.NR_CLIPS_MAX = 1
			end

			if v.can_shoot_through_shield then
				v.NR_CLIPS_MAX = math.max(2, math.floor(15 / math.max(2, v.CLIP_AMMO_MAX)))
				v.AMMO_MAX = v.CLIP_AMMO_MAX * v.NR_CLIPS_MAX
			end

			-- steelsight spread is applied as a multiplier of (2 - spread) on top of standing or crouching
			if v.spread then
				v.spread.standing = (c.snp and 10 or (c.shotgun or c.minigun or c.lmg) and 3 or 2) * (c.akimbo and 3 or 1)
				v.spread.crouching = v.spread.standing * 0.75
				v.spread.moving_standing = (c.snp and 20 or c.revolver and 8 or (c.shotgun or c.minigun or c.lmg) and 6 or c.pistol and 3 or 4) * (c.akimbo and 3 or 1)
				v.spread.moving_crouching = v.spread.moving_standing * 0.75
				v.spread.steelsight = c.snp and 1.9 or 1.5
				v.spread.bipod = v.spread.standing * 0.5
			end

			if v.kick then
				local up, down, left, right = unpack(v.kick.standing)
				local sum = math.abs(up) + math.abs(down) + math.abs(left) + math.abs(right)
				if sum > 0 then
					local mul = (dmg ^ 0.35) * (c.akimbo and (c.pistol and 6 or 10) or (c.minigun or c.lmg) and 5 or 3)
					up = (up / sum) * mul
					down = (down / sum) * mul
					left = (left / sum) * mul
					right = (right / sum) * mul
				end
				v.kick.standing = kick(up, down, left, right, 1.25)
				v.kick.crouching = kick(up, down, left, right, 1)
				v.kick.steelsight = kick(up, down, left, right, 0.75)
			end

			if c.flamethrower or c.minigun or c.grenade_launcher or c.bow or c.crossbow then
				v.AMMO_PICKUP = { 0, 0 }
				v.desc_id = "bm_w_rpg7_desc"
				v.has_description = true
			elseif v.AMMO_PICKUP and v.AMMO_PICKUP[2] > 0 then
				local ref = (dmg ^ 1.2) * (v.can_shoot_through_shield and 3 or 1) * (v.rays and 2 or 1) * (c.pistol and 1.5 or 1)
				v.AMMO_PICKUP = { 35 / ref, 70 / ref }
			end

			v.damage_falloff = nil
			v.damage_near = nil
			v.damage_far = nil
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
			weap_data.SPREAD = 5
			weap_data.DAMAGE = diff_i * 0.25
			weap_data.DAMAGE_MUL_RANGE = turret_damage_mul
			weap_data.HEALTH_INIT = 2000
			weap_data.SHIELD_HEALTH_INIT = 200
			weap_data.CLIP_SIZE = 400
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
