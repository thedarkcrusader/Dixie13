//mix of wolf and saiga ai
/datum/ai_controller/lampreywolf
	movement_delay = 0.2 SECONDS

	ai_movement = /datum/ai_movement/hybrid_pathing

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic(),
		BB_PET_TARGETING_DATUM = new /datum/targetting_datum/basic/not_friends(),
		BB_BASIC_MOB_FLEEING = TRUE,
		BB_LAMPREYWOLF_NEXTATTACKING = 0,
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/pet_planning,
		/datum/ai_planning_subtree/aggro_find_target,
		/datum/ai_planning_subtree/lampreywolf_attack,
		/datum/ai_planning_subtree/flee_target/lampreywolf,
		)

	idle_behavior = /datum/idle_behavior/idle_random_walk

/datum/ai_controller/lampreywolf/TryPossessPawn(atom/new_pawn)
	. = ..()
	RegisterSignal(new_pawn, COMSIG_ANIMAL_TAMED, PROC_REF(on_user_tamed))

/datum/ai_controller/lampreywolf/UnpossessPawn(destroy)
	UnregisterSignal(pawn, COMSIG_ANIMAL_TAMED)
	. = ..()

/datum/ai_controller/lampreywolf/proc/on_user_tamed()
	movement_delay = 0.3 SECONDS
	set_blackboard_key(BB_BASIC_MOB_FLEEING, FALSE)
	idle_behavior = null


/datum/ai_planning_subtree/flee_target/lampreywolf
	flee_behaviour = /datum/ai_behavior/run_away_from_target/lampreywolf

/datum/ai_planning_subtree/flee_target/lampreywolf/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	if(!controller.blackboard[bb_key])
		return
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return
	if(controller.blackboard[BB_BASIC_MOB_NEXT_FLEEING])
		controller.queue_behavior(flee_behaviour, target_key, hiding_place_key)
		return SUBTREE_RETURN_FINISH_PLANNING //we are going into battle...no distractions.

/datum/ai_planning_subtree/lampreywolf_attack

/datum/ai_planning_subtree/lampreywolf_attack/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(QDELETED(target))
		return
	controller.queue_behavior(/datum/ai_behavior/lampreywolf_melee_attack, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)
	return SUBTREE_RETURN_FINISH_PLANNING //we are going into battle...no distractions.
