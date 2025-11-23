/obj/structure/redstone/repeater
	name = "redstone repeater"
	desc = "Amplifies and delays redstone signals. Can be locked by a powered repeater from the side."
	icon_state = "repeater"
	redstone_role = REDSTONE_ROLE_PROCESSOR
	true_pattern = "repeater"
	should_block = FALSE

	var/facing_dir = NORTH
	var/delay_ticks = 2
	var/output_active = FALSE
	var/scheduled_state = -1
	var/last_input_state = FALSE
	var/locked = FALSE // New variable for locking mechanics

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

/obj/structure/redstone/repeater/proc/update_lock_status()
	var/should_be_locked = FALSE

	// Check Left and Right relative to facing direction
	var/list/side_dirs = list(turn(facing_dir, 90), turn(facing_dir, -90))

	for(var/check_dir in side_dirs)
		var/turf/T = get_step(src, check_dir)
		if(!T) continue

		// Check for repeaters (or comparators in the future)
		for(var/obj/structure/redstone/repeater/R in T)
			// The neighbor must be facing TOWARDS us (their facing_dir == reverse of check_dir)
			// And they must be powered
			if(R.facing_dir == REVERSE_DIR(check_dir) && R.output_active)
				should_be_locked = TRUE
				break

		if(should_be_locked)
			break

	if(locked != should_be_locked)
		locked = should_be_locked
		update_appearance(UPDATE_OVERLAYS)
		return TRUE // Status changed

	return FALSE // Status did not change

/// When WE change state, we must wake up neighbors to our sides
/// in case we are the ones supposed to be locking THEM.
/obj/structure/redstone/repeater/proc/trigger_lock_updates()
	// I am facing NORTH. I am to the WEST of the guy to my East.
	// If I am powered, and facing East, I lock him.
	// Therefore, we check the turf in front of us.

	var/turf/front_turf = get_step(src, facing_dir)
	if(front_turf)
		for(var/obj/structure/redstone/repeater/victim in front_turf)
			// If the victim is facing perpendicular to us, we are locking them
			// We are facing NORTH. Victim is facing EAST.
			// Vector dot product is 0.
			if(victim.facing_dir == turn(facing_dir, 90) || victim.facing_dir == turn(facing_dir, -90))
				victim.schedule_network_update()

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
	// 1. Check if we are locked.
	// If lock status CHANGED, we might need to process input immediately.
	var/lock_changed = update_lock_status()

	// 2. If we are currently locked, we do absolutely nothing.
	// We maintain our current output state regardless of input.
	if(locked)
		return

	// 3. Calculate Input (Standard Logic)
	var/input_dir = REVERSE_DIR(facing_dir)
	var/turf/input_turf = get_step(src, input_dir)
	var/input_power = 0

	// Direct adjacency input
	for(var/obj/structure/redstone/R in input_turf)
		if(R.can_connect_to(src, facing_dir))
			input_power = max(input_power, R.get_effective_power())

	// Wall power input logic
	if(isclosedturf(input_turf))
		for(var/check_dir in GLOB.cardinals)
			if(check_dir == REVERSE_DIR(input_dir)) continue
			var/turf/beyond_wall = get_step(input_turf, check_dir)
			for(var/obj/structure/redstone/R in beyond_wall)
				if(!R.send_wall_power) continue
				var/dir_to_wall = REVERSE_DIR(check_dir)
				if(!(dir_to_wall in R.get_output_directions())) continue
				input_power = max(input_power, R.get_effective_power())

	var/input_on = (input_power > 0)

	// Optimization: If input state hasn't changed, and we weren't just unlocked, do nothing
	if(input_on == last_input_state && !lock_changed)
		return

	last_input_state = input_on

	// Scheduling logic
	if(input_on)
		if(!output_active && scheduled_state != 1)
			scheduled_state = 1
			spawn(delay_ticks)
				apply_scheduled_state()
		else if(scheduled_state == 0) // Was scheduled to turn off, but input returned
			scheduled_state = -1
	else
		if(output_active && scheduled_state != 0)
			scheduled_state = 0
			spawn(delay_ticks)
				apply_scheduled_state()
		else if(scheduled_state == 1) // Was scheduled to turn on, but input lost
			scheduled_state = -1

/obj/structure/redstone/repeater/proc/apply_scheduled_state()
	// If we got locked while waiting for the timer, abort the change!
	update_lock_status()
	if(locked)
		scheduled_state = -1
		return

	if(scheduled_state == -1)
		return

	var/state_changed = FALSE

	if(scheduled_state == 1 && !output_active)
		output_active = TRUE
		power_level = 15
		state_changed = TRUE
	else if(scheduled_state == 0 && output_active)
		output_active = FALSE
		power_level = 0
		state_changed = TRUE

	scheduled_state = -1

	if(state_changed)
		// Standard Update: Power the wire in front of us
		schedule_network_update()
		// Locking Update: Check if we are locking a neighbor to our side
		trigger_lock_updates()

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

	if(output_active)
		var/mutable_appearance/em = emissive_appearance(icon, "delay_[delay_ticks]")
		. += em

	if(locked)
		var/mutable_appearance/lock_overlay = mutable_appearance(icon, "repeater_lock")
		lock_overlay.layer = layer + 0.02
		. += lock_overlay

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
