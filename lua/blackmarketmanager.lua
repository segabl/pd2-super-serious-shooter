function BlackMarketManager:weapon_locked_sss()
	return false, "bm_menu_sss_locked", "guis/textures/pd2/skilltree/padlock"
end

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
