/obj/structure/redstone/comparator
	name = "redstone comparator"
	desc = "Compares redstone signal strengths. Can read containers and signals through walls."
	icon_state = "comparator"
	redstone_role = REDSTONE_ROLE_PROCESSOR

	var/direction = NORTH
	var/mode = "compare" // "compare" or "subtract"

	// Inputs (Cached)
	var/main_input = 0
	var/side_input_left = 0
	var/side_input_right = 0
	var/output_power = 0

	can_connect_wires = TRUE
	send_wall_power = TRUE // Allows powering dust above/below the target wall

/obj/structure/redstone/comparator/Initialize()
	. = ..()
	direction = dir
	// We process to check containers, as they don't emit network updates themselves
	START_PROCESSING(SSobj, src)

/obj/structure/redstone/comparator/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/redstone/comparator/get_source_power()
	return output_power

/obj/structure/redstone/comparator/get_effective_power()
	return output_power

/obj/structure/redstone/comparator/get_output_directions()
	return list(direction)

/obj/structure/redstone/comparator/get_input_directions()
	return list(REVERSE_DIR(direction), turn(direction, 90), turn(direction, -90))

/obj/structure/redstone/comparator/get_connection_directions()
	return list(direction, REVERSE_DIR(direction), turn(direction, 90), turn(direction, -90))

/obj/structure/redstone/comparator/can_connect_to(obj/structure/redstone/other, dir)
	return TRUE // Connects on all sides

/obj/structure/redstone/comparator/can_receive_from(obj/structure/redstone/source, dir)
	return (dir in get_input_directions())

/obj/structure/redstone/comparator/get_network_neighbors()
	var/list/neighbors = list()

	// 1. Get standard Redstone Neighbors (Wire, Dust, Repeaters)
	// We check inputs (Rear, Left, Right) and Output (Front)
	for(var/dir in get_connection_directions())
		var/turf/T = get_step(src, dir)
		for(var/obj/structure/redstone/R in T)
			if(can_connect_to(R, dir) && R.can_connect_to(src, REVERSE_DIR(dir)))
				neighbors += R

	// 2. Wall Power OUTPUT (Front)
	// If facing a wall, we join the network of things touching that wall (including Up/Down for Multi-Z)
	var/turf/front = get_step(src, direction)
	if(isclosedturf(front))
		neighbors |= get_wall_power_neighbors(direction, front)

	// 3. Wall Power INPUT (Rear & Sides)
	// If there is a wall behind us or to the side, we need to network with the sources *powering* that wall
	for(var/input_dir in get_input_directions())
		var/turf/T = get_step(src, input_dir)
		if(isclosedturf(T))
			neighbors |= get_wall_power_sources(input_dir, T)

	return neighbors

/obj/structure/redstone/comparator/proc/get_wall_power_sources(input_dir, turf/wall_turf)
	var/list/sources = list()
	for(var/check_dir in GLOB.cardinals)
		if(check_dir == REVERSE_DIR(input_dir)) continue // Don't check back at ourselves

		var/turf/beyond_wall = get_step(wall_turf, check_dir)
		for(var/obj/structure/redstone/R in beyond_wall)
			if(!R.send_wall_power) continue
			// Is this component pointing AT the wall?
			var/dir_to_wall = REVERSE_DIR(check_dir)
			if(dir_to_wall in R.get_output_directions())
				sources += R
	return sources

/obj/structure/redstone/comparator/get_wall_power_neighbors(direction, turf/wall_turf)
	var/list/neighbors = list()

	// 1. Horizontal
	for(var/check_dir in GLOB.cardinals)
		if(check_dir == REVERSE_DIR(direction)) continue
		var/turf/beyond_wall = get_step(wall_turf, check_dir)

		for(var/obj/structure/redstone/dust/dust in beyond_wall)
			neighbors += dust
		for(var/obj/structure/redstone/repeater/rep in beyond_wall)
			if(REVERSE_DIR(rep.facing_dir) == REVERSE_DIR(check_dir)) neighbors += rep

	// 2. Vertical (Multi-Z)
	var/turf/above = GET_TURF_ABOVE(wall_turf)
	if(above)
		for(var/obj/structure/redstone/dust/dust in above) neighbors += dust

	var/turf/below = GET_TURF_BELOW(wall_turf)
	if(below)
		for(var/obj/structure/redstone/dust/dust in below) neighbors += dust

	return neighbors

/obj/structure/redstone/comparator/process()
	var/old_main = main_input
	var/storage_signal = get_storage_signal()

	if(storage_signal > main_input)
		main_input = storage_signal
		recalculate_output()
	else if(storage_signal < main_input && old_main == storage_signal)
		on_power_changed()

/obj/structure/redstone/comparator/on_power_changed()
	// 1. Calculate Side Inputs
	var/left_dir = turn(direction, 90)
	var/right_dir = turn(direction, -90)

	side_input_left = get_power_from_side(left_dir)
	side_input_right = get_power_from_side(right_dir)

	// 2. Calculate Main Input (Rear)
	var/rear_dir = REVERSE_DIR(direction)
	var/redstone_signal = get_power_from_side(rear_dir)
	var/storage_signal = get_storage_signal()

	main_input = max(redstone_signal, storage_signal)

	// 3. Output
	recalculate_output()

/obj/structure/redstone/comparator/proc/get_power_from_side(side_dir)
	var/turf/T = get_step(src, side_dir)
	var/found_power = 0

	// A. Direct Connection
	for(var/obj/structure/redstone/R in T)
		if(R.can_connect_to(src, REVERSE_DIR(side_dir))) // Standard Check
			found_power = max(found_power, R.get_effective_power())

	// B. Wall Power (Reading through a block)
	if(isclosedturf(T))
		// Check everything touching that wall
		for(var/check_dir in GLOB.cardinals)
			if(check_dir == REVERSE_DIR(side_dir)) continue // Don't look back at us

			var/turf/source_turf = get_step(T, check_dir)
			for(var/obj/structure/redstone/R in source_turf)
				if(R.send_wall_power)
					// Is it pointing AT the block?
					if(REVERSE_DIR(check_dir) in R.get_output_directions())
						found_power = max(found_power, R.get_effective_power())

	return found_power

/obj/structure/redstone/comparator/proc/recalculate_output()
	var/max_side = max(side_input_left, side_input_right)
	var/new_output = 0

	if(mode == "compare")
		new_output = (main_input >= max_side) ? main_input : 0
	else // subtract
		new_output = max(0, main_input - max_side)

	if(new_output != output_power)
		output_power = new_output
		power_level = output_power

		// Visuals
		update_appearance(UPDATE_OVERLAYS)

		// Update Network
		schedule_network_update()

/obj/structure/redstone/comparator/proc/get_storage_signal()
	var/turf/back_turf = get_step(src, REVERSE_DIR(direction))

	// 1. Direct Storage
	for(var/obj/O in back_turf)
		var/datum/component/storage/storage_comp = O.GetComponent(/datum/component/storage)
		if(storage_comp)
			return calculate_storage_fullness(storage_comp, O)

	return 0

/obj/structure/redstone/comparator/proc/calculate_storage_fullness(datum/component/storage/storage_comp, obj/O)
	var/max_capacity = storage_comp.screen_max_rows * storage_comp.screen_max_columns
	if(max_capacity <= 0)
		return 0

	var/total = 0
	for(var/obj/item/item in O.contents)
		total += (item.grid_width / 32) * (item.grid_height / 32)

	return round((total / max_capacity) * 15)


/obj/structure/redstone/comparator/update_icon()
	. = ..()
	icon_state = (mode == "subtract") ? "comparator_subtract" : "comparator"
	dir = direction

/obj/structure/redstone/comparator/update_overlays()
	. = ..()
	var/mutable_appearance/rear_torch = mutable_appearance(icon, "torch_rear")
	rear_torch.color = (output_power > 0) ? "#FF0000" : "#8B4513"
	. += rear_torch
	if(output_power > 0)
		var/mutable_appearance/em = emissive_appearance(icon, "torch_rear")
		. += em

	var/mutable_appearance/front_torch = mutable_appearance(icon, "torch_front")
	front_torch.color = (mode == "subtract") ? "#FF0000" : "#8B4513"
	. += front_torch
	if(mode == "subtract")
		var/mutable_appearance/em = emissive_appearance(icon, "torch_front")
		. += em

/obj/structure/redstone/comparator/attack_hand(mob/user)
	mode = (mode == "compare") ? "subtract" : "compare"
	to_chat(user, "<span class='notice'>Mode changed to [mode].</span>")
	recalculate_output()
	update_appearance(UPDATE_ICON | UPDATE_OVERLAYS)

/obj/structure/redstone/comparator/AltClick(mob/user)
	if(!Adjacent(user)) return
	direction = turn(direction, 90)
	dir = direction
	to_chat(user, "<span class='notice'>You rotate the [name].</span>")

	// Rotation changes connections, so update network
	schedule_network_update()
	on_power_changed() // Recalculate local inputs immediately
