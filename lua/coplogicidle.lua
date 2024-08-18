if StreamHeist then
	return
end

local on_intimidated_original = CopLogicIdle.on_intimidated
function CopLogicIdle.on_intimidated(data, amount, aggressor_unit, ...)
	local surrender = on_intimidated_original(data, amount, aggressor_unit, ...)
	if surrender or data.char_tweak.priority_shout or not data.team.foes.criminal1 or data.char_tweak.surrender == tweak_data.character.presets.surrender.special then
		data._skip_surrender_hints = nil
		return surrender
	end

	local surrender_window_expired = data.surrender_window and data.surrender_window.window_expire_t < data.t
	local too_many_hostages = not managers.groupai:state():has_room_for_police_hostage()
	if not data.char_tweak.surrender or surrender_window_expired or too_many_hostages then
		local peer = managers.network:session():peer_by_unit(aggressor_unit)
		if not peer then
			return
		end

		if not data._skip_surrender_hints then
			data._skip_surrender_hints = surrender_window_expired and 0 or 1
		end

		if data._skip_surrender_hints <= 0 then
			if peer:id() == managers.network:session():local_peer():id() then
				managers.hint:show_hint("convert_enemy_failed")
			else
				managers.network:session():send_to_peer(peer, "sync_show_hint", "convert_enemy_failed")
			end
			data._skip_surrender_hints = 3
		else
			data._skip_surrender_hints = data._skip_surrender_hints - 1
		end
	end
end
