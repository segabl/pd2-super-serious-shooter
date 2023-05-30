local _upd_attention_obj_detection_original = CopLogicBase._upd_attention_obj_detection
function CopLogicBase._upd_attention_obj_detection(...)
	local delay = _upd_attention_obj_detection_original(...)
	return math.min(0.25, delay)
end
