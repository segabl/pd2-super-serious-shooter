local _get_unit_intimidation_action_original = PlayerStandard._get_unit_intimidation_action
function PlayerStandard:_get_unit_intimidation_action(enemies, civilians, teammates, specials_only, ...)
	specials_only = managers.groupai:state():get_assault_mode() or specials_only
	return _get_unit_intimidation_action_original(self, enemies, civilians, teammates, specials_only, ...)
end
