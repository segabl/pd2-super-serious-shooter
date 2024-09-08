if not SuperSeriousShooter then
	SuperSeriousShooter = {}
	SuperSeriousShooter.required = {}
	SuperSeriousShooter.mod_path = ModPath
	SuperSeriousShooter.mod_instance = ModInstance
	SuperSeriousShooter.difficulties = {
		"easy", "normal", "hard", "overkill", "overkill_145", "easy_wish", "overkill_290", "sm_wish"
	}

	function SuperSeriousShooter:difficulty_tweak(tweak_data, func)
		for _, difficulty in pairs(self.difficulties) do
			Hooks:PostHook(tweak_data, "_set_" .. difficulty, "_set_" .. difficulty .. "_sss", func)
		end
	end

	Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInitSSS", function (loc)
		loc:add_localized_strings({
			bm_wp_upg_a_custom_desc = loc:text("bm_wp_upg_a_custom_desc") .. "\n6 PELLETS",
			bm_wp_upg_a_rip_desc = loc:text("bm_wp_upg_a_rip_desc") .. "\n6 PELLETS, NO AMMO PICKUPS",
			bm_wp_upg_a_explosive_desc = loc:text("bm_wp_upg_a_explosive_desc") .. "\n1 SLUG, NO AMMO PICKUPS",
			bm_wp_upg_a_piercing_desc = loc:text("bm_wp_upg_a_piercing_desc") .. "\n8 FLECHETTES, REDUCED AMMO PICKUPS",
			bm_wp_upg_a_slug_desc = loc:text("bm_wp_upg_a_slug_desc") .. "\n1 SLUG, REDUCED AMMO PICKUPS",
			bm_wp_upg_a_dragons_breath_desc = loc:text("bm_wp_upg_a_dragons_breath_desc") .. "\n8 PELLETS, NO AMMO PICKUPS",
			menu_one_down = "Special Operation",
			menu_toggle_one_down = "Special Operation"
		})
	end)
end

if RequiredScript and not SuperSeriousShooter.required[RequiredScript] then

	local fname = SuperSeriousShooter.mod_path .. RequiredScript:gsub(".+/(.+)", "lua/%1.lua")
	if io.file_is_readable(fname) then
		dofile(fname)
	end

	SuperSeriousShooter.required[RequiredScript] = true

end
