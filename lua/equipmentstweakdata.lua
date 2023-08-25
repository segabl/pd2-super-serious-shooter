Hooks:PostHook(EquipmentsTweakData, "init", "init_sss", function (self)
	self.trip_mine.quantity = { 4, 4 }
	self.ecm_jammer.quantity = { 2 }
	self.first_aid_kit.quantity = { 6 }
	self.specials.cable_tie.quantity = 9
end)
