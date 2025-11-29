/mob/living/simple_animal/hostile/retaliate/meatvine/broodmother
	icon_state = "bloodling_stage_4"
	icon_living = "bloodling_stage_4"
	icon_dead = "bloodling_stage_4_dead"

	possible_evolutions = list()

	structures = list(
		/datum/action/cooldown/meatvine/spread_healing_well,
		/datum/action/cooldown/meatvine/spread_wormhole,
	)

	personal_abilities = list(
		/datum/action/cooldown/meatvine/personal/drain_well,
		/datum/action/cooldown/meatvine/personal/repair_walls,
	)
