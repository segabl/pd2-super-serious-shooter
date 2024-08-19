Hooks:PostHook(CopDamage, "accuracy_multiplier", "accuracy_multiplier_sss", function (self)
	return Hooks:GetReturn() * (self._unit:anim_data().move and 1 or 1.25)
end)

function CopDamage:can_be_critical()
	return false
end
