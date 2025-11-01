/datum/ai_behavior/basic_melee_attack/nautilus_grab
	action_cooldown = 0.5 SECONDS
	var/grapple_chance = 20 // Chance to perform a grapple on attack

/datum/ai_behavior/basic_melee_attack/nautilus_grab/perform(delta_time, datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	var/mob/living/simple_animal/hostile/retaliate/nautilus/nautilus_pawn = controller.pawn
	var/atom/target = controller.blackboard[target_key]

	if(!istype(nautilus_pawn) || QDELETED(target) || !isliving(target))
		return

	var/mob/living/L = target
	if(get_dist(nautilus_pawn, target) <= 1)
		perform_grab(controller, nautilus_pawn, L)


/datum/ai_behavior/basic_melee_attack/nautilus_grab/proc/perform_grab(datum/ai_controller/controller, mob/living/simple_animal/hostile/retaliate/nautilus/nautilus_pawn, mob/living/victim)
	for(var/obj/item/grabbing/G in victim.grabbedby)
		if(G.grabbee == nautilus_pawn)
			return
	if(prob(grapple_chance) && nautilus_pawn.start_pulling(victim, suppress_message = TRUE, accurate = TRUE))
		nautilus_pawn.visible_message(span_boldwarning("[nautilus_pawn] wraps their tentacles around [victim]!"))
		//nautilus_pawn.buckle_mob(victim, TRUE, check_loc = FALSE)
		victim.Immobilize(10)
