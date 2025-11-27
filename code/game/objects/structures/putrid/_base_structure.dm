
/obj/effect/ebeam/meat
	name = "meat"
	icon_state = "meat"

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

	var/borders = TRUE
	var/list/borders_overlays = list()

	var/static/list/beams = list() // :3


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
	for(var/atom in beams)
		var/datum/beam/beam = beams[atom]
		beams -= atom
		qdel(beam)

	return ..()

/obj/structure/meatvine/proc/can_buckle(mob/living/M)
	if(M.buckled || length(buckled_mobs))
		return FALSE
	return M.stat != DEAD

/obj/structure/meatvine/user_buckle_mob(mob/living/M, mob/user)
	return

/obj/structure/meatvine/Crossed(atom/movable/AM)
	. = ..()
	if(istype(AM, /mob/living/simple_animal/hostile/retaliate/meatvine))
		var/mob/living/simple_animal/hostile/retaliate/meatvine/L = AM
		// Remove bounding component when entering a meatvine
		var/datum/component/bounded/B = L.GetComponent(/datum/component/bounded)
		if(B)
			qdel(B)
		if(AM in beams)
			var/datum/beam/current_beam = beams[AM]
			beams -= AM
			qdel(current_beam)

/obj/structure/meatvine/Uncrossed(atom/movable/AM)
	. = ..()
	if(istype(AM, /mob/living/simple_animal/hostile/retaliate/meatvine))
		var/mob/living/simple_animal/hostile/retaliate/meatvine/L = AM
		if(!L.tether_distance)
			return
		// Check if they're moving to a non-meatvine turf
		var/turf/new_loc = get_turf(L)
		if(!locate(/obj/structure/meatvine, new_loc))
			// Add bounding component back to this meatvine
			L.AddComponent(/datum/component/bounded, src, 0, L.tether_distance)

			var/datum/beam/current_beam = new(src, AM, time = INFINITY, icon_state = "meat", beam_type = /obj/effect/ebeam/meat)
			INVOKE_ASYNC(current_beam, TYPE_PROC_REF(/datum/beam, Start))
			if(AM in beams)
				var/datum/beam/old_beam = beams[AM]
				qdel(old_beam)
			beams |= AM
			beams[AM] = current_beam

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

	if(prob(1) && master.can_spawn_lair_at(T))
		master.spawn_spacevine_piece(T, /obj/structure/meatvine/lair)
		qdel(src)
	else
		for(var/generator_type in lair_generators)
			var/atom/thing = locate(generator_type, T)
			if(!thing)
				continue
			if(isliving(thing))
				var/mob/living/Mob = thing

				if(Mob.stat != DEAD || istype(Mob, /mob/living/simple_animal/hostile/retaliate/meatvine))
					continue

				Mob.try_wrap_up("meat", "meatthings")

			else
				qdel(thing)

			if(master.can_spawn_lair_at(T))
				master?.spawn_spacevine_piece(T, /obj/structure/meatvine/lair)
				qdel(src)

	return

/obj/structure/meatvine/proc/rot()
	color = "#55ffff"
	master = null

	var/turf/T = get_turf(src)

	for(var/obj/structure/meatvineborder/Vine in T)
		Vine.color = "#55ffff"


/obj/structure/meatvine/proc/restore_vine(obj/effect/meatvine_controller/new_master)
	if(!new_master)
		return FALSE

	color = initial(color)

	master = new_master
	new_master.vines += src
	new_master.growth_queue += src

	var/turf/T = get_turf(src)
	for(var/obj/structure/meatvineborder/Vine in T)
		Vine.color = initial(Vine.color)

	update_borders()

	return TRUE

/obj/structure/meatvine/update_overlays()
	. = ..()
	var/turf/T = get_turf(src)

	if(!borders)
		return
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

/obj/structure/meatvine/proc/puff_gas(big = FALSE)
	if(!prob(50))
		return

	var/turf/T = get_turf(src)
	T.pollute_turf(/datum/pollutant/rot, 100)

	reagents.clear_reagents()
	return

/obj/structure/meatvine/proc/transfer_feromones(amount)
	// Enhanced spread chance with organic matter
	var/spread_chance = 5
	if(master && master.organic_matter >= master.organic_matter_per_spread)
		spread_chance = 15 // Triple the chance when we have organic matter

	if(prob(spread_chance))
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



/obj/structure/meatvine/proc/spread()
	if(!master || master.isdying)
		return
	var/turf/T = src.loc
	var/direction = pick(GLOB.cardinals)
	var/step = get_step(src, direction)

	var/using_organic_matter = FALSE
	if(master.organic_matter >= master.organic_matter_per_spread)
		using_organic_matter = TRUE
		master.organic_matter -= master.organic_matter_per_spread

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

		var/obj/structure/meatvine/existing = locate(/obj/structure/meatvine, F)
		if(existing && !existing.master)
			existing.restore_vine(master)
			if(using_organic_matter && prob(75))
				attempt_bonus_spread(T, direction)
			return

		if(!existing)
			if(master)
				if(!can_enter_turf(F))
					// Check if there's a blocking structure we should mark for destruction
					for(var/obj/structure/S in F)
						if(S.density && !istype(S, /obj/structure/meatvine))
							master.mark_obstacle_for_destruction(S)
					for(var/obj/machinery/M in F)
						if(M.density)
							master.mark_obstacle_for_destruction(M)
					return

				master.spawn_spacevine_piece(F)
				if(using_organic_matter && prob(75))
					attempt_bonus_spread(T, direction)
				return
	else
		var/obstructed_dir = get_dir(T, step)
		for(var/obj/structure/meatvineborder/Vine in T)
			if(Vine.dir == obstructed_dir)
				return
		var/obj/structure/meatvineborder/Vine = new /obj/structure/meatvineborder(src.loc)
		Vine.dir = obstructed_dir

/obj/structure/meatvine/proc/attempt_bonus_spread(turf/origin, avoided_direction)
	if(!master)
		return

	var/list/other_dirs = GLOB.cardinals.Copy()
	other_dirs -= avoided_direction
	if(!length(other_dirs))
		return

	var/bonus_dir = pick(other_dirs)
	var/turf/bonus_step = get_step(origin, bonus_dir)
	if(!isopenturf(bonus_step))
		return

	var/turf/open/floor/BF = bonus_step
	while(isopenspace(BF))
		BF = GET_TURF_BELOW(BF)

	if(!isfloorturf(BF))
		return

	// Check for rotted vine first
	var/obj/structure/meatvine/existing = locate(/obj/structure/meatvine, BF)
	if(existing && !existing.master)
		existing.restore_vine(master)
		return

	if(!existing && can_enter_turf(BF))
		master.spawn_spacevine_piece(BF)

/obj/structure/meatvine/proc/can_enter_turf(turf/output_turf)
	if(output_turf.is_blocked_turf())
		return FALSE
	if(istype(output_turf, /turf/open/water) || istype(output_turf, /turf/open/lava))
		return
	if(locate(/obj/structure/hotspring, output_turf))
		return FALSE
	return TRUE
