
/datum/ai_behavior/papameat_sacrifice
	action_cooldown = 0.5 SECONDS
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/papameat_sacrifice/setup(datum/ai_controller/controller, papameat_key)
	. = ..()
	var/obj/structure/meatvine/papameat/papameat = controller.blackboard[papameat_key]

	if(!papameat || QDELETED(papameat))
		return FALSE

	controller.set_blackboard_key(BB_PAPAMEAT_HEALING, TRUE)
	set_movement_target(controller, papameat)

/datum/ai_behavior/papameat_sacrifice/perform(delta_time, datum/ai_controller/controller, papameat_key)
	. = ..()
	var/mob/living/simple_animal/our_mob = controller.pawn
	var/obj/structure/meatvine/papameat/papameat = controller.blackboard[papameat_key]

	if(!papameat || QDELETED(papameat))
		finish_action(controller, FALSE, papameat_key)
		return

	// Check if we're close enough to sacrifice
	if(get_dist(our_mob, papameat) <= PAPAMEAT_SACRIFICE_RANGE)
		papameat.sacrifice_living_mob(our_mob)
		finish_action(controller, TRUE, papameat_key)
		return

	// Keep moving toward papameat
	our_mob.face_atom(papameat)

/datum/ai_behavior/papameat_sacrifice/finish_action(datum/ai_controller/controller, succeeded, papameat_key)
	. = ..()
	controller.clear_blackboard_key(BB_PAPAMEAT_HEALING)
	if(succeeded)
		controller.clear_blackboard_key(BB_PAPAMEAT_TARGET)


/datum/ai_behavior/papameat_feed_corpse
	action_cooldown = 0.5 SECONDS
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/papameat_feed_corpse/setup(datum/ai_controller/controller, corpse_key)
	. = ..()
	var/mob/living/corpse = controller.blackboard[corpse_key]

	if(!corpse || QDELETED(corpse) || corpse.stat != DEAD)
		return FALSE

	controller.set_blackboard_key(BB_FEEDING_CORPSE, TRUE)
	set_movement_target(controller, corpse)

/datum/ai_behavior/papameat_feed_corpse/perform(delta_time, datum/ai_controller/controller, corpse_key)
	. = ..()
	var/mob/living/simple_animal/our_mob = controller.pawn
	var/mob/living/corpse = controller.blackboard[corpse_key]
	var/obj/structure/meatvine/papameat/papameat = controller.blackboard[BB_PAPAMEAT_TARGET]

	if(!corpse || QDELETED(corpse) || corpse.stat != DEAD)
		finish_action(controller, FALSE, corpse_key)
		return

	if(!papameat || QDELETED(papameat))
		finish_action(controller, FALSE, corpse_key)
		return

	// If corpse is buckled to us, drag to papameat
	if(corpse.buckled == our_mob)
		if(get_dist(our_mob, papameat) <= 1)
			// We're at the papameat, feed it
			corpse.unbuckle_mob(TRUE)
			papameat.consume_mob(corpse)
			finish_action(controller, TRUE, corpse_key)
			return
		else
			// Keep dragging
			set_movement_target(controller, papameat)
			return

	// Try to grab the corpse
	if(get_dist(our_mob, corpse) <= 1)
		if(corpse.buckled)
			finish_action(controller, FALSE, corpse_key) // Someone else got it
			return

		// Buckle corpse to us (drag it)
		our_mob.buckle_mob(corpse, TRUE)
		set_movement_target(controller, papameat)

/datum/ai_behavior/papameat_feed_corpse/finish_action(datum/ai_controller/controller, succeeded, corpse_key)
	. = ..()
	controller.clear_blackboard_key(BB_FEEDING_CORPSE)
	controller.clear_blackboard_key(BB_CORPSE_TO_FEED)

	// Unbuckle if still dragging
	var/mob/living/simple_animal/our_mob = controller.pawn
	if(our_mob?.buckled_mobs?.len)
		for(var/mob/M in our_mob.buckled_mobs)
			M.unbuckle_mob(TRUE)


/datum/ai_behavior/papameat_defend
	action_cooldown = 0.5 SECONDS
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/papameat_defend/setup(datum/ai_controller/controller, papameat_key)
	. = ..()
	var/obj/structure/meatvine/papameat/papameat = controller.blackboard[papameat_key]

	if(!papameat || QDELETED(papameat))
		return FALSE

	set_movement_target(controller, papameat)

/datum/ai_behavior/papameat_defend/perform(delta_time, datum/ai_controller/controller, papameat_key)
	. = ..()
	var/mob/living/simple_animal/our_mob = controller.pawn
	var/obj/structure/meatvine/papameat/papameat = controller.blackboard[papameat_key]

	if(!papameat || QDELETED(papameat))
		finish_action(controller, FALSE, papameat_key)
		return

	// Move toward papameat
	if(get_dist(our_mob, papameat) > 7)
		set_movement_target(controller, papameat)
	else
		// We're close enough, patrol around it
		finish_action(controller, TRUE, papameat_key)

/datum/ai_behavior/papameat_defend/finish_action(datum/ai_controller/controller, succeeded, papameat_key)
	. = ..()
	if(!succeeded)
		controller.clear_blackboard_key(BB_PAPAMEAT_TARGET)
