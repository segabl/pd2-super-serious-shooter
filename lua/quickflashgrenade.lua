function QuickFlashGrenade:_beep() end

Hooks:PostHook(QuickFlashGrenade, "_state_bounced", "_state_bounced_sss", QuickFlashGrenade.remove_light)
