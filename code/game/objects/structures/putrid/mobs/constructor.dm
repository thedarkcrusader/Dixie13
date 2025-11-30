/mob/living/simple_animal/hostile/retaliate/meatvine/constructor
	icon_state = "bloodling_stage_4"
	icon_living = "bloodling_stage_4"
	icon_dead = "bloodling_stage_4_dead"

	possible_evolutions = list(
		/mob/living/simple_animal/hostile/retaliate/meatvine/broodmother,
		/mob/living/simple_animal/hostile/retaliate/meatvine/burrower,
		/mob/living/simple_animal/hostile/retaliate/meatvine/spawnlord,
	)

	structures = list(
		/datum/action/cooldown/meatvine/spread_wormhole,
	)

	personal_abilities = list(
		/datum/action/cooldown/meatvine/personal/drain_well,
		/datum/action/cooldown/meatvine/personal/mark_target,
	)
