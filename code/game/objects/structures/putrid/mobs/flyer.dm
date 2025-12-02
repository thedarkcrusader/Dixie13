/mob/living/simple_animal/hostile/retaliate/meatvine/flyer
	icon_state = "bloodling_stage_2"
	icon_living = "bloodling_stage_2"
	icon_dead = "bloodling_stage_2_dead"

	movement_type = FLYING

	tether_distance = 11
	possible_evolutions = list()

	structures = list(
		/datum/action/cooldown/meatvine/spread_tracking_beacon,
	)

	personal_abilities = list(
		/datum/action/cooldown/meatvine/personal/drain_well,
		/datum/action/cooldown/meatvine/personal/lunge,
		/datum/action/cooldown/meatvine/personal/evade,
	)
