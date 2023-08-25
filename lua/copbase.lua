Hooks:PreHook(CopBase, "post_init", "post_init_sss", function (self)
	self._default_weapon_id = self._tweak_table == "shield" and "c45" or self._default_weapon_id
end)
