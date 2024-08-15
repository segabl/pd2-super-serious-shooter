-- Reduce Team AI damage
local _fire_raycast_original = NewNPCRaycastWeaponBase._fire_raycast
function NewNPCRaycastWeaponBase:_fire_raycast(user_unit, from_pos, direction, dmg_mul, ...)
	return _fire_raycast_original(self, user_unit, from_pos, direction, self._is_team_ai and dmg_mul * 0.5 or dmg_mul, ...)
end
