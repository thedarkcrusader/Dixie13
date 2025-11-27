
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


/datum/ai_behavior/meatvine_bridge
	action_cooldown = 0.5 SECONDS
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/meatvine_bridge/setup(datum/ai_controller/controller, bridge_key)
	. = ..()
	var/datum/bridge_request/request = controller.blackboard[bridge_key]

	if(!request || !request.target_location)
		return FALSE

	controller.set_blackboard_key(BB_BRIDGING, TRUE)
	set_movement_target(controller, request.target_location)

/datum/ai_behavior/meatvine_bridge/perform(delta_time, datum/ai_controller/controller, bridge_key)
	. = ..()
	var/mob/living/simple_animal/our_mob = controller.pawn
	var/datum/bridge_request/request = controller.blackboard[bridge_key]

	if(!request || !request.target_location)
		finish_action(controller, FALSE, bridge_key)
		return

	// Check if we've reached the target
	if(get_turf(our_mob) == request.target_location)
		// Try to spread here
		attempt_bridge_spread(our_mob, request)
		finish_action(controller, TRUE, bridge_key)
		return

	// Check if we're close enough (adjacent)
	if(get_dist(our_mob, request.target_location) <= 1)
		// Try to spread from adjacent position
		attempt_bridge_spread(our_mob, request)
		finish_action(controller, TRUE, bridge_key)
		return

/datum/ai_behavior/meatvine_bridge/proc/attempt_bridge_spread(mob/living/simple_animal/our_mob, datum/bridge_request/request)
	// Find the nearest vine to spread from
	var/obj/structure/meatvine/nearest_vine = null
	var/min_dist = INFINITY

	for(var/obj/structure/meatvine/SV in range(3, request.target_location))
		if(SV.master)
			var/dist = get_dist(SV, request.target_location)
			if(dist < min_dist)
				min_dist = dist
				nearest_vine = SV

	if(nearest_vine && nearest_vine.master)
		// Create a new vine at the target location
		var/obj/structure/meatvine/vine = locate(/obj/structure/meatvine) in request.target_location
		if(vine)
			return FALSE
		nearest_vine.master.spawn_spacevine_piece(request.target_location)

		// Visual feedback
		request.target_location.pollute_turf(/datum/pollutant/rot, 30)

/datum/ai_behavior/meatvine_bridge/finish_action(datum/ai_controller/controller, succeeded, bridge_key)
	. = ..()
	if(succeeded)
		var/mob/living/simple_animal/hostile/retaliate/meatvine/mob = controller.pawn
		var/datum/bridge_request/request = controller.blackboard[BB_BRIDGE_TARGET]
		mob.master.blocked_spread_locations -= request
	controller.clear_blackboard_key(BB_BRIDGING)
	controller.clear_blackboard_key(BB_BRIDGE_TARGET)

/datum/ai_behavior/meatvine_destroy_obstacle
	action_cooldown = 0.5 SECONDS
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/meatvine_destroy_obstacle/setup(datum/ai_controller/controller, obstacle_key)
	. = ..()
	var/atom/obstacle = controller.blackboard[obstacle_key]

	if(!obstacle || QDELETED(obstacle))
		return FALSE

	controller.set_blackboard_key(BB_ATTACKING_OBSTACLE, TRUE)
	set_movement_target(controller, obstacle)

/datum/ai_behavior/meatvine_destroy_obstacle/perform(delta_time, datum/ai_controller/controller, obstacle_key)
	. = ..()
	var/mob/living/simple_animal/our_mob = controller.pawn
	var/atom/obstacle = controller.blackboard[obstacle_key]

	if(!obstacle || QDELETED(obstacle))
		finish_action(controller, FALSE, obstacle_key)
		return

	// Check if obstacle still blocks spreading
	if(!is_blocking_obstacle(obstacle))
		finish_action(controller, TRUE, obstacle_key)
		return

	// Check if we're close enough to attack
	if(get_dist(our_mob, obstacle) <= 1)
		// Attack the obstacle
		our_mob.face_atom(obstacle)
		obstacle.attack_animal(our_mob)

		// Check if it's destroyed
		if(QDELETED(obstacle))
			finish_action(controller, TRUE, obstacle_key)
			return
	else
		// Keep moving toward it
		set_movement_target(controller, obstacle)

/datum/ai_behavior/meatvine_destroy_obstacle/proc/is_blocking_obstacle(atom/A)
	// Check if this atom blocks vine spreading
	if(istype(A, /obj/structure))
		var/obj/structure/S = A
		if(S.density)
			return TRUE
	if(istype(A, /obj/machinery))
		var/obj/machinery/M = A
		if(M.density)
			return TRUE
	return FALSE

/datum/ai_behavior/meatvine_destroy_obstacle/finish_action(datum/ai_controller/controller, succeeded, obstacle_key)
	. = ..()
	controller.clear_blackboard_key(BB_ATTACKING_OBSTACLE)

	if(succeeded)
		controller.clear_blackboard_key(BB_OBSTACLE_TARGET)

		// Notify controller that obstacle was destroyed
		var/mob/living/simple_animal/our_mob = controller.pawn
		for(var/obj/structure/meatvine/SV in range(10, our_mob))
			if(SV.master)
				var/atom/obstacle = controller.blackboard[obstacle_key]
				SV.master.check_obstacle_destroyed(obstacle)
				break
