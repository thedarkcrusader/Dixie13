/datum/action/cooldown/spell/undirected/matronwrath
	name = "FAILURE"
	desc = "Any Attacks I do against those brats will be unavoidable."
	button_icon_state = "blindness"
	sound = 'sound/magic/barbroar.ogg'

	antimagic_flags = NONE

	associated_skill = /datum/skill/combat/wrestling
	associated_stat = STATKEY_SPD

	charge_required = FALSE
	has_visual_effects = FALSE
	cooldown_time = 3 MINUTES
	spell_type = SPELL_STAMINA
	spell_cost = 10

/datum/action/cooldown/spell/undirected/matronwrath/cast(mob/living/cast_on)
	. = ..()
	for(var/mob/living/carbon/target in viewers(10, get_turf(owner)))
		if(HAS_TRAIT(target, TRAIT_ORPHAN))
			to_chat(target, span_danger("You feel a sense of dread."))
			target.apply_status_effect(/datum/status_effect/debuff/markedorphan)
	cast_on.apply_status_effect(/datum/status_effect/buff/matronwrath)
