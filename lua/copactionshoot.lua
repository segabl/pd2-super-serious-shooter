Hooks:PostHook(CopActionShoot, "init", "init_sss", function (self)
	self._glare_bitmap = self._glint_effect and managers.hud._fullscreen_workspace:panel():bitmap({
		texture = "guis/textures/pd2/particles/fill",
		color = Color.red,
		alpha = 0,
		w = 2048,
		h = 2048
	})
end)

function CopActionShoot:_is_local_player_target_and_verified()
	if self._attention and self._attention.unit and self._attention.unit == managers.player:local_player() then
		return not World:raycast("ray", self._shoot_from_pos, self._attention.unit:movement():m_head_pos(), "slot_mask", self._verif_slotmask, "ray_type", "ai_vision", "report")
	end
end

function CopActionShoot:_set_glare_alpha(alpha, remove)
	if alpha == self._glare_alpha then
		return
	end

	self._glare_alpha = alpha
	self._glare_bitmap:stop()

	local a = self._glare_bitmap:alpha()
	local s = math.abs(alpha - a)
	self._glare_bitmap:animate(function (o)
		over(s, function (p)
			o:set_alpha(math.lerp(a, alpha, p))
		end)

		if remove then
			o:parent():remove(o)
		end
	end)
end

Hooks:PostHook(CopActionShoot, "on_exit", "on_exit_sss", function (self)
	if alive(self._glare_bitmap) then
		self:_set_glare_alpha(0, true)
	end
end)

Hooks:PostHook(CopActionShoot, "update", "update_sss", function (self, t)
	if not alive(self._glare_bitmap) then
		return
	end

	if self:_is_local_player_target_and_verified() then
		local screen_pos = managers.hud._workspace:world_to_screen(managers.viewport:get_current_camera(), self._shoot_from_pos)
		self._glare_bitmap:set_center(screen_pos.x, screen_pos.y)
		self:_set_glare_alpha(screen_pos.z >= 0 and 0.3 or 0)
	else
		self:_set_glare_alpha(0)
	end
end)
