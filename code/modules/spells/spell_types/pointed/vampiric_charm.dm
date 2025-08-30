/datum/action/cooldown/spell/vampiric_charm
	name = "Vampiric Charm"
	desc = "Captivate a target and prevent them from moving."
	button_icon_state = "love"
	sound = 'sound/magic/whiteflame.ogg'
	self_cast_possible = FALSE

	cast_range = 4
	spell_type = SPELL_BLOOD
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/blood

	invocation = "Experiamur vim amoris!"
	invocation_type = INVOCATION_SHOUT

	charge_time = 6 SECONDS
	charge_drain = 1
	charge_slowdown = 1.3
	cooldown_time = 2 MINUTES
	spell_cost = 0

/datum/action/cooldown/spell/vampiric_charm/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return FALSE
	return isliving(cast_on)

/datum/action/cooldown/spell/vampiric_charm/cast(mob/living/cast_on)
	. = ..()
	var/charm_to_public = pick("<b style='color:pink'>[owner] is influenced by the beauty of the person standing infront of them.</b>", "<b style='color:pink'>[cast_on] stares mesmerized at [owner] and does not move.</b>")
	var/charm_to_target = pick("<b style='color:pink'>Your eyes cannot move away from [owner].</b>", "<b style='color:pink'>You are enchanted by the beauty of the person standing infront of you.</b>")
	cast_on.visible_message(span_warning("[charm_to_public]"), span_warning("[charm_to_target]"))
	cast_on.Immobilize(85)

