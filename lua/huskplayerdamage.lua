local init_original = HuskPlayerDamage.init
function HuskPlayerDamage:init(...)
	local one_down = Global.game_settings.one_down
	Global.game_settings.one_down = nil
	init_original(self, ...)
	Global.game_settings.one_down = one_down
end
