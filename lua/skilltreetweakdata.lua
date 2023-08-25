Hooks:PostHook(SkillTreeTweakData, "init", "init_sss", function (self, tweak_data)
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
		"player_primary_weapon_when_downed",
		"player_intimidate_enemies",
		"player_special_enemy_highlight",
		"player_hostage_trade",
		"player_sec_camera_highlight",
		"player_corpse_dispose",
		"player_corpse_dispose_amount_1",
		"ecm_jammer_affects_cameras",
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
		"cable_tie",
		"jowi",
		"x_1911",
		"x_b92fs",
		"x_deagle",
		"x_g22c",
		"x_g17",
		"x_usp",
		"x_packrat",
		"x_p226",
		"x_ppk",
		"body_armor1",
		"body_armor2",
		"body_armor3",
		"body_armor4",
		"body_armor5",
		"body_armor6"
	}
end)
