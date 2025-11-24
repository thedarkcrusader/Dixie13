/obj/structure/meatvineborder
	name = "meat clump"
	desc = "What is that?!"
	icon = 'icons/obj/cellular/meat.dmi'
	icon_state = "border"

	anchored = TRUE
	density = TRUE
	opacity = TRUE

	//armor = list(MELEE = 10, BULLET = 30, LASER = -10, ENERGY = 100, BOMB = -10, BIO = 100, FIRE = -200, ACID = -300)
	max_integrity = 10
	resistance_flags = CAN_BE_HIT


/obj/structure/meatvineborder/CanPass(atom/movable/mover, turf/target, height=0)
	. = ..()
	if(get_dir(loc, target) & dir)
		return FALSE
	return TRUE

/obj/structure/meatvineborder/CanAStarPass(ID, to_dir, requester)
	if(dir == to_dir)
		return FALSE

	return TRUE

/obj/structure/meatvine
	name = "meat clump"
	desc = "What is that?!"
	icon = 'icons/obj/cellular/meat.dmi'
	icon_state = "tile_1"
	anchored = TRUE
	density = FALSE
	layer = LOW_OBJ_LAYER
	pass_flags = PASSTABLE | PASSGRILLE

	//armor = list(MELEE = 10, BULLET = 30, LASER = -10, ENERGY = 100, BOMB = -10, BIO = 100, FIRE = -200, ACID = -300)

	var/obj/effect/meatvine_controller/master = null

	var/feromone_weight = 1

	var/list/lair_generators = list(/mob/living, /obj/item/reagent_containers/food/snacks, /obj/item/alch/herb, /obj/item/natural)

	max_integrity = 20
	resistance_flags = CAN_BE_HIT

	var/list/meat_side_overlays

	var/list/borders_overlays = list()

/obj/structure/meatvine/proc/rot()
	color = "#55ffff"
	master = null

	var/turf/T = get_turf(src)

	for(var/obj/structure/meatvineborder/Vine in T)
		Vine.color = "#55ffff"

/obj/structure/meatvine/update_overlays()
	. = ..()
	var/turf/T = get_turf(src)

	for(var/direction in GLOB.alldirs)
		var/turf/step = get_step(T, direction)
		var/obj/structure/meatvine/Vine = locate(/obj/structure/meatvine, step)

		if(Vine)
			continue

		var/image/Overlay = image(icon = 'icons/obj/cellular/meat.dmi', icon_state = "tile_edge", dir = direction)
		Overlay.pixel_x = X_OFFSET(32, direction)
		Overlay.pixel_y = Y_OFFSET(32, direction)

		borders_overlays += Overlay
		. += Overlay

/obj/structure/meatvine/proc/update_borders()
	update_appearance()

	var/turf/T = get_turf(src)

	for(var/direction in GLOB.alldirs)
		var/turf/step = get_step(T, direction)
		var/obj/structure/meatvine/Vine = locate(/obj/structure/meatvine, step)

		if(!Vine)
			continue

		addtimer(CALLBACK(Vine, TYPE_PROC_REF(/atom, update_appearance)), 5)

/obj/structure/meatvine/papameat
	name = "papa meat"
	desc = "You feel a combination of fear and disgust, just by looking at that thing."
	icon = 'icons/obj/cellular/papameat.dmi'
	icon_state = "papameat"
	density = TRUE

	pass_flags = PASSTABLE

	max_integrity = 1000

	pixel_x = -48
	pixel_y = -48

	var/healed = FALSE

	var/obj/effect/abstract/particle_holder/Particle

/obj/structure/meatvine/papameat/Initialize()
	. = ..()
	START_PROCESSING(SSfastprocess, src)

	Particle = new(src, /particles/papameat)

	set_light(3, 3, 1, l_color = "#ff6533")

/obj/structure/meatvine/papameat/Destroy()
	puff_gas(TRUE)
	master.die()
	STOP_PROCESSING(SSfastprocess, src)
	qdel(Particle)
	return ..()

/obj/structure/meatvine/papameat/attackby(obj/item/I, mob/user, params)
	if(!master)
		return ..()

	// Check if item is organic matter
	var/organic_value = 0

	if(istype(I, /obj/item/reagent_containers/food))
		var/obj/item/reagent_containers/food/meat = I
		if(meat.foodtype & MEAT)
			organic_value = 10
	else if(istype(I, /obj/item/bodypart))
		organic_value = 50
	else if(istype(I, /mob/living))
		var/mob/living/L = I
		if(L.stat == DEAD)
			organic_value = 100
	else if(istype(I, /obj/item/organ))
		organic_value = 30

	if(organic_value > 0)
		to_chat(user, "<span class='notice'>The meatvine absorbs [I]!</span>")
		master.feed_organic_matter(organic_value)
		qdel(I)

		// Chance to grow immediately when fed
		if(prob(30))
			spread()

		return TRUE

	return ..()

/obj/structure/meatvine/papameat/process()
	var/integrity_percent = round(get_integrity()/max_integrity)

	switch(integrity_percent)
		if(75)
			if(prob(10))
				transfer_feromones(2)

		if(50)
			if(prob(10))
				transfer_feromones(5)

			if(prob(1))
				var/mobtype = pick(/mob/living/simple_animal/hostile/meatvine, /mob/living/simple_animal/hostile/meatvine/range)
				new mobtype(loc)

			if(healed && (master.vines.len <= master.collapse_size) && master.reached_collapse_size)
				master.reached_collapse_size = FALSE

		if(25)
			if(prob(20))
				puff_gas(TRUE)
			if(healed && (master.vines.len >= master.slowdown_size) && master.reached_slowdown_size)
				master.reached_slowdown_size = FALSE

	if(!healed)
		if(!repair_damage(10))
			healed = TRUE

/obj/structure/meatvine/papameat/grow()
	return

/obj/structure/meatvine/proc/puff_gas(big = FALSE)
	if(!prob(50))
		return

	var/turf/T = get_turf(src)
	T.pollute_turf(/datum/pollutant/rot, 100)

	reagents.clear_reagents()
	return

/obj/structure/meatvine/floor/Initialize()
	. = ..()

	icon_state = pick(list("tile_1", "tile_2", "tile_3", "tile_4"))

/obj/structure/meatvine/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir)
	. = ..()
	if(damage_type != BURN)
		transfer_feromones(3)

/obj/structure/meatvine/proc/transfer_feromones(amount)
	if(prob(5))
		spread()
		grow()

	feromone_weight += 10
	if(amount <= 1)
		return

	var/turf/T = src.loc
	for(var/direction in GLOB.cardinals)
		var/turf/step = get_step(T, direction)
		var/obj/structure/meatvine/Vine = locate(/obj/structure/meatvine, step)

		if(!Vine)
			continue

		Vine.transfer_feromones(amount - 1)

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
	var/datum/beam/current_beam = null

/obj/structure/meatvine/lair/Initialize()
	. = ..()
	icon_state = pick(list("lair_1", "lair_2", "lair_3"))

	set_light(2, 2, 1, l_color = "#ff6533")

/obj/structure/meatvine/lair/Destroy()
	puff_gas(TRUE)

	return ..()

/obj/structure/meatvine/Initialize()
	. = ..()

	checking_items:
		for(var/obj/item/Item in src.loc.contents)
			for(var/generator_type in lair_generators)
				if(istype(Item, generator_type))
					continue checking_items

			Item.try_wrap_up("meat", "meatthings")

	for(var/obj/structure/closet/Closet in src.loc.contents)
		Closet.try_wrap_up("meat", "meatthings")

	var/datum/reagents/R = new/datum/reagents(400)
	reagents = R
	R.my_atom = src

	update_borders()

/obj/structure/meatvine/Destroy()
	if(master)
		master.vines -= src
		master.growth_queue -= src
		master = null

	update_borders()
	return ..()

/obj/structure/meatvine/proc/can_buckle(mob/living/M)
	if(M.buckled || length(buckled_mobs))
		return FALSE
	return M.stat != DEAD

/obj/structure/meatvine/user_buckle_mob(mob/living/M, mob/user)
	return

/obj/structure/meatvine/buckle_mob(mob/living/M, force = FALSE, check_loc = TRUE)
	. = ..()
	if(!can_buckle(M))
		return

	if(.)
		to_chat(M, "<span class='danger'>The vines [pick("wind", "tangle", "tighten")] around you!</span>")

	if(prob(5))
		M.try_wrap_up("meat", "meatthings")

/obj/structure/meatvine/proc/grow()
	if(!master)
		return

	if(master.isdying)
		return

	var/turf/T = src.loc
	if(!isfloorturf(T))
		rot()
		return

	if(prob(feromone_weight))
		master.spawn_spacevine_piece(T, /obj/structure/meatvine/heavy)
		qdel(src)
	else if(prob(1))
		master.spawn_spacevine_piece(T, /obj/structure/meatvine/lair)
		qdel(src)
	else
		for(var/generator_type in lair_generators)
			var/atom/thing = locate(generator_type, T)
			if(!thing)
				continue
			if(isliving(thing))
				var/mob/living/Mob = thing

				if(Mob.stat != DEAD || istype(Mob, /mob/living/simple_animal/hostile/meatvine))
					continue

				Mob.try_wrap_up("meat", "meatthings")

			else
				qdel(thing)

			master?.spawn_spacevine_piece(T, /obj/structure/meatvine/lair)
			qdel(src)

	return

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
		current_beam = new(src, Mob, time = INFINITY, icon_state = "meat", beam_type = /obj/effect/ebeam/meat)
		INVOKE_ASYNC(current_beam, TYPE_PROC_REF(/datum/beam, Start))
		Mob.AddComponent(/datum/component/bounded, src, 0, 3)
		puff_gas()
		return

	if(Mob.stat == DEAD)
		qdel(Mob.GetComponent(/datum/component/bounded))
		QDEL_NULL(current_beam)
		Mob = null
		return

	Mob.adjustBruteLoss(-10)
	Mob.adjustToxLoss(-5)
	Mob.adjustOxyLoss(-5)

	puff_gas()

/obj/structure/meatvine/lair/rot()
	..()
	if(Mob)
		qdel(Mob.GetComponent(/datum/component/bounded))
	QDEL_NULL(current_beam)
	Mob = null

/obj/effect/ebeam/meat
	name = "meat"
	icon_state = "meat"

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

/obj/structure/meatvine/proc/spread()
	if(!master || master.isdying)
		return

	var/turf/T = src.loc
	var/direction = pick(GLOB.cardinals)
	var/step = get_step(src,direction)
	if(isopenturf(step))
		var/turf/open/floor/F = step
		while(isopenspace(F))
			F = GET_TURF_BELOW(F)
		var/stairs = TRUE
		while(stairs && locate(/obj/structure/stairs, F))
			if(isopenspace(GET_TURF_ABOVE(F)))
				F = GET_TURF_ABOVE(F)
				F = get_step(F, direction)
			else
				stairs = FALSE
		if(!isfloorturf(F))
			return

		if(!locate(/obj/structure/meatvine,F))
			if(master)
				if(!can_enter_turf(F))
					return
				master.spawn_spacevine_piece(F)
				return
	else
		var/obstructed_dir = get_dir(T, step)
		for(var/obj/structure/meatvineborder/Vine in T)
			if(Vine.dir == obstructed_dir)
				return

		var/obj/structure/meatvineborder/Vine = new /obj/structure/meatvineborder(src.loc)
		Vine.dir = obstructed_dir

/obj/structure/meatvine/proc/can_enter_turf(turf/output_turf)
	if(output_turf.is_blocked_turf())
		return FALSE
	if(istype(output_turf, /turf/open/water) || istype(output_turf, /turf/open/lava))
		return
	if(locate(/obj/structure/hotspring, output_turf))
		return FALSE
	return TRUE
