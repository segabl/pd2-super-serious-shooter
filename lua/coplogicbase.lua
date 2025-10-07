local _upd_attention_obj_detection_original = CopLogicBase._upd_attention_obj_detection
function CopLogicBase._upd_attention_obj_detection(data, ...)
	local delay = _upd_attention_obj_detection_original(data, ...)
	return data.cool and delay or math.min(0.25, delay)
end
