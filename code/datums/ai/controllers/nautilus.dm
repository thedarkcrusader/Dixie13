/datum/ai_controller/nautilus
	movement_delay = 0.3 SECONDS
	ai_movement = /datum/ai_movement/hybrid_pathing
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic/allow_items()
	)
	planning_subtrees = list(
		///datum/ai_planning_subtree/flee_target,
		/datum/ai_planning_subtree/aggro_find_target,
		/datum/ai_planning_subtree/targeted_mob_ability/nautilus_grab,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,

		///datum/ai_planning_subtree/flee_target/dragger,
		///datum/ai_planning_subtree/basic_melee_attack_subtree/nautilus_smash,
		///datum/ai_planning_subtree/dragger_drag_victim,

		///datum/ai_planning_subtree/find_dead_bodies,
		///datum/ai_planning_subtree/eat_dead_body,

		///datum/ai_planning_subtree/find_water,
	)
	idle_behavior = /datum/idle_behavior/nothing

/datum/ai_planning_subtree/targeted_mob_ability/nautilus_grab
	ability_key = BB_TARGETED_ACTION
	finish_planning = FALSE

/datum/ai_planning_subtree/basic_melee_attack_subtree/nautilus_smash
