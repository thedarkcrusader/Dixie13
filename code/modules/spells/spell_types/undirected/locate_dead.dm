/datum/action/cooldown/spell/undirected/locate_dead
	name = "Locate Corpse"
	desc = ""
	button_icon_state = "speakwithdead"
	sound = 'sound/magic/churn.ogg'

	spell_type = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	required_items = list(/obj/item/clothing/neck/psycross/silver/necra)

	invocation = "Undermaiden guide my hand to those who have lost their way."
	invocation_type = INVOCATION_SHOUT

	charge_required = FALSE
	cooldown_time = 240 SECONDS // This should not be spammed
	spell_cost = 100

	var/no_corpses = FALSE
	var/datum/weakref/corpseref


/datum/action/cooldown/spell/undirected/locate_dead/before_cast(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return

	var/list/mob/corpses = list()
	for(var/mob/living/C in GLOB.dead_mob_list)
		if(!C.mind || !is_in_zweb(C.z, owner.z))
			continue

		var/time_dead = 0
		if(C.timeofdeath)
			time_dead = world.time - C.timeofdeath
		var/corpse_name = ""

		if(time_dead < 5 MINUTES)
			corpse_name = "Fresh corpse "
		else if(time_dead < 10 MINUTES)
			corpse_name = "Recently deceased "
		else if(time_dead < 30 MINUTES)
			corpse_name = "Long dead "
		else
			corpse_name = "Forgotten remains of "

		corpse_name += " [copytext(C.name, 1, 2)]..."
		corpses[corpse_name] = C


	if(!length(corpses))
		to_chat(owner, span_warning("The Undermaiden's grasp lets slip."))
		StartCooldown() // Meant to punish templars
		return . | SPELL_CANCEL_CAST

	var/mob/selected
	selected = browser_input_list(owner, "Which body shall I seek?", "Available Bodies", corpses)


	if(QDELETED(src) || QDELETED(owner) || QDELETED(corpses[selected]) || !can_cast_spell())
		to_chat(owner, span_warning("The Undermaiden's grasp lets slip."))
		return . | SPELL_CANCEL_CAST


	corpseref = WEAKREF(corpses[selected])

/datum/action/cooldown/spell/undirected/locate_dead/cast(atom/cast_on)
	. = ..()
	var/mob/dead/corpse = corpseref.resolve()
	if(QDELETED(corpse))
		return

	var/direction = get_dir(owner, corpse)
	var/direction_name = "unknown"
	switch(direction)
		if(NORTH)
			direction_name = "north"
		if(SOUTH)
			direction_name = "south"
		if(EAST)
			direction_name = "east"
		if(WEST)
			direction_name = "west"
		if(NORTHEAST)
			direction_name = "northeast"
		if(NORTHWEST)
			direction_name = "northwest"
		if(SOUTHEAST)
			direction_name = "southeast"
		if(SOUTHWEST)
			direction_name = "southwest"

	to_chat(owner, span_notice("The Undermaiden pulls on your hand, guiding you [direction_name]."))

