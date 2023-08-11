Hooks:PostHook(CopDamage, "accuracy_multiplier", "accuracy_multiplier_sss", function (self)
	return Hooks:GetReturn() * (self._unit:movement():get_walk_to_pos() and 1 or 1.25)
end)

function CopDamage:can_be_critical()
	return false
end
