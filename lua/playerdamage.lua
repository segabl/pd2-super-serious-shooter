Hooks:PreHook(PlayerDamage, "damage_bullet", "damage_bullet_sss", function (self, attack_data)
	if not attack_data or not attack_data.damage then
		return
	end

	local shake_armor_multiplier = managers.player:body_armor_value("damage_shake") * (self:get_real_armor() > 0 and 1 or 2)
	self._unit:camera()._damage_bullet_shake_multiplier = math.clamp(attack_data.damage, 0, 10) * shake_armor_multiplier
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

	self._unit:sound():play("player_hit")

	self:_hit_direction(attack_data.col_ray.origin, attack_data.col_ray.ray)

	if self._bleed_out then
		return
	end

	attack_data.damage = managers.player:modify_value("damage_taken", attack_data.damage, attack_data)

	self:mutator_update_attack_data(attack_data)
	self:_check_chico_heal(attack_data)

	self:_calc_health_damage(attack_data)

	self:_call_listeners(damage_info)
end
