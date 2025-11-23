/obj/structure/redstone/repeater
	name = "redstone repeater"
	desc = "Amplifies and delays redstone signals."
	icon_state = "repeater"
	redstone_role = REDSTONE_ROLE_PROCESSOR
	true_pattern = "repeater"
	var/facing_dir = NORTH
	var/delay_ticks = 2
	var/output_active = FALSE
	var/scheduled_state = -1
	var/last_input_state = FALSE
	can_connect_wires = TRUE
	send_wall_power = TRUE

/obj/structure/redstone/repeater/Initialize()
	. = ..()
	facing_dir = dir

/obj/structure/redstone/repeater/get_source_power()
	return output_active ? 15 : 0

/obj/structure/redstone/repeater/get_effective_power()
	return output_active ? 15 : 0

/obj/structure/redstone/repeater/get_output_directions()
	return list(facing_dir)

/obj/structure/redstone/repeater/get_input_directions()
	return list(REVERSE_DIR(facing_dir))

/obj/structure/redstone/repeater/get_connection_directions()
	return list(facing_dir, REVERSE_DIR(facing_dir))

/obj/structure/redstone/repeater/can_connect_to(obj/structure/redstone/other, direction)
	return (direction == facing_dir || direction == REVERSE_DIR(facing_dir))

/obj/structure/redstone/repeater/can_receive_from(obj/structure/redstone/source, direction)
	return (direction == REVERSE_DIR(facing_dir))

/obj/structure/redstone/repeater/get_network_neighbors()
	var/list/neighbors = list()

	var/input_dir = REVERSE_DIR(facing_dir)
	var/turf/input_turf = get_step(src, input_dir)
	for(var/obj/structure/redstone/R in input_turf)
		if(can_connect_to(R, input_dir) && R.can_connect_to(src, facing_dir))
			neighbors += R

	var/turf/output_turf = get_step(src, facing_dir)
	for(var/obj/structure/redstone/R in output_turf)
		if(can_connect_to(R, facing_dir) && R.can_connect_to(src, input_dir))
			neighbors += R

	if(send_wall_power && isclosedturf(output_turf))
		var/list/wall_neighbors = get_wall_power_neighbors(facing_dir, output_turf)
		neighbors |= wall_neighbors

	// Also check for wall power INPUT sources (for network connectivity)
	if(isclosedturf(input_turf))
		var/list/wall_sources = get_wall_power_sources(input_dir, input_turf)
		neighbors |= wall_sources

	return neighbors

// Find components that could be powering US through a wall
/obj/structure/redstone/repeater/proc/get_wall_power_sources(direction, turf/wall_turf)
	var/list/sources = list()

	for(var/check_dir in GLOB.cardinals)
		if(check_dir == REVERSE_DIR(direction))
			continue  // Don't check back towards ourselves

		var/turf/beyond_wall = get_step(wall_turf, check_dir)
		for(var/obj/structure/redstone/R in beyond_wall)
			if(!R.send_wall_power)
				continue
			// Check if this component is actually outputting TOWARDS the wall
			var/dir_to_wall = REVERSE_DIR(check_dir)
			if(dir_to_wall in R.get_output_directions())
				sources += R

	return sources

/obj/structure/redstone/repeater/on_power_changed()
	var/input_dir = REVERSE_DIR(facing_dir)
	var/turf/input_turf = get_step(src, input_dir)
	var/input_power = 0

	// Direct adjacency input
	for(var/obj/structure/redstone/R in input_turf)
		if(R.can_connect_to(src, facing_dir))
			input_power = max(input_power, R.get_effective_power())

	// Wall power input - need to check if source is FACING the wall
	if(isclosedturf(input_turf))
		for(var/check_dir in GLOB.cardinals)
			if(check_dir == REVERSE_DIR(input_dir))
				continue  // Don't check back towards ourselves

			var/turf/beyond_wall = get_step(input_turf, check_dir)
			for(var/obj/structure/redstone/R in beyond_wall)
				if(!R.send_wall_power)
					continue
				// Check if this component is outputting TOWARDS the wall
				var/dir_to_wall = REVERSE_DIR(check_dir)
				if(!(dir_to_wall in R.get_output_directions()))
					continue
				input_power = max(input_power, R.get_effective_power())

	var/input_on = (input_power > 0)

	if(input_on == last_input_state)
		return

	last_input_state = input_on

	if(input_on)
		if(!output_active && scheduled_state != 1)
			scheduled_state = 1
			spawn(delay_ticks)
				apply_scheduled_state()
		else if(scheduled_state == 0)
			scheduled_state = -1
	else
		if(output_active && scheduled_state != 0)
			scheduled_state = 0
			spawn(delay_ticks)
				apply_scheduled_state()
		else if(scheduled_state == 1)
			scheduled_state = -1

/obj/structure/redstone/repeater/proc/apply_scheduled_state()
	if(scheduled_state == -1)
		return

	if(scheduled_state == 1 && !output_active)
		output_active = TRUE
		power_level = 15
	else if(scheduled_state == 0 && output_active)
		output_active = FALSE
		power_level = 0

	scheduled_state = -1
	schedule_network_update()
	update_appearance(UPDATE_OVERLAYS)

/obj/structure/redstone/repeater/update_icon()
	. = ..()
	icon_state = "repeater"
	dir = facing_dir

/obj/structure/redstone/repeater/update_overlays()
	. = ..()
	var/mutable_appearance/delay_overlay = mutable_appearance(icon, "delay_[delay_ticks]")
	delay_overlay.color = output_active ? "#FF0000" : "#8B4513"
	. += delay_overlay

/obj/structure/redstone/repeater/attack_hand(mob/user)
	delay_ticks = (delay_ticks % 4) + 1
	to_chat(user, "<span class='notice'>Delay set to [delay_ticks] tick\s.</span>")
	update_appearance(UPDATE_OVERLAYS)

/obj/structure/redstone/repeater/AltClick(mob/user)
	if(!Adjacent(user))
		return
	facing_dir = turn(facing_dir, 90)
	dir = facing_dir
	to_chat(user, "<span class='notice'>You rotate the [name] to face [dir2text_readable(facing_dir)].</span>")
	schedule_network_update()

/obj/structure/redstone/repeater/proc/dir2text_readable(direction)
	switch(direction)
		if(NORTH) return "north"
		if(SOUTH) return "south"
		if(EAST) return "east"
		if(WEST) return "west"
	return "unknown"

/obj/structure/redstone/repeater/examine(mob/user)
	. = ..()
	. += "Facing [dir2text_readable(facing_dir)], delay: [delay_ticks] tick\s."
