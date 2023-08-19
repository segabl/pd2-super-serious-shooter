function KillzoneManager:_deal_gas_damage(unit)
	unit:character_damage():damage_killzone({
		variant = "teargas",
		damage = 0.75,
		col_ray = {
			ray = math.UP
		}
	})
end
