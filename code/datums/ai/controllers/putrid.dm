/datum/ai_controller/meatvine_defender
	movement_delay = 0.5 SECONDS
	ai_movement = /datum/ai_movement/hybrid_pathing

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic/allow_items(),
		BB_PAPAMEAT_TARGET = null,
		BB_PAPAMEAT_HEALING = FALSE,
		BB_CORPSE_TO_FEED = null,
		BB_FEEDING_CORPSE = FALSE
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/papameat_sacrifice, // Highest priority
		/datum/ai_planning_subtree/papameat_feed_corpse,
		/datum/ai_planning_subtree/papameat_defend,
		/datum/ai_planning_subtree/flee_target,
		/datum/ai_planning_subtree/aggro_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

	idle_behavior = /datum/idle_behavior/idle_random_walk

/datum/ai_controller/meatvine_defender/New(atom/new_pawn)
	. = ..()

	// Register for papameat signals
	RegisterSignal(SSdcs, COMSIG_PAPAMEAT_DAMAGED, PROC_REF(on_papameat_damaged))
	RegisterSignal(SSdcs, COMSIG_PAPAMEAT_CRITICAL, PROC_REF(on_papameat_critical))

/datum/ai_controller/meatvine_defender/proc/on_papameat_damaged(datum/source, obj/structure/meatvine/papameat/damaged_papameat, integrity_percent)
	SIGNAL_HANDLER

	// Check if this is our papameat
	var/mob/living/our_mob = pawn
	if(!istype(our_mob))
		return

	// Find if we're part of this papameat's network
	var/obj/effect/meatvine_controller/controller = damaged_papameat.master
	if(!controller)
		return

	// Check distance - only respond if within range
	if(get_dist(our_mob, damaged_papameat) > 30)
		return

	set_blackboard_key(BB_PAPAMEAT_TARGET, damaged_papameat)

/datum/ai_controller/meatvine_defender/proc/on_papameat_critical(datum/source, obj/structure/meatvine/papameat/critical_papameat)
	SIGNAL_HANDLER

	var/mob/living/our_mob = pawn
	if(!istype(our_mob))
		return

	// Check if we should sacrifice ourselves
	if(get_dist(our_mob, critical_papameat) > 20)
		return

	set_blackboard_key(BB_PAPAMEAT_TARGET, critical_papameat)
