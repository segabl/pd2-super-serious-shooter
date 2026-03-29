local _upd_attention_obj_detection_original = CopLogicBase._upd_attention_obj_detection
function CopLogicBase._upd_attention_obj_detection(data, ...)
	local delay = _upd_attention_obj_detection_original(data, ...)
	return data.cool and delay or math.min(0.25, delay)
end

local _evaluate_reason_to_surrender_original = CopLogicBase._evaluate_reason_to_surrender
function CopLogicBase._evaluate_reason_to_surrender(data, my_data, aggressor_unit, ...)
	local hold_chance = _evaluate_reason_to_surrender_original(data, my_data, aggressor_unit, ...)
	if not hold_chance then
		return
	end

	if not managers.groupai:state():get_assault_mode() then
		return hold_chance
	end

	local grp_objective = data.group and data.group.objective
	if not grp_objective or grp_objective.type == "retire" then
		return hold_chance
	end

	if data.surrender_window then
		data.surrender_window.window_expire_t = 0
	end
end
