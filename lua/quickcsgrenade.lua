function QuickCsGrenade:_do_damage()
	local player_unit = managers.player:player_unit()
	if not alive(player_unit) or mvector3.distance_sq(self._unit:position(), player_unit:position()) > self._tweak_data.radius ^ 2 then
		return
	end

	player_unit:character_damage():damage_killzone({
		variant = "teargas",
		damage = self._damage_per_tick,
		col_ray = {
			ray = math.UP
		}
	})

	if not self._has_played_VO then
		PlayerStandard.say_line(player_unit:sound(), "g42x_any")
		self._has_played_VO = true
	end
end
