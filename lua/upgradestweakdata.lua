Hooks:PostHook(UpgradesTweakData, "init", "init_sss", function (self)
	local all_level_upgrades = {}
	for _, level in pairs(self.level_tree) do
		for _, upgrade in pairs(level.upgrades) do
			table.insert(all_level_upgrades, upgrade)
		end
	end
	table.insert(all_level_upgrades, "body_armor6")

	self.level_tree = {
		[0] = {
			upgrades = all_level_upgrades
		}
	}

	self.sentry_gun_base_armor = 50
end)
