Hooks:PreHook(NewRaycastWeaponBase, "_fire_raycast", "_fire_raycast_sss", function (self)
	self._hit_through_object = nil
end)

Hooks:PostHook(NewRaycastWeaponBase, "get_damage_falloff", "get_damage_falloff_sss", function (self, damage, hit)
	self._hit_through_object = self._hit_through_object or hit.unit:in_slot(self.wall_mask) or hit.unit:in_slot(self.shield_mask)
	if self._hit_through_object then
		return Hooks:GetReturn() * 0.35
	end
end)
