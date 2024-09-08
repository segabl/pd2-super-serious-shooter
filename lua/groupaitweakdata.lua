Hooks:PostHook(GroupAITweakData, "init", "init_sss", function (self)
	self.smoke_and_flash_grenade_timeout = { 7.5, 15 }
	self.min_grenade_timeout = 10
	self.no_grenade_push_delay = 10

	local force = self.besiege.assault.force
	self.besiege.assault.force = { force[1] * 0.35, force[2] * 0.35, force[3] * 0.35 }

	local one_down = Global.game_settings and Global.game_settings.one_down
	for special, limit in pairs(self.special_unit_spawn_limits) do
		self.special_unit_spawn_limits[special] = (one_down or special == "shield") and math.min(special == "tank" and 1 or 2, limit) or 0
	end

	for _, group_ai_state_name in pairs({ "besiege", "street", "safehouse" }) do
		for _, assault_state in pairs(self[group_ai_state_name]) do
			if type(assault_state) == "table" and type(assault_state.groups) == "table" then
				for group_name, weights in pairs(assault_state.groups) do
					local group = self.enemy_spawn_groups[group_name]
					if group then
						local is_special_group = false
						for _, data in pairs(group.spawn) do
							if self.unit_categories[data.unit].special_type ~= nil then
								data.amount_max = 1
								data.amount_min = math.min(data.amount_max, data.amount_min or 0)
								if data.amount_min > 0 then
									is_special_group = true
								end
							end
						end
						if is_special_group then
							assault_state.groups[group_name] = table.collect(weights, function(w) return w * 0.5 end)
						end
					end
				end
			end
		end
	end

	for _, tactics in pairs(self._tactics) do
		table.delete(tactics, "charge")
		if not table.contains(tactics, "ranged_fire") then
			table.insert(tactics, "ranged_fire")
		end
	end

	self.enemy_spawn_groups.marshal_squad = nil
end)
