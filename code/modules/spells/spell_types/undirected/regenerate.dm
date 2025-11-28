/datum/action/cooldown/spell/undirected/regenerate
	name = "Regenerate"
	desc = "Your wounds painfully mend back together."
	button_icon_state = "bloodrage"
	sound = 'sound/misc/vampirespell.ogg'

	antimagic_flags = NONE

	associated_skill = /datum/skill/combat/unarmed
	associated_stat = STATKEY_CON

	charge_required = FALSE
	has_visual_effects = FALSE
	cooldown_time = 1 MINUTES
	spell_type = SPELL_STAMINA
	spell_cost = 10

/datum/action/cooldown/spell/undirected/regenerate/cast(mob/living/cast_on)
	. = ..()
	cast_on.emote("agony", forced = TRUE)
	cast_on.fully_heal()
	cast_on.regenerate_limbs()
	cast_on.regenerate_organs()
	cast_on.Jitter(1)
	cast_on.visible_message(span_notice("[cast_on]'s body painfully contorts itself back together"))

