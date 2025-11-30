/mob/living/simple_animal/hostile/retaliate/meatvine/defender
	icon_state = "turret"
	icon_living = "turret"
	icon_dead = "turret_destroyed"

	possible_evolutions = list(
		/mob/living/simple_animal/hostile/retaliate/meatvine/goliath,
		/mob/living/simple_animal/hostile/retaliate/meatvine/warrior,
	)

	personal_abilities = list(
		/datum/action/cooldown/meatvine/personal/drain_well,
		/datum/action/cooldown/meatvine/personal/literally_too_angry_to_die,
	)
