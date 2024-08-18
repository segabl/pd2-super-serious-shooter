local _check_action_jump_original = PlayerStandard._check_action_jump
function PlayerStandard:_check_action_jump(t, input, ...)
	local is_running = self._move_dir and self._running and self._unit:movement():is_above_stamina_threshold() and t - self._start_running_t > 0.4

	local new_action = _check_action_jump_original(self, t, input, ...)

	if self._jump_t == t and not is_running then
		self._unit:movement():subtract_stamina(tweak_data.player.movement_state.stamina.JUMP_STAMINA_DRAIN * 0.5)
	end

	return new_action
end
