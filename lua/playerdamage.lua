local init_original = PlayerDamage.init
function PlayerDamage:init(...)
	local one_down = Global.game_settings.one_down
	Global.game_settings.one_down = nil
	init_original(self, ...)
	Global.game_settings.one_down = one_down
end

Hooks:PreHook(PlayerDamage, "damage_bullet", "damage_bullet_sss", function (self, attack_data)
	if not attack_data or not attack_data.damage then
		return
	end

	local shake_armor_multiplier = self:get_real_armor() > 0 and managers.player:body_armor_value("damage_shake") or 2
	self._unit:camera()._damage_bullet_shake_multiplier = math.clamp(attack_data.damage, 1, 10) * shake_armor_multiplier
end)

local damage_killzone_original = PlayerDamage.damage_killzone
function PlayerDamage:damage_killzone(attack_data, ...)
	if attack_data.variant ~= "teargas" then
		return damage_killzone_original(self, attack_data, ...)
	end

	local damage_info = {
		result = {
			variant = "killzone",
			type = "hurt"
		}
	}

	if self._god_mode or self._invulnerable or self._mission_damage_blockers.invulnerable then
		self:_call_listeners(damage_info)
		return
	elseif self:incapacitated() or self._unit:movement():current_state().immortal then
		return
	end

	local t = managers.player:player_timer():time()
	if not self._last_teargas_hit_t or self._last_teargas_hit_t + 5 < t then
		self._teargas_damage_ramp = -0.1
	else
		self._teargas_damage_ramp = math.min(self._teargas_damage_ramp + 0.1, 1)
	end

	self._last_teargas_hit_t = t

	self._unit:sound():play("player_hit")

	self:_hit_direction(attack_data.col_ray.origin, attack_data.col_ray.ray)

	if self._bleed_out then
		return
	end

	attack_data.damage = managers.player:modify_value("damage_taken", attack_data.damage, attack_data) * math.max(0, self._teargas_damage_ramp)

	self:mutator_update_attack_data(attack_data)
	self:_check_chico_heal(attack_data)

	self:_calc_health_damage(attack_data)

	self:_call_listeners(damage_info)
end

function PlayerDamage:_chk_dmg_too_soon()
	local next_allowed_dmg_t = type(self._next_allowed_dmg_t) == "number" and self._next_allowed_dmg_t or Application:digest_value(self._next_allowed_dmg_t, false)
	return managers.player:player_timer():time() < next_allowed_dmg_t
end

local _calc_armor_damage_original = PlayerDamage._calc_armor_damage
function PlayerDamage:_calc_armor_damage(...)
	local had_armor = self:get_real_armor() > 0

	local health_subtracted = _calc_armor_damage_original(self, ...)

	if health_subtracted > 0 and had_armor and self:get_real_armor() <= 0 then
		self._next_allowed_dmg_t = Application:digest_value(managers.player:player_timer():time() + 0.35, true)
	end

	return health_subtracted
end
