/mob/living/simple_animal/hostile/retaliate/meatvine/spawnlord
	icon_state = "bloodling_stage_4"
	icon_living = "bloodling_stage_4"
	icon_dead = "bloodling_stage_4_dead"

	possible_evolutions = list()

	structures = list(
		/datum/action/cooldown/meatvine/spread_wormhole,
		/datum/action/cooldown/meatvine/spread_lair,
		/datum/action/cooldown/meatvine/spread_wall_multi,
	)

	personal_abilities = list(
		/datum/action/cooldown/meatvine/personal/drain_well,
		/datum/action/cooldown/meatvine/personal/lunge,
		/datum/action/cooldown/meatvine/personal/transfer_resources/improved,
		/datum/action/cooldown/meatvine/personal/mark_target,
	)
