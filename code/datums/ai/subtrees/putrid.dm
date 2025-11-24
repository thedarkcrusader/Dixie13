
/datum/ai_planning_subtree/papameat_sacrifice

/datum/ai_planning_subtree/papameat_sacrifice/SelectBehaviors(datum/ai_controller/controller, delta_time)
	var/obj/structure/meatvine/papameat/papameat = controller.blackboard[BB_PAPAMEAT_TARGET]

	if(!papameat || QDELETED(papameat))
		controller.clear_blackboard_key(BB_PAPAMEAT_TARGET)
		controller.clear_blackboard_key(BB_PAPAMEAT_HEALING)
		return

	// Check if papameat is critical
	var/integrity_percent = papameat.get_integrity_percentage()
	if(integrity_percent >= PAPAMEAT_CRITICAL_HEALTH)
		return // Not critical, don't sacrifice

	// Check if another mob is already healing
	if(controller.blackboard[BB_PAPAMEAT_HEALING])
		return // We're already on our way

	// Check if another mob is close enough and also healing
	for(var/mob/living/simple_animal/nearby in range(10, papameat))
		if(nearby == controller.pawn)
			continue
		var/datum/ai_controller/nearby_ai = nearby.ai_controller
		if(nearby_ai?.blackboard[BB_PAPAMEAT_HEALING])
			return // Someone else is already sacrificing

	controller.queue_behavior(/datum/ai_behavior/papameat_sacrifice, BB_PAPAMEAT_TARGET)
	return SUBTREE_RETURN_FINISH_PLANNING



/datum/ai_planning_subtree/papameat_feed_corpse

/datum/ai_planning_subtree/papameat_feed_corpse/SelectBehaviors(datum/ai_controller/controller, delta_time)
	// Don't try to feed if we're in combat or healing
	if(controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET])
		return
	if(controller.blackboard[BB_PAPAMEAT_HEALING])
		return

	// Already feeding something
	if(controller.blackboard[BB_FEEDING_CORPSE])
		controller.queue_behavior(/datum/ai_behavior/papameat_feed_corpse, BB_CORPSE_TO_FEED)
		return SUBTREE_RETURN_FINISH_PLANNING

	// Look for nearby corpses
	var/mob/living/our_mob = controller.pawn
	var/obj/structure/meatvine/papameat/nearest_papameat = null
	var/min_dist = INFINITY

	// Find nearest papameat
	for(var/obj/structure/meatvine/papameat/PM in range(30, our_mob))
		var/dist = get_dist(our_mob, PM)
		if(dist < min_dist)
			min_dist = dist
			nearest_papameat = PM

	if(!nearest_papameat)
		return

	// Find corpses
	for(var/mob/living/corpse in view(10, our_mob))
		if(corpse == our_mob)
			continue
		if(corpse.stat != DEAD)
			continue
		if(corpse.buckled)
			continue // Already being dragged

		controller.set_blackboard_key(BB_CORPSE_TO_FEED, corpse)
		controller.set_blackboard_key(BB_PAPAMEAT_TARGET, nearest_papameat)
		controller.queue_behavior(/datum/ai_behavior/papameat_feed_corpse, BB_CORPSE_TO_FEED)
		return SUBTREE_RETURN_FINISH_PLANNING


/datum/ai_planning_subtree/papameat_defend

/datum/ai_planning_subtree/papameat_defend/SelectBehaviors(datum/ai_controller/controller, delta_time)
	var/obj/structure/meatvine/papameat/papameat = controller.blackboard[BB_PAPAMEAT_TARGET]

	if(!papameat || QDELETED(papameat))
		return

	// Don't defend if we're sacrificing or feeding
	if(controller.blackboard[BB_PAPAMEAT_HEALING])
		return
	if(controller.blackboard[BB_FEEDING_CORPSE])
		return

	controller.queue_behavior(/datum/ai_behavior/papameat_defend, BB_PAPAMEAT_TARGET)

