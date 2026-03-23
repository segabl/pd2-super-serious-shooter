Hooks:PostHook(CopDamage, "accuracy_multiplier", "accuracy_multiplier_sss", function(self)
	return Hooks:GetReturn() * (self._unit:anim_data().move and 0.75 or 1)
end)

function CopDamage:can_be_critical()
	return false
end

Hooks:PostHook(CopDamage, "damage_bullet", "damage_bullet_sss", function(self, attack_data)
	if Hooks:GetReturn() or self._dead or self._invulnerable or self:chk_immune_to_attacker(attack_data.attacker_unit) then
		return
	end

	if not self._has_plate or not attack_data.col_ray.body or attack_data.col_ray.body:name() ~= self._ids_plate_name then
		return
	end

	local t = TimerManager:game():time()
	local diminish = math.map_range_clamped(t - (self._accumulated_plate_dmg_t or 0), 0, 1, 1, 0)
	self._accumulated_plate_dmg = diminish * (self._accumulated_plate_dmg or 0) + attack_data.damage * 0.01 * self._HEALTH_GRANULARITY
	self._accumulated_plate_dmg_t = t

	if self._accumulated_plate_dmg <= 0 then
		return
	end

	local damage_percent = math.ceil(math.clamp(self._accumulated_plate_dmg, 1, self._HEALTH_GRANULARITY))
	local hurt_type = self:get_damage_type(damage_percent, "bullet")
	if hurt_type == "dmg_rcv" or hurt_type == "light_hurt" and self._unit:anim_data().hurt then
		return
	end

	if hurt_type ~= "light_hurt" then
		self._accumulated_plate_dmg = -self._accumulated_plate_dmg
	end

	attack_data.damage = 0
	attack_data.result = {
		type = hurt_type,
		variant = attack_data.variant
	}

	self:_on_damage_received(attack_data)
end)
