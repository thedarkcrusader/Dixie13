/obj/structure/meatvine/floor/Initialize()
	. = ..()

	icon_state = pick(list("tile_1", "tile_2", "tile_3", "tile_4"))

/obj/structure/meatvine/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir)
	. = ..()
	if(damage_type != BURN)
		transfer_feromones(3)

/obj/structure/meatvine/heavy
	icon = 'icons/obj/cellular/meat_wall.dmi'
	icon_state = "box"
	density = TRUE
	opacity = TRUE
	pass_flags = null


	max_integrity = 50
	resistance_flags = CAN_BE_HIT


/obj/structure/meatvine/heavy/CanPass(atom/movable/mover, turf/target)
	. = ..()
	return FALSE

/obj/structure/meatvine/heavy/CanAStarPass(ID, to_dir, requester)
	return FALSE


/obj/structure/meatvine/lair
	icon_state = "lair_1"
	density = FALSE
	opacity = FALSE
	pass_flags = null

	max_integrity = 30
	resistance_flags = CAN_BE_HIT

	var/mob/living/simple_animal/hostile/meatvine/Mob

/obj/structure/meatvine/lair/Initialize()
	. = ..()
	icon_state = pick(list("lair_1", "lair_2", "lair_3"))

	set_light(2, 2, 1, l_color = "#ff6533")

/obj/structure/meatvine/lair/Destroy()
	puff_gas(TRUE)

	return ..()

/obj/structure/meatvine/heavy/grow()
	if(!master)
		return
	if(master.isdying)
		return

	var/turf/T = get_turf(src)
	if(!isfloorturf(T))
		rot()
		return

	return

/obj/structure/meatvine/lair/grow()
	if(!master)
		return

	if(master.isdying)
		return

	var/turf/T = get_turf(src)
	if(!isfloorturf(T))
		rot()
		return

	if(!Mob)
		var/mobtype = pick(/mob/living/simple_animal/hostile/meatvine, /mob/living/simple_animal/hostile/meatvine/range)
		Mob = new mobtype(loc)
		puff_gas()
		return

	if(Mob.stat == DEAD)
		qdel(Mob.GetComponent(/datum/component/bounded))
		Mob = null
		return

	Mob.adjustBruteLoss(-10)
	Mob.adjustToxLoss(-5)
	Mob.adjustOxyLoss(-5)

	puff_gas()

/obj/structure/meatvine/lair/rot()
	. = ..()
	Mob = null

/mob/living/simple_animal/hostile/meatvine
	name = "Horrible creature"
	desc = "What is that?!"
	icon = 'icons/obj/cellular/meat.dmi'
	icon_state = "mob1"
	icon_living = "mob1"
	icon_dead = "mob1_dead"
	faction = "meat"
	health = 60
	maxHealth = 60
	//melee_damage = 25
	//move_speed = 0
	see_in_dark = 10

	environment_smash = TRUE
	//search_objects = 1
	//wanted_objects = list(/obj/machinery/light, /obj/machinery/light/small, /obj/machinery/light/smart, /obj/machinery/bot/secbot/beepsky, /obj/machinery/camera)

	stat_attack = 1

	pass_flags = PASSTABLE

/mob/living/simple_animal/hostile/meatvine/Destroy()
	puff_gas()
	var/turf/turf = get_turf(src)
	turf.pollute_turf(/datum/pollutant/steam, 100)

	turf.add_liquid(/datum/reagent/blood, 20)


	for(var/atom/A in view(2, src.loc))
		if( A == src ) continue
		reagents.reaction(A, 1, 10)

	return ..()

/mob/living/simple_animal/hostile/meatvine/death()
	puff_gas()


	QDEL_IN(src, rand(60, 120) SECONDS)

	return ..()

/mob/living/simple_animal/hostile/meatvine/proc/puff_gas()
	if(!prob(50))
		return

	var/turf/turf = get_turf(src)
	turf.pollute_turf(/datum/pollutant/rot, 100)

	reagents.clear_reagents()
	return


/mob/living/simple_animal/hostile/meatvine/range
	icon_state = "mob2"
	icon_living = "mob2"
	icon_dead = "mob2_dead"
	ranged = TRUE
	projectiletype = /obj/projectile/meatbullet

	minimum_distance = 2

/obj/projectile/meatbullet
	icon_state = "meat"
	damage = 20
	damage_type = BRUTE
