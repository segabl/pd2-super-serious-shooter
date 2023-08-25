Hooks:PreHook(PlayerInventoryGui, "create_box", "create_box_sss", function (self, params)
	if params.name == "skilltree" or params.name == "specialization" then
		params.text = "DISABLED"
		params.text_selected_color = tweak_data.screen_colors.important_1
		params.image = "guis/textures/pd2/none_icon"
		params.texture_rect = nil
		params.image_rect = nil
		params.image_size_mul = 1.5
	elseif params.image == "guis/textures/pd2/inv_skillcards_icons" then
		params.alpha = 0
	end
end)
