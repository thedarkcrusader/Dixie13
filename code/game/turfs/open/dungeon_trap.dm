/turf/open/dungeon_trap
	name = "dark chasm"
	desc = "It's a long way down..."
	icon_state = "black"

	var/can_cover_up = TRUE
	var/can_build_on = TRUE
	path_weight = 500

/turf/open/dungeon_trap/can_traverse_safely(atom/movable/traveler)
	if(!traveler.can_zFall(src, DOWN, destination)) // they can't fall!
		return TRUE
	return FALSE

/turf/open/dungeon_trap/zPassIn(atom/movable/A, direction, turf/source)
	if(direction == DOWN)
		for(var/obj/O in contents)
			if(O.obj_flags & BLOCK_Z_IN_DOWN)
				return FALSE
		return TRUE
	if(direction == UP)
		return FALSE // this shouldn't really happen, one way trip buddy
	return FALSE

/turf/open/dungeon_trap/zPassOut(atom/movable/A, direction, turf/destination)
	if(A.anchored && !isprojectile(A))
		return FALSE
	if(direction == DOWN)
		for(var/obj/O in contents)
			if(O.obj_flags & BLOCK_Z_OUT_DOWN)
				return FALSE
		return TRUE
	return FALSE

/turf/open/dungeon_trap/can_zFall(atom/movable/A, levels = 1, turf/target)
	if(!length(GLOB.dungeon_entries) || !length(GLOB.dungeon_exits))
		return FALSE
	return zPassOut(A, DOWN, target) && target.zPassIn(A, DOWN, src)

/turf/open/dungeon_trap/zFall(atom/movable/A, levels = 1, force = FALSE)
	var/turf/target = get_step_multiz(src, DOWN)
	if(!target || (!isobj(A) && !ismob(A)))
		return FALSE
	if(!force && (!can_zFall(A, levels, target) || !A.can_zFall(src, levels, target, DOWN)))
		return FALSE
	A.atom_flags |= Z_FALLING
	A.forceMove(target)
	A.atom_flags &= ~Z_FALLING
	target.zImpact(A, levels, src)
	return TRUE
