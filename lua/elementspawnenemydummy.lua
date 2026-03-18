local tank_replacement = {
	special_type = "tank",
	limit = 1,
	category = "FBI_heavy_R870",
	chance = 0.35
}
local sniper_replacement = {
	special_type = "sniper",
	limit = Global.game_settings and Global.game_settings.one_down and 6 or 3,
	category = "FBI_swat_M4",
	access = "sniper"
}
---@type table<string, { special_type: string, limit: number, category: string, access?: string, chance?: number }>
ElementSpawnEnemyDummy.sss_replacements = {
	[("units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1"):key()] = tank_replacement,
	[("units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2"):key()] = tank_replacement,
	[("units/payday2/characters/ene_bulldozer_3/ene_bulldozer_3"):key()] = tank_replacement,
	[("units/payday2/characters/ene_bulldozer_4/ene_bulldozer_4"):key()] = tank_replacement,
	[("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer_2/ene_zeal_bulldozer_2"):key()] = tank_replacement,
	[("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer_3/ene_zeal_bulldozer_3"):key()] = tank_replacement,
	[("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer/ene_zeal_bulldozer"):key()] = tank_replacement,
	[("units/pd2_dlc_drm/characters/ene_bulldozer_minigun/ene_bulldozer_minigun"):key()] = tank_replacement,
	[("units/pd2_dlc_drm/characters/ene_bulldozer_minigun_classic/ene_bulldozer_minigun_classic"):key()] = tank_replacement,
	[("units/pd2_dlc_drm/characters/ene_bulldozer_medic/ene_bulldozer_medic"):key()] = tank_replacement,
	[("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_r870/ene_akan_fbi_tank_r870"):key()] = tank_replacement,
	[("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_saiga/ene_akan_fbi_tank_saiga"):key()] = tank_replacement,
	[("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_rpk_lmg/ene_akan_fbi_tank_rpk_lmg"):key()] = tank_replacement,
	[("units/pd2_dlc_hvh/characters/ene_bulldozer_hvh_1/ene_bulldozer_hvh_1"):key()] = tank_replacement,
	[("units/pd2_dlc_hvh/characters/ene_bulldozer_hvh_2/ene_bulldozer_hvh_2"):key()] = tank_replacement,
	[("units/pd2_dlc_hvh/characters/ene_bulldozer_hvh_3/ene_bulldozer_hvh_3"):key()] = tank_replacement,
	[("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_2/ene_murkywater_bulldozer_2"):key()] = tank_replacement,
	[("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_3/ene_murkywater_bulldozer_3"):key()] = tank_replacement,
	[("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_4/ene_murkywater_bulldozer_4"):key()] = tank_replacement,
	[("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_1/ene_murkywater_bulldozer_1"):key()] = tank_replacement,
	[("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_medic/ene_murkywater_bulldozer_medic"):key()] = tank_replacement,
	[("units/pd2_dlc_bex/characters/ene_swat_dozer_policia_federale_r870/ene_swat_dozer_policia_federale_r870"):key()] = tank_replacement,
	[("units/pd2_dlc_bex/characters/ene_swat_dozer_policia_federale_saiga/ene_swat_dozer_policia_federale_saiga"):key()] = tank_replacement,
	[("units/pd2_dlc_bex/characters/ene_swat_dozer_policia_federale_m249/ene_swat_dozer_policia_federale_m249"):key()] = tank_replacement,
	[("units/pd2_dlc_bex/characters/ene_swat_dozer_policia_federale_minigun/ene_swat_dozer_policia_federale_minigun"):key()] = tank_replacement,
	[("units/pd2_dlc_bex/characters/ene_swat_dozer_medic_policia_federale/ene_swat_dozer_medic_policia_federale"):key()] = tank_replacement,
	[("units/payday2/characters/ene_sniper_1/ene_sniper_1"):key()] = sniper_replacement,
	[("units/payday2/characters/ene_sniper_2/ene_sniper_2"):key()] = sniper_replacement,
	[("units/payday2/characters/ene_sniper_3/ene_sniper_3"):key()] = sniper_replacement,
	[("units/pd2_dlc_gitgud/characters/ene_zeal_sniper/ene_zeal_sniper"):key()] = sniper_replacement,
	[("units/pd2_dlc_hvh/characters/ene_sniper_hvh_2/ene_sniper_hvh_2"):key()] = sniper_replacement,
	[("units/pd2_dlc_bph/characters/ene_murkywater_sniper/ene_murkywater_sniper"):key()] = sniper_replacement,
	[("units/pd2_dlc_bex/characters/ene_swat_policia_sniper/ene_swat_policia_sniper"):key()] = sniper_replacement
}

local produce_original = ElementSpawnEnemyDummy.produce
function ElementSpawnEnemyDummy:produce(params, ...)
	if params and params.name then
		return produce_original(self, params, ...)
	end

	local enemy_name = self._possible_enemies and self._possible_enemies[1] or self._patched_enemy_name or self._enemy_name
	local replacement = self.sss_replacements[enemy_name:key()]
	if not replacement then
		return produce_original(self, params, ...)
	end

	local unit_category = tweak_data.group_ai.unit_categories[replacement.category]
	if not unit_category then
		return produce_original(self, params, ...)
	end

	local active = managers.groupai:state()._special_units[replacement.special_type] or {}
	local replace = table.size(active) >= replacement.limit or math.random() < (replacement.chance or 0)
	if not replace then
		return produce_original(self, params, ...)
	end

	self._enemy_name = table.random(unit_category.unit_types[tweak_data.levels:get_ai_group_type()])
	local unit = produce_original(self, params, ...)
	if unit and replacement.access then
		local brain = unit:brain()
		brain._SO_access = managers.navigation:convert_access_flag(replacement.access)
		brain._logic_data.SO_access = brain._SO_access
		brain._logic_data.SO_access_str = replacement.access
	end
	self._enemy_name = enemy_name

	return unit
end
