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
			bm_menu_sss_weapon_locked = "This is not a super serious weapon",
			bm_menu_sss_part_locked = "This is not a super serious part"
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
