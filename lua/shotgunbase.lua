function ShotgunBase:_fire_raycast(user_unit, from_pos, direction, dmg_mul, ...)
	local result = {
		hit_enemy = false,
		rays = {}
	}

	dmg_mul = dmg_mul / self._rays

	for _ = 1, self._rays do
		local res = ShotgunBase.super._fire_raycast(self, user_unit, from_pos, direction, dmg_mul, ...)
		result.hit_enemy = result.hit_enemy or res.hit_enemy
		table.list_append(result.rays, res.rays)
	end

	return result
end
