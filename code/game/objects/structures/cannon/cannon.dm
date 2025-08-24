/obj/structure/cannon
	name = "cannon"
	icon = 'icons/roguetown/misc/cannon.dmi'
	icon_state = "cannon"

	density = TRUE
	max_integrity = 1200
	anchored = FALSE
	climbable = TRUE
	climb_offset = 16

	SET_BASE_PIXEL(-16, -16)

	var/obj/loaded_item
	var/obj/item/reagent_containers/internal_reagent_container

	var/mutable_appearance/fuse_apearance

/obj/structure/cannon/Initialize()
	. = ..()
	internal_reagent_container = new(src)
	calculate_blockers()

/obj/structure/cannon/Move()
	. = ..()
	calculate_blockers()

/obj/structure/cannon/pushed(new_loc, dir_pusher_to_pushed, glize_size, pusher_dir)
	Move(new_loc, dir_pusher_to_pushed, glize_size)

	setDir(dir_pusher_to_pushed)

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

/obj/structure/cannon/Destroy()
	. = ..()
	qdel(internal_reagent_container)

/obj/structure/cannon/attackby(obj/item/I, mob/user, params)
	. = ..()
	try_interact_thing(I, user)

/obj/structure/cannon/proc/try_interact_thing(obj/inserted, mob/user)

/obj/structure/cannon/fire_act(added, maxstacks)
	. = ..()
	try_light_fuse()

/obj/structure/cannon/proc/try_light_fuse(mob/user)
	playsound(src.loc, 'sound/items/fuse.ogg', 100)

/obj/structure/cannon/proc/lit()

/obj/structure/cannon/proc/fire()

/obj/structure/cannon/attackby_secondary(obj/item/weapon, mob/user, params)
	. = ..()
	try_take_out_thing(weapon, user)

/obj/structure/cannon/attack_hand(mob/user)
	. = ..()
	try_take_out_thing(user = user)

/obj/structure/cannon/proc/try_take_out_thing(obj/item/used_item, mob/user)


/obj/item/fuse
	name = "fuse"
	abstract_type = /obj/item/fuse
	icon = 'icons/roguetown/misc/cannon_fuse.dmi'
	var/failure_chance = 50

/obj/item/fuse/fiber

/obj/item/fuse/parchment
	failure_chance = 10
