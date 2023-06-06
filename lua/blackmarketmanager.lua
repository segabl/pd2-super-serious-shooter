function BlackMarketManager:get_sorted_armors(hide_locked)
	local sort_data = {}
	local armor_level_data = {}

	for id in pairs(tweak_data.blackmarket.armors) do
		table.insert(sort_data, id)
		armor_level_data[id] = 0
	end

	table.sort(sort_data, function (x, y)
		return tweak_data.blackmarket.armors[x].upgrade_level < tweak_data.blackmarket.armors[y].upgrade_level
	end)

	return sort_data, armor_level_data
end

Hooks:PostHook(BlackMarketManager, "_verify_dlc_items", "_verify_dlc_items_sss", function (self)
	for weapon_id, weapon in pairs(Global.blackmarket_manager.weapons) do
		if tweak_data.weapon[weapon_id] and tweak_data.weapon[weapon_id].global_value == "super_serious_shooter_weapon" then
			weapon.unlocked = false
		end
	end
end)

Hooks:PostHook(BlackMarketManager, "load", "load_sss", function (self, data)
	if not data.blackmarket then
		return
	end

	for _, category in ipairs({ "primaries", "secondaries" }) do
		if self._global.crafted_items[category] then
			for _, crafted in pairs(self._global.crafted_items[category]) do
				for id in pairs(crafted.global_values or {}) do
					if tweak_data.weapon.factory.parts[id] and tweak_data.weapon.factory.parts[id].global_value == "super_serious_shooter_part" then
						crafted.global_values[id] = tweak_data.weapon.factory.parts[id].global_value
					end
				end
			end
		end
	end
end)
