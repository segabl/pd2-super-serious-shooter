SuperSeriousShooter:difficulty_tweak(PlayerTweakData, function (self)
	self.damage.LIVES_INIT = 5
	self.damage.MIN_DAMAGE_INTERVAL = 0.05
	self.damage.REVIVE_HEALTH_STEPS = { 0.8, 0.6, 0.4, 0.2 }

	self.movement_state.stamina.JUMP_STAMINA_DRAIN = 10

	self.suppression.max_value = 5
	self.suppression.receive_mul = 1
	self.suppression.tolerance = 0
end)
