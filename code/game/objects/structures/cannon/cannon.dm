/obj/structure/cannon
	name = "cannon"
	icon = 'icons/roguetown/misc/cannon.dmi'
	icon_state = "cannon"

	density = TRUE
	max_integrity = 1200
	anchored = FALSE
	climbable = TRUE
	climb_offset = 16

	resistance_flags = FIRE_PROOF
	drag_slowdown = 2.5

	SET_BASE_PIXEL(-16, -16)

	var/obj/item/fuse/inserted_fuse
	var/obj/item/reagent_containers/internal_reagent_container

/obj/structure/cannon/Initialize()
	. = ..()
	internal_reagent_container = new()
	calculate_blockers()
	AddComponent(/datum/component/storage/concrete/grid/cannon)

/obj/structure/cannon/Destroy()
	. = ..()
	qdel(internal_reagent_container)

/obj/structure/cannon/Move()
	. = ..()
	calculate_blockers()

/obj/structure/cannon/after_being_moved_by_pull(atom/movable/puller)
	setDir(REVERSE_DIR(puller.dir))

/obj/structure/cannon/proc/calculate_blockers()
	/*
	switch(dir)
		if(WEST)
			bound_width = 64
			bound_height = 32
		if(EAST)
			bound_width = -64
			bound_height = 32
		if(NORTH)
			bound_width = 32
			bound_height = 64
		if(SOUTH)
			bound_width = 32
			bound_height = -64
	*/

/obj/structure/cannon/attackby(obj/item/I, mob/user, params)
	. = ..()
	//try_interact_thing(I, user)

/obj/structure/cannon/proc/try_interact_thing(obj/inserted, mob/user)

/obj/structure/cannon/fire_act(added, maxstacks)
	. = ..()
	try_light_fuse()

/obj/structure/cannon/proc/try_light_fuse(mob/user)
	playsound(src.loc, 'sound/items/fuse.ogg', 100)

/obj/structure/cannon/can_be_pulled(user, grab_state, force)
	. = ..()
	if(get_dir(user, src) != dir)
		return FALSE

/obj/structure/cannon/proc/attempt_light()
	inserted_fuse?.attempt_to_be_lit()

/obj/structure/cannon/fire_act(added, maxstacks)
	. = ..()
	attempt_light()

/obj/structure/cannon/proc/fire()
	playsound(get_turf(src), 'sound/foley/tinnitus.ogg', 60, FALSE, -6)
	playsound(get_turf(src), 'sound/combat/Ranged/muskshoot.ogg', 60, FALSE, SOUND_EXTRA_RANGE_CANNON)
	new /obj/effect/particle_effect/smoke/chem/transparent(get_turf(src))
	var/turf/turf_in_front = get_step(src, dir)
	var/turf/turf_to_shoot_from = turf_in_front
	var/datum/component/storage/STR = GetComponent(/datum/component/storage) // don't @ me
	if(!isopenturf(turf_to_shoot_from))
		turf_to_shoot_from = get_turf(src)

	for(var/mob/living/seer in view(4, src))
		shake_camera(seer, 2, 3)
		seer.apply_effect(8, EFFECT_EYE_BLUR)

	for(var/atom/movable/loaded_thing as anything in contents)
		var/target = get_edge_target_turf(src, dir)
		if(isammo(loaded_thing))
			var/obj/item/ammo_casing/loaded_ammo = loaded_thing
			loaded_ammo.forceMove(turf_to_shoot_from)
			loaded_ammo.fire_casing(target)
		else
			if(ismobholder(loaded_thing))
				var/obj/item/clothing/head/mob_holder/curler = loaded_thing
				loaded_thing = curler.held_mob
				qdel(curler)

			STR.remove_from_storage(loaded_thing, turf_to_shoot_from)
			loaded_thing.throw_at(target, 30, 3, force = MOVE_FORCE_OVERPOWERING)
			if(isliving(loaded_thing))
				var/mob/living/loaded_living = loaded_thing
				loaded_living.reset_offsets("structure_climb")

	explosion(turf_in_front, heavy_impact_range = 1, light_impact_range = 2, flame_range = 2, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
	throw_at(get_step(src, REVERSE_DIR(dir)), 1, 3, spin = FALSE)

/obj/structure/cannon/attackby(obj/item/I, mob/user, params)
	if(isfuse(I))
		var/obj/item/fuse/fuse = I
		fuse.add_to_cannon(src, user)
		return TRUE
	. = ..()

/obj/effect/fuse
	icon = 'icons/roguetown/misc/cannon_fuse.dmi'
	var/obj/structure/cannon/cannon
	var/obj/item/fuse/fuse
	mouse_opacity = MOUSE_OPACITY_OPAQUE
	glide_size = 6

/obj/effect/fuse/Initialize(mapload, obj/structure/cannon/passed_cannon, obj/item/fuse/passed_fuse)
	. = ..()
	cannon = passed_cannon
	fuse = passed_fuse
	sync_with_fuse()
	calculate_offsets()
	RegisterSignal(cannon, COMSIG_PARENT_QDELETING, PROC_REF(on_deletion))
	RegisterSignal(cannon, COMSIG_MOVABLE_MOVED, PROC_REF(calculate_offsets))
	RegisterSignal(fuse, COMSIG_PARENT_QDELETING, PROC_REF(on_deletion))
	RegisterSignal(fuse, COMSIG_FUSE_LIT, PROC_REF(sync_with_fuse))
	RegisterSignal(fuse, COMSIG_FUSE_EXTINGUISHED, PROC_REF(sync_with_fuse))

/obj/effect/fuse/Destroy(force)
	. = ..()
	cannon = null
	fuse = null
	UnregisterSignal(cannon, COMSIG_PARENT_QDELETING)
	UnregisterSignal(cannon, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(fuse, COMSIG_PARENT_QDELETING)
	UnregisterSignal(fuse, COMSIG_FUSE_LIT)
	UnregisterSignal(fuse, COMSIG_FUSE_EXTINGUISHED)

/obj/effect/fuse/proc/on_deletion()
	qdel(src)

/obj/effect/fuse/proc/be_cut()
	fuse.remove_from_cannon(cannon)
	qdel(src)

/obj/effect/fuse/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(I.sharpness == IS_SHARP)
		be_cut()

/obj/effect/fuse/fire_act(added, maxstacks)
	if(added)
		fuse.attempt_to_be_lit()
		sync_with_fuse()

/obj/effect/fuse/proc/sync_with_fuse()
	appearance = fuse.appearance
	transform = matrix()

/obj/effect/fuse/proc/calculate_offsets()
	if(loc != cannon.loc)
		forceMove(get_turf(cannon))

	var/turf/center = src.loc
	var/turf/cannon_barrel = get_step(cannon, cannon.dir)

	var/matrix/new_matrix = matrix()
	transform = new_matrix

	var/new_pixel_w = (cannon_barrel.x - center.x) * 16
	var/new_pixel_z = (cannon_barrel.y - center.y) * 16

	pixel_w = new_pixel_w
	pixel_z = new_pixel_z


/obj/item/fuse
	name = "fuse"
	abstract_type = /obj/item/fuse
	icon = 'icons/roguetown/misc/cannon_fuse.dmi'
	mouse_opacity = MOUSE_OPACITY_ICON
	layer = LOW_ITEM_LAYER
	var/failure_chance = 50
	var/lit = FALSE

/obj/item/fuse/proc/add_to_cannon(obj/structure/cannon/cannon, mob/living/user)
	if(cannon.inserted_fuse)
		return FALSE

	if(!user.dropItemToGround(src))
		return FALSE

	loc = null
	new /obj/effect/fuse (get_turf(cannon), cannon, src)
	return TRUE

/obj/item/fuse/proc/remove_from_cannon(obj/structure/cannon/cannon)
	loc = get_turf(cannon)
	cannon.inserted_fuse = null

/obj/item/fuse/proc/attempt_to_be_lit()
	if(!prob(failure_chance))
		return
	lit()

/obj/item/fuse/proc/lit()
	icon_state = icon_state = "_lit"
	lit = TRUE
	addtimer(CALLBACK(PROC_REF(reached_end)), 5 SECONDS)
	SEND_SIGNAL(src, COMSIG_FUSE_LIT)

/obj/item/fuse/proc/extinguished()
	lit = FALSE
	icon_state = initial(icon_state)
	SEND_SIGNAL(src, COMSIG_FUSE_EXTINGUISHED)

/obj/item/fuse/proc/reached_end()
	if(!lit)
		extinguished()

	SEND_SIGNAL(src, COMSIG_FUSE_REACHED_END)
	qdel(src)

/obj/item/fuse/fiber
	name = "fiber fuse"
	icon_state = "fiber_fuse"

/obj/item/fuse/parchment
	name = "parchment fuse"
	icon_state = "parchment_fuse"
	failure_chance = 10
