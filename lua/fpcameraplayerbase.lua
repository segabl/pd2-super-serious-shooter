Hooks:PostHook(FPCameraPlayerBase, "stop_shooting", "stop_shooting_sss", function (self)
	self._recoil_kick.to_reduce = self._recoil_kick.last
	self._recoil_kick.h.to_reduce = self._recoil_kick.h.last
end)

function FPCameraPlayerBase:recoil_kick(up, down, left, right)
	local v = math.lerp(up, down, math.random())
	self._recoil_kick.accumulated = (self._recoil_kick.accumulated or 0) + v
	self._recoil_kick.last = v
	local h = math.lerp(left, right, math.random())
	self._recoil_kick.h.accumulated = (self._recoil_kick.h.accumulated or 0) + h
	self._recoil_kick.h.last = h
end

function FPCameraPlayerBase:_vertical_recoil_kick(t, dt)
	if managers.player:current_state() == "bipod" then
		self:break_recoil()
		return 0
	end

	local r_value = 0
	if self._recoil_kick.current and self._episilon < self._recoil_kick.accumulated - self._recoil_kick.current then
		local n = math.step(self._recoil_kick.current, self._recoil_kick.accumulated, 40 * dt)
		r_value = n - self._recoil_kick.current
		self._recoil_kick.current = n
	elseif self._recoil_wait then
		self._recoil_wait = self._recoil_wait - dt * 0.5
		if self._recoil_wait < 0 then
			self._recoil_wait = nil
		end
	elseif self._recoil_kick.to_reduce then
		self._recoil_kick.current = nil
		local n = math.lerp(self._recoil_kick.to_reduce, 0, 3 * dt)
		r_value = -(self._recoil_kick.to_reduce - n)
		self._recoil_kick.to_reduce = n

		if self._recoil_kick.to_reduce == 0 then
			self._recoil_kick.to_reduce = nil
		end
	end

	return r_value
end

function FPCameraPlayerBase:_horizonatal_recoil_kick(t, dt)
	if managers.player:current_state() == "bipod" then
		return 0
	end

	local r_value = 0
	if self._recoil_kick.h.current and self._episilon < math.abs(self._recoil_kick.h.accumulated - self._recoil_kick.h.current) then
		local n = math.step(self._recoil_kick.h.current, self._recoil_kick.h.accumulated, 40 * dt)
		r_value = n - self._recoil_kick.h.current
		self._recoil_kick.h.current = n
	elseif self._recoil_wait then
		self._recoil_wait = self._recoil_wait - dt * 0.5
		if self._recoil_wait < 0 then
			self._recoil_wait = nil
		end
	elseif self._recoil_kick.h.to_reduce then
		self._recoil_kick.h.current = nil
		local n = math.lerp(self._recoil_kick.h.to_reduce, 0, 2 * dt)
		r_value = -(self._recoil_kick.h.to_reduce - n)
		self._recoil_kick.h.to_reduce = n

		if self._recoil_kick.h.to_reduce == 0 then
			self._recoil_kick.h.to_reduce = nil
		end
	end

	return r_value
end
