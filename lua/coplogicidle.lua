local _chk_relocate_original = CopLogicIdle._chk_relocate
function CopLogicIdle._chk_relocate(data, ...)
	if not data.objective or data.objective.type ~= "defend_area" then
		return _chk_relocate_original(data, ...)
	end
end
