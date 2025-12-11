/datum/action/cooldown/spell/undirected/seek_prisoner
	name = "Seek Prisoner"
	desc = "Sniff the air, and find my prey."
	sound = null

	spell_type = NONE
	charge_required = FALSE
	has_visual_effects = FALSE

	charge_required = FALSE
	cooldown_time = 60 SECONDS

/datum/action/cooldown/spell/undirected/seek_prisoner/cast(atom/cast_on)
	. = ..()
	var/list/prisoners = list()
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(!H.mind)
			continue
		if(!HAS_TRAIT(H, TRAIT_PRISONER))
			continue
		prisoners += H

	if(!length(prisoners))
		to_chat(owner, span_red("There aren't any prisoners."))
		return

	var/mob/prisoner = browser_input_list(owner, "Which Bastard?", "Smell Prisoner", prisoners)
	if(QDELETED(src) || QDELETED(cast_on) || QDELETED(prisoner) || !can_cast_spell())
		return

	to_chat(owner, span_notice("I smell them. That piece of shit is [where_prisoner(prisoner)]."))

/datum/action/cooldown/spell/undirected/seek_prisoner/proc/where_prisoner(mob/living/carbon/human/tracked_prisoner)
	if(!owner || !tracked_prisoner)
		return

	var/our_z = owner.z
	var/their_z = tracked_prisoner.z
	var/dist = get_dist(owner, tracked_prisoner)
	var/dir = get_dir(owner, tracked_prisoner)
	var/dir_text = dir2text(dir)
	var/distance_text

	switch(dist)
		if(0 to 7)
			distance_text = "very close"
		if(8 to 15)
			distance_text = "close"
		if(16 to 35)
			distance_text = "near"
		if(36 to 49)
			distance_text = "somewhat near"
		if(50 to 70)
			distance_text = "slightly far"
		if(71 to 98)
			distance_text = "somewhat far"
		if(99 to 127)
			distance_text = "far"
		else
			distance_text = "very far"

	var/z_text = null
	if(our_z != their_z)
		z_text = ", [our_z > their_z ? "below me" : "above me"]"

	return "[distance_text]... and to the [dir_text][z_text]."
