local _get_unit_intimidation_action_original = PlayerStandard._get_unit_intimidation_action
function PlayerStandard:_get_unit_intimidation_action(enemies, civilians, teammates, specials_only, ...)
	specials_only = not managers.groupai:state()._rescue_allowed or specials_only
	return _get_unit_intimidation_action_original(self, enemies, civilians, teammates, specials_only, ...)
end
