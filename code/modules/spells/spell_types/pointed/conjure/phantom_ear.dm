/datum/action/cooldown/spell/conjure/phantom_ear
	name = "Summon Phantom Ear"
	desc = "Creates a magical ear to listen in on distant sounds."
	button_icon_state = "phantomear"
	self_cast_possible = TRUE

	point_cost = 2

	has_visual_effects = FALSE
	charge_required = FALSE
	cooldown_time = 2 MINUTES
	spell_cost = 60
	spell_flags = SPELL_RITUOS
	invocation = "Lend me thine ear."
	invocation_type = INVOCATION_WHISPER

	var/obj/item/phantom_ear/current_ear

	summon_type = list(/obj/item/phantom_ear)
	summon_radius = 0
	summon_lifespan = 0

/datum/action/cooldown/spell/conjure/phantom_ear/Destroy()
	. = ..()
	QDEL_NULL(current_ear)

/datum/action/cooldown/spell/conjure/phantom_ear/post_summon(obj/item/phantom_ear/summoned_object)
	if(current_ear)
		to_chat(owner, span_notice("You close one ear to open another."))
		qdel(current_ear)
	else
		to_chat(owner, span_notice("You've conjured a phantom ear. You can hear through it as if you were there."))
	current_ear = summoned_object
	current_ear.setup(owner)
	return
