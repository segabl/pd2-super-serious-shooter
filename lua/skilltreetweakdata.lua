Hooks:PostHook(SkillTreeTweakData, "init", "init_sss", function (self)
	for _, skill_data in pairs(self.skills) do
		for _, tier_data in ipairs(skill_data) do
			tier_data.upgrades = {}
		end
	end

	for _, deck_data in pairs(self.specializations) do
		for _, card_data in ipairs(deck_data) do
			card_data.upgrades = {}
			if card_data.multi_choice then
				for _, multi_choice_data in ipairs(card_data.multi_choice) do
					multi_choice_data.upgrades = {}
				end
			end
		end
	end

	self.default_upgrades = {
		"player_special_enemy_highlight",
		"player_hostage_trade",
		"player_sec_camera_highlight",
		"player_corpse_dispose",
		"doctor_bag",
		"ammo_bag",
		"trip_mine",
		"ecm_jammer",
		"first_aid_kit",
		"sentry_gun",
		"sentry_gun_silent",
		"bodybags_bag",
		"armor_kit",
		"saw",
		"cable_tie"
	}
end)
