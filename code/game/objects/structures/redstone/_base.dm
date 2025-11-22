
/obj/structure/redstone
	name = "redstone component"
	icon = 'icons/obj/redstone.dmi'
	anchored = TRUE
	density = FALSE

	var/power_level = 0           // Current power level (0-15)
	var/redstone_role = 0         // Bitmask of roles
	var/can_connect_wires = TRUE  // Whether dust can connect to this
	var/send_wall_power = FALSE   // Whether this component can power through walls
	var/true_pattern              // For custom wire overlay patterns

	// Network tracking
	var/static/list/update_queue = list()
	var/static/updating_network = FALSE

/obj/structure/redstone/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/redstone/LateInitialize()
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

/obj/structure/redstone/Destroy()
	. = ..()
	var/list/neighbors = get_connected_neighbors()
	for(var/obj/structure/redstone/neighbor in neighbors)
		spawn(1)
			neighbor.schedule_network_update()

// ============================================
// NETWORK UPDATE SYSTEM
// ============================================

/obj/structure/redstone/proc/schedule_network_update()
	if(src in update_queue)
		return
	update_queue += src
	if(!updating_network)
		spawn(1)
			process_update_queue()

/obj/structure/redstone/proc/process_update_queue()
	if(updating_network)
		return
	updating_network = TRUE

	var/list/all_components = list()
	while(length(update_queue))
		var/obj/structure/redstone/R = update_queue[1]
		update_queue -= R
		if(!QDELETED(R))
			all_components |= R.get_network()

	if(length(all_components))
		recalculate_network(all_components)

	updating_network = FALSE

/proc/recalculate_network(list/components)
	// Step 1: Reset all non-source power levels
	for(var/obj/structure/redstone/R in components)
		if(!(R.redstone_role & REDSTONE_ROLE_SOURCE))
			R.power_level = 0

	// Step 2: Propagate from sources using BFS by power level
	var/list/to_process = list()

	// Start with all sources
	for(var/obj/structure/redstone/R in components)
		if(R.redstone_role & REDSTONE_ROLE_SOURCE)
			if(R.get_source_power() > 0)
				to_process += R

	// Process in order of power level (highest first)
	var/iterations = 0
	var/max_iterations = length(components) * 16 // Safety limit

	while(length(to_process) && iterations < max_iterations)
		iterations++

		// Find highest power component
		var/obj/structure/redstone/highest = null
		var/highest_power = -1
		for(var/obj/structure/redstone/R in to_process)
			var/p = R.get_effective_power()
			if(p > highest_power)
				highest_power = p
				highest = R

		if(!highest || highest_power <= 0)
			break

		to_process -= highest

		// Propagate to neighbors
		var/list/neighbors = highest.get_power_output_neighbors()
		for(var/obj/structure/redstone/neighbor in neighbors)
			if(neighbor.redstone_role & REDSTONE_ROLE_SOURCE)
				// Sources can be inverted (like torches)
				neighbor.receive_source_power(highest_power, highest)
				continue

			var/received = neighbor.calculate_received_power(highest_power, highest)
			if(received > neighbor.power_level)
				neighbor.power_level = received
				if(!(neighbor in to_process))
					to_process += neighbor

	// Step 3: Update all appearances and trigger outputs
	for(var/obj/structure/redstone/R in components)
		R.on_power_changed()
		R.update_appearance(UPDATE_OVERLAYS)

// ============================================
// COMPONENT INTERFACE PROCS
// ============================================

// Get all components in this network via BFS
/obj/structure/redstone/proc/get_network()
	var/list/network = list(src)
	var/list/to_check = list(src)

	while(length(to_check))
		var/obj/structure/redstone/current = to_check[1]
		to_check -= current

		// Regular wire connections
		var/list/neighbors = current.get_connected_neighbors()
		for(var/obj/structure/redstone/neighbor in neighbors)
			if(!(neighbor in network))
				network += neighbor
				to_check += neighbor

		// Also include wall-power connections in the network
		if(current.send_wall_power)
			for(var/direction in current.get_output_directions())
				var/turf/T = get_step(current, direction)
				if(isclosedturf(T))
					var/list/wall_neighbors = current.get_wall_power_neighbors(direction, T)
					for(var/obj/structure/redstone/neighbor in wall_neighbors)
						if(!(neighbor in network))
							network += neighbor
							to_check += neighbor

	return network

// Get neighbors this component connects to
/obj/structure/redstone/proc/get_connected_neighbors()
	var/list/neighbors = list()
	for(var/direction in get_connection_directions())
		var/turf/T = get_step(src, direction)
		for(var/obj/structure/redstone/R in T)
			if(can_connect_to(R, direction) && R.can_connect_to(src, REVERSE_DIR(direction)))
				neighbors += R
	return neighbors

// Get neighbors we output power TO
/obj/structure/redstone/proc/get_power_output_neighbors()
	var/list/neighbors = list()
	for(var/direction in get_output_directions())
		var/turf/T = get_step(src, direction)
		for(var/obj/structure/redstone/R in T)
			if(R.can_receive_from(src, REVERSE_DIR(direction)))
				neighbors += R

		// Check for wall power (powering torches through solid blocks)
		if(send_wall_power && isclosedturf(T))
			var/list/wall_neighbors = get_wall_power_neighbors(direction, T)
			neighbors |= wall_neighbors

	return neighbors

// Find components that can be powered through a wall
/obj/structure/redstone/proc/get_wall_power_neighbors(direction, turf/wall_turf)
	var/list/neighbors = list()

	for(var/check_dir in GLOB.cardinals)
		if(check_dir == REVERSE_DIR(direction))
			continue  // Don't check back towards source

		var/turf/beyond_wall = get_step(wall_turf, check_dir)
		for(var/obj/structure/redstone/torch/torch in beyond_wall)
			// Check if torch is attached to this wall
			if(torch.attached_dir == REVERSE_DIR(check_dir))
				neighbors += torch

		for(var/obj/structure/redstone/dust/dust in beyond_wall)
			neighbors += dust

	return neighbors

// Directions we can connect wires to
/obj/structure/redstone/proc/get_connection_directions()
	return GLOB.cardinals

// Directions we output power to
/obj/structure/redstone/proc/get_output_directions()
	return GLOB.cardinals

// Directions we accept power from
/obj/structure/redstone/proc/get_input_directions()
	return GLOB.cardinals

// Can we connect to this component?
/obj/structure/redstone/proc/can_connect_to(obj/structure/redstone/other, direction)
	return can_connect_wires

// Can we receive power from this source?
/obj/structure/redstone/proc/can_receive_from(obj/structure/redstone/source, direction)
	if(!can_connect_wires)
		return FALSE
	return (direction in get_input_directions())

// For sources: what power do we generate?
/obj/structure/redstone/proc/get_source_power()
	return 0

// For all: what power do we effectively have for propagation?
/obj/structure/redstone/proc/get_effective_power()
	if(redstone_role & REDSTONE_ROLE_SOURCE)
		return get_source_power()
	return power_level

// Calculate power received from a neighbor
/obj/structure/redstone/proc/calculate_received_power(incoming_power, obj/structure/redstone/source)
	return incoming_power

// For sources that can be inverted (torches)
/obj/structure/redstone/proc/receive_source_power(incoming_power, obj/structure/redstone/source)
	return

// Called after power calculation is complete
/obj/structure/redstone/proc/on_power_changed()
	return

// ============================================
// OVERLAYS
// ============================================
/obj/structure/redstone/update_overlays()
	. = ..()
	if(!can_connect_wires)
		return

	var/wire_pattern = ""
	// Order matters for icon_state naming: SOUTH(2), NORTH(1), WEST(8), EAST(4)
	for(var/direction in list(SOUTH, NORTH, WEST, EAST))
		var/turf/T = get_step(src, direction)
		for(var/obj/structure/redstone/R in T)
			if(can_connect_to(R, direction) && R.can_connect_to(src, REVERSE_DIR(direction)))
				wire_pattern += "[direction]"
				break

	var/pattern_to_use = true_pattern ? true_pattern : (wire_pattern ? wire_pattern : "wire")
	var/mutable_appearance/wire_overlay = mutable_appearance(icon, "wire_[pattern_to_use]")
	wire_overlay.layer = layer + 0.01
	wire_overlay.color = (power_level > 0) ? "#FF0000" : "#8B4513"
	. += wire_overlay

/proc/trigger_redstone_at(turf/T, power_level, mob/user)
	for(var/obj/structure/redstone/component in T)
		if(component.can_connect_wires)
			// Temporarily act as a source
			component.power_level = max(component.power_level, power_level)
			component.schedule_network_update()
