/obj/structure/dryclothes
	name = "a place to dry clothes."
	desc = "This seems like a nice place to dry some clothes."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "dryclothes"
	max_integrity = 200
	density = TRUE
	climbable = TRUE
	anchored = TRUE
	blade_dulling = DULLING_BASHCHOP
	destroy_sound = 'sound/combat/hits/onwood/destroyfurniture.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	var/drying_timer
	var/has_wet_items = FALSE

/obj/structure/dryclothes/Initialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/grid/drying_rack)

	RegisterSignal(src, COMSIG_STORAGE_ADDED, PROC_REF(on_item_stored))
	RegisterSignal(src, COMSIG_STORAGE_REMOVED, PROC_REF(on_item_removed))


/obj/structure/dryclothes/Destroy()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))
	return ..()

/obj/structure/dryclothes/proc/on_item_stored(datum/source, obj/item/I)
	if(!drying_timer && !has_wet_items)
		// Start loop
		drying_timer = addtimer(CALLBACK(src, PROC_REF(process_drying)), 10 SECONDS, TIMER_STOPPABLE)
	nobles_seen_servant_work(usr)


/obj/structure/dryclothes/proc/on_item_removed(datum/source, obj/item/I)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(!STR)
		return
	if(!length(STR.contents()))
		if(drying_timer)
			drying_timer = null
	nobles_seen_servant_work(usr)

/obj/structure/dryclothes/proc/process_drying()

	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(!STR)
		return

	has_wet_items = FALSE
	for(var/obj/item/clothing/C in STR.contents())
		var/datum/component/wet/W = C.GetComponent(/datum/component/wet)
		if(!W)
			continue
		var/old_wet = W.water_stacks
		SEND_SIGNAL(C, COMSIG_ATOM_WATER_USE, 5)
		if(old_wet < 0 && W.water_stacks == 0 && !W.dirty_water && W.washed)
			C.proper_drying = TRUE
			C.AddComponent(/datum/component/particle_spewer/sparkle)
		else if(old_wet < 0 && W.water_stacks == 0 && W.dirty_water)
			W.dirty_water = FALSE

		if(W.water_stacks < 0)
			has_wet_items = TRUE
	// Reschedule only if we still have wet items
	if(has_wet_items)
		drying_timer = addtimer(CALLBACK(src, PROC_REF(process_drying)), 10 SECONDS, TIMER_STOPPABLE)
	else
		drying_timer = null

/proc/nobles_seen_servant_work(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = usr
		if(!is_servant_job(H.mind.assigned_role))
			return
	else
		return

	var/list/nobles = list()
	for(var/mob/living/carbon/human/target in viewers(6, user))
		if(!target.mind || target.stat != CONSCIOUS)
			continue
		if(!HAS_TRAIT(target, TRAIT_NOBLE))
			continue
		nobles += target
	if(length(nobles))
		for(var/mob/living/carbon/human/target in nobles)
			if(!target.has_stress_type(/datum/stress_event/noble_seen_servant_work))
				target.add_stress(/datum/stress_event/noble_seen_servant_work)