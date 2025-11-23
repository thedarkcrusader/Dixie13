/obj/structure/redstone
	name = "redstone component"
	icon = 'icons/obj/redstone.dmi'
	anchored = TRUE
	density = FALSE

	var/power_level = 0           // Current power level (0-15)
	var/redstone_role = NONE         // Bitmask of roles
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
	// BUT: check if component is actively outputting (like a repeater with output_active)
	for(var/obj/structure/redstone/R in components)
		if(R.redstone_role & REDSTONE_ROLE_SOURCE)
			continue
		// Check if this component is actively generating power (processors like repeaters)
		if(R.get_source_power() > 0)
			continue
		R.power_level = 0

	// Step 2: Propagate from sources using BFS by power level
	var/list/to_process = list()

	// Start with all sources AND any component actively outputting power
	for(var/obj/structure/redstone/R in components)
		if(R.get_source_power() > 0)
			to_process += R

	// Process in order of power level (highest first)
	var/iterations = 0
	var/max_iterations = length(components) * 16

	while(length(to_process) && iterations < max_iterations)
		iterations++

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

		var/list/neighbors = highest.get_power_output_neighbors()
		for(var/obj/structure/redstone/neighbor in neighbors)
			if(neighbor.redstone_role & REDSTONE_ROLE_SOURCE)
				neighbor.receive_source_power(highest_power, highest)
				var/source_power = neighbor.get_source_power()
				if(source_power > 0 && !(neighbor in to_process))
					to_process += neighbor
				continue

			// Skip neighbors that are actively outputting - they're self-powered
			if(neighbor.get_source_power() > 0)
				if(!(neighbor in to_process))
					to_process += neighbor
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
		R.trigger_adjacent_structures()

// ============================================
// NON-REDSTONE STRUCTURE INTERACTION
// ============================================

/obj/structure/redstone/proc/trigger_adjacent_structures()
	// Check all adjacent turfs for non-redstone structures
	for(var/direction in GLOB.cardinals)
		var/turf/T = get_step(src, direction)
		if(!T)
			continue

		// Check for wall power transmission
		if(send_wall_power && isclosedturf(T))
			trigger_structures_through_wall(direction, T)
		else
			// Direct adjacency
			for(var/obj/structure/S in T)
				if(S.redstone_structure && !istype(S, /obj/structure/redstone))
					// Only trigger on powered/unpowered state changes (0 to non-zero or non-zero to 0)
					var/was_powered = (S.last_redstone_power > 0)
					var/is_powered = (power_level > 0)
					if(was_powered != is_powered)
						S.last_redstone_power = power_level
						S.redstone_triggered(power_level, src)

	// Also check current turf
	for(var/obj/structure/S in loc)
		if(S.redstone_structure && !istype(S, /obj/structure/redstone))
			// Only trigger on powered/unpowered state changes
			var/was_powered = (S.last_redstone_power > 0)
			var/is_powered = (power_level > 0)
			if(was_powered != is_powered)
				S.last_redstone_power = power_level
				S.redstone_triggered(power_level, src)

/obj/structure/redstone/proc/trigger_structures_through_wall(direction, turf/wall_turf)
	// Check all sides of the wall for non-redstone structures
	for(var/check_dir in GLOB.cardinals)
		if(check_dir == REVERSE_DIR(direction))
			continue  // Don't check back towards source

		var/turf/beyond_wall = get_step(wall_turf, check_dir)
		if(!beyond_wall)
			continue

		for(var/obj/structure/S in beyond_wall)
			if(S.redstone_structure && !istype(S, /obj/structure/redstone))
				// Only trigger on powered/unpowered state changes
				var/was_powered = (S.last_redstone_power > 0)
				var/is_powered = (power_level > 0)
				if(was_powered != is_powered)
					S.last_redstone_power = power_level
					S.redstone_triggered(power_level, src)

// ============================================
// COMPONENT INTERFACE PROCS
// ============================================

/obj/structure/redstone/proc/get_network_neighbors()
	// By default, same as connected neighbors
	return get_connected_neighbors()

// Get all components in this network via BFS
/obj/structure/redstone/proc/get_network()
	var/list/network = list(src)
	var/list/to_check = list(src)

	while(length(to_check))
		var/obj/structure/redstone/current = to_check[1]
		to_check -= current

		// Get neighbors for network traversal (this may be different from power output)
		var/list/neighbors = current.get_network_neighbors()
		for(var/obj/structure/redstone/neighbor in neighbors)
			if(!(neighbor in network))
				network += neighbor
				to_check += neighbor

		// Wall-power connections: check in BOTH directions
		// 1. If this component sends wall power, include recipients
		if(current.send_wall_power)
			// Check ALL cardinal directions for walls, not just output directions
			for(var/direction in GLOB.cardinals)
				var/turf/T = get_step(current, direction)
				if(isclosedturf(T))
					var/list/wall_neighbors = current.get_wall_power_neighbors(direction, T)
					for(var/obj/structure/redstone/neighbor in wall_neighbors)
						if(!(neighbor in network))
							network += neighbor
							to_check += neighbor

		// 2. If this component can receive wall power, find sources through walls
		if(current.can_connect_wires)
			for(var/direction in GLOB.cardinals)
				var/turf/T = get_step(current, direction)
				if(isclosedturf(T))
					// Check all sides of the wall for components
					for(var/check_dir in GLOB.cardinals)
						var/turf/source_turf = get_step(T, check_dir)
						for(var/obj/structure/redstone/potential_source in source_turf)
							var/should_include = FALSE

							// Include if they can send wall power to us
							if(potential_source.send_wall_power)
								// Check if we're in their wall power range
								// We need to check the direction from the source TO the wall
								var/source_to_wall_dir = REVERSE_DIR(check_dir)

								// Manually check if we can be powered through this wall
								// Don't use get_wall_power_neighbors since it has the REVERSE_DIR check
								var/turf/wall_from_source = get_step(potential_source, source_to_wall_dir)
								if(wall_from_source == T)
									// Check if we're on a valid side of this wall from the source's perspective
									for(var/final_check_dir in GLOB.cardinals)
										var/turf/check_turf = get_step(T, final_check_dir)
										if(check_turf == current.loc)
											should_include = TRUE
											break

							// Also include any dust/wire on the other side
							else if(potential_source.can_connect_wires)
								should_include = TRUE

							if(should_include && !(potential_source in network))
								network += potential_source
								to_check += potential_source

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
			continue

		var/turf/beyond_wall = get_step(wall_turf, check_dir)

		for(var/obj/structure/redstone/torch/torch in beyond_wall)
			if(torch.attached_dir == REVERSE_DIR(check_dir))
				neighbors += torch

		for(var/obj/structure/redstone/dust/dust in beyond_wall)
			neighbors += dust

		// Add repeaters that face toward or away from the wall
		for(var/obj/structure/redstone/repeater/rep in beyond_wall)
			// Include if repeater's input faces the wall
			if(REVERSE_DIR(rep.facing_dir) == REVERSE_DIR(check_dir))
				neighbors += rep

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
