Hooks:PostHook(GroupAITweakData, "init", "init_sss", function(self)
	self.smoke_and_flash_grenade_timeout = { 7.5, 15 }
	self.min_grenade_timeout = 10
	self.no_grenade_push_delay = 10

	local force = self.besiege.assault.force
	self.besiege.assault.force = { force[1] * 0.35, force[2] * 0.35, force[3] * 0.35 }

	local one_down = Global.game_settings and Global.game_settings.one_down
	for special, limit in pairs(self.special_unit_spawn_limits) do
		self.special_unit_spawn_limits[special] = (one_down or special == "shield") and math.min(special == "tank" and 1 or 2, limit) or 0
	end

	local special_weights = {
		tank = { 1, 0.35 },
		shield = { 2, 0.65 },
		default = { 3, 0.5 }
	}
	local remove_units = {
		marshal_marksman = true,
		marshal_shield = true
	}
	local removed_groups = {}
	for _, group_ai_state_name in pairs({ "besiege", "street", "safehouse" }) do
		for _, assault_state in pairs(self[group_ai_state_name]) do
			if type(assault_state) == "table" and type(assault_state.groups) == "table" then
				for group_name, weights in pairs(assault_state.groups) do
					local group = self.enemy_spawn_groups[group_name]
					if group then
						local special_group_weight
						for i, data in table.reverse_ipairs(group.spawn) do
							if remove_units[data.unit] then
								table.remove(group.spawn, i)
							elseif self.unit_categories[data.unit].special_type then
								data.amount_max = 1
								data.amount_min = math.min(data.amount_max, data.amount_min or 0)
								data.freq = data.freq * 0.75
								if data.amount_min > 0 then
									local special_weight = special_weights[self.unit_categories[data.unit].special_type] or special_weights.default
									if not special_group_weight or special_weight[1] < special_group_weight[1] then
										special_group_weight = special_weight
									end
								end
							end
						end
						if #group.spawn == 0 then
							self.enemy_spawn_groups[group_name] = nil
							assault_state.groups[group_name] = nil
							removed_groups[group_name] = true
						elseif special_group_weight then
							assault_state.groups[group_name] = table.collect(weights, function(w) return w * special_group_weight[2] end)
						end
					elseif removed_groups[group_name] then
						assault_state.groups[group_name] = nil
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
end)
