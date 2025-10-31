/datum/action/cooldown/spell/aoe/repulse/howl
	name = "Terrifying Howl"
	desc = "Let loose a howl of dread, repelling anyone around you."
	button_icon_state = "howl"

	spell_type = SPELL_RAGE

	invocation_type = INVOCATION_NONE
	aoe_radius = 2

	has_visual_effects = FALSE
	click_to_activate = FALSE
	cooldown_time = 50 SECONDS
	spell_flags = SPELL_RITUOS
	spell_cost = 25
	charge_required = FALSE
	sound = 'sound/vo/mobs/wwolf/roar.ogg'

/datum/action/cooldown/spell/aoe/repulse/howl/is_valid_target(atom/cast_on)
	return isliving(cast_on)
