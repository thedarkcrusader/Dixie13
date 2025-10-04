/obj/structure/soil/mushmound
	name = "mushroom mound"
	desc = "A mound of hay and nitesoil, used as the growing medium for various types of mushrooms."
	icon = 'icons/roguetown/misc/soil.dmi'
	icon_state = "mushmound-dry"
	density = TRUE
	anchored = TRUE
	climbable = FALSE
	max_integrity = 200

	COOLDOWN_DECLARE(mushmound_update)


/obj/structure/soil/mushmound/attackby(obj/item/attacking_item, mob/user, params)
	user.changeNext_move(CLICK_CD_FAST)
	if(try_handle_inoculate_planting(attacking_item, user, params))
		return
	if(try_handle_uprooting(attacking_item, user, params))
		return
	if(try_handle_watering(attacking_item, user, params))
		return
	if(try_handle_harvest(attacking_item, user, params))
		return
	if(try_handle_fertilizing(attacking_item, user, params))
		return
	for(var/obj/item/bagged_item in attacking_item.contents)
		if(try_handle_fertilizing(bagged_item, user, params))
			return
	return ..()

/obj/structure/soil/mushmound/proc/try_handle_inoculate_planting(obj/item/attacking_item, mob/user, params)
	var/obj/item/old_item
	if(istype(attacking_item, /obj/item/neuFarm/seed/inoculate)) //SLOP OBJECT PROC SHARING
		playsound(src, pick('sound/foley/touch1.ogg','sound/foley/touch2.ogg','sound/foley/touch3.ogg'), 170, TRUE)
		if(do_after(user, get_farming_do_time(user, 15), src))
			if(old_item)
				SEND_SIGNAL(old_item, COMSIG_TRY_STORAGE_TAKE, attacking_item, get_turf(user), TRUE)
			var/obj/item/neuFarm/seed/inoculate/inoculate = attacking_item
			inoculate.try_plant_inoculate(user, src)
		return TRUE
	return FALSE

/obj/structure/soil/mushmound/proc/try_handle_inoculate_planting(obj/item/attacking_item, mob/user, params)
	var/obj/item/old_item
	if(istype(attacking_item, /obj/item/storage/sack))
		var/list/inoculates= list()
		for(var/obj/item/neuFarm/seed/inoculate/inoculate in attacking_item.contents)
			inoculates |= inoculate
		old_item = attacking_item
		if(LAZYLEN(inoculates))
			attacking_item = pick(inoculates)
