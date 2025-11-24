/mob/living/simple_animal/hostile/retaliate/meatvine
	name = "Horrible creature"
	desc = "What is that?!"
	icon = 'icons/obj/cellular/meat.dmi'
	icon_state = "bloodling_stage_1"
	icon_living = "bloodling_stage_1"
	icon_dead = "bloodling_stage_1_dead"
	faction = list("meat")
	health = 60
	maxHealth = 60
	//melee_damage = 25
	//move_speed = 0
	see_in_dark = 10

	environment_smash = TRUE
	//search_objects = 1
	//wanted_objects = list(/obj/machinery/light, /obj/machinery/light/small, /obj/machinery/light/smart, /obj/machinery/bot/secbot/beepsky, /obj/machinery/camera)

	stat_attack = 1

	ai_controller = /datum/ai_controller/meatvine_defender

	pass_flags = PASSTABLE

/mob/living/simple_animal/hostile/retaliate/meatvine/Destroy()
	puff_gas()
	var/turf/turf = get_turf(src)
	turf.pollute_turf(/datum/pollutant/steam, 100)

	turf.add_liquid(/datum/reagent/blood, 20)

	return ..()

/mob/living/simple_animal/hostile/retaliate/meatvine/death()
	puff_gas()


	QDEL_IN(src, rand(60, 120) SECONDS)

	return ..()

/mob/living/simple_animal/hostile/retaliate/meatvine/proc/puff_gas()
	if(!prob(50))
		return

	var/turf/turf = get_turf(src)
	turf.pollute_turf(/datum/pollutant/rot, 100)
	return


/mob/living/simple_animal/hostile/retaliate/meatvine/range
	icon_state = "harvester"
	icon_living = "harvester"
	icon_dead = "harvester_dead"
	ranged = TRUE
	projectiletype = /obj/projectile/meatbullet

	minimum_distance = 2
