/datum/action/cooldown/spell/undirected/bandit_call
	name = "Bandit Call"
	desc = "Rally the Free Men."
	button_icon_state = "message"

	spell_type = NONE
	charge_required = FALSE
	sound = null
	has_visual_effects = FALSE

	charge_required = FALSE
	cooldown_time = 2 MINUTES
	var/bandit_callout

/datum/action/cooldown/spell/undirected/bandit_call/before_cast(atom/cast_on)
	. = ..()
	owner.visible_message(
		span_notice("[owner] cup's their hand over their own mouth, their hand emitting a slight magickal glow."),
		span_notice("I cover my mouth, readying myself to muffle my call to those nearby."),
	)

	if(. & SPELL_CANCEL_CAST)
		return
	bandit_callout = browser_input_text(owner, "What do I tell the Free Men?", "Bandit Call")
	if(QDELETED(src) || QDELETED(cast_on) || !can_cast_spell())
		return . | SPELL_CANCEL_CAST
	if(!bandit_callout)
		reset_cooldown()
		return . | SPELL_CANCEL_CAST

/datum/action/cooldown/spell/undirected/bandit_call/cast(atom/cast_on)
	. = ..()
	owner.visible_message(
		span_notice("[owner]'s hand glows a bright yellow for a moment before calmly dissipating."),
		span_notice("I conceal the message and send it out to the Free Men."),
	)
	for(var/mob/living/carbon/human/HL in GLOB.human_list)
		if(!HL.mind)
			continue
		if (HL.mind?.has_antag_datum(/datum/antagonist/bandit))
			to_chat(HL, span_reallybig("[bandit_callout]"))
