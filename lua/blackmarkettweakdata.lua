Hooks:PostHook(BlackMarketTweakData, "init", "init_sss", function (self)
	for _, v in pairs(self.melee_weapons) do
		v.stats.remove_weapon_movement_penalty = nil
	end
end)
