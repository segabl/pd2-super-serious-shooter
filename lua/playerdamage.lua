Hooks:PreHook(PlayerDamage, "damage_bullet", "damage_bullet_sss", function (self, attack_data)
	if not attack_data or not attack_data.damage then
		return
	end

	local shake_armor_multiplier = managers.player:body_armor_value("damage_shake") * (self:get_real_armor() > 0 and 1 or 2)
	self._unit:camera()._damage_bullet_shake_multiplier = math.clamp(attack_data.damage, 0, 10) * shake_armor_multiplier
end)
