if Network:is_client() then
	return
end

local init_original = CopActionHurt.init
function CopActionHurt:init(action_desc, common_data, ...)
	if action_desc.hurt_type ~= "death" or not common_data.ext_movement:cool() then
		return init_original(self, action_desc, common_data, ...)
	end

	local cop_hurt_alert_radius_whisper = tweak_data.upgrades.cop_hurt_alert_radius_whisper
	tweak_data.upgrades.cop_hurt_alert_radius_whisper = 0

	local result = init_original(self, action_desc, common_data, ...)

	tweak_data.upgrades.cop_hurt_alert_radius_whisper = cop_hurt_alert_radius_whisper

	return result
end
