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
