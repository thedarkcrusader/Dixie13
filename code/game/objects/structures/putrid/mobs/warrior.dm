/mob/living/simple_animal/hostile/retaliate/meatvine/warrior
	icon_state = "turret"
	icon_living = "turret"
	icon_dead = "turret_destroyed"

	possible_evolutions = list()

	personal_abilities = list(
		/datum/action/cooldown/meatvine/personal/drain_well,
		/datum/action/cooldown/meatvine/personal/slicing_sweep,
		/datum/action/cooldown/meatvine/personal/literally_too_angry_to_die,
		/datum/action/cooldown/meatvine/personal/charge_slash,
		/datum/action/cooldown/meatvine/personal/ranged/spread,
	)
