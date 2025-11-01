/datum/ai_controller/nautilus
	movement_delay = 0.3 SECONDS
	ai_movement = /datum/ai_movement/hybrid_pathing
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic(),
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/aggro_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/nautilus_grab,
	)
	idle_behavior = /datum/idle_behavior/nothing

/datum/ai_planning_subtree/basic_melee_attack_subtree/nautilus_grab
	melee_attack_behavior = /datum/ai_behavior/basic_melee_attack/nautilus_grab
