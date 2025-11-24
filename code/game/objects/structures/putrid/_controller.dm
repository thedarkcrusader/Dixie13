/obj/effect/meatvine_controller
	var/list/obj/structure/meatvine/vines = list()
	var/list/growth_queue = list()
	var/reached_collapse_size
	var/reached_slowdown_size
	var/isdying = FALSE

	// Growth thresholds
	var/slowdown_size = 200
	var/collapse_size = 1000

	// Papameat spawning
	var/papameat_spawn_threshold = 50 // Minimum vines before first papameat
	var/papameat_spawn_interval = 150 // Spawn new papameat every X vines
	var/max_papameats = 5 // Maximum papameats at once
	var/list/obj/structure/meatvine/papameat/papameats = list()

	// Organic matter feeding system
	var/organic_matter = 0
	var/organic_matter_max = 1000
	var/organic_matter_per_humor = 250 // Cost to spawn a humor node
	var/humor_spawn_chance = 5 // Base chance per process tick when at max matter

	// Humor tracking
	var/list/spawned_humors = list()

/obj/effect/meatvine_controller/Initialize(mapload, ...)
	. = ..()
	if(!isfloorturf(loc))
		return INITIALIZE_HINT_QDEL
	var/obj/structure/meatvine/SV = locate() in src.loc
	if(!SV)
		spawn_spacevine_piece(src.loc)
	else
		SV.master = src
		growth_queue += SV
		vines += SV
	START_PROCESSING(SSfastprocess, src)

/obj/effect/meatvine_controller/proc/die()
	isdying = TRUE

/obj/effect/meatvine_controller/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	papameats.Cut()
	spawned_humors.Cut()
	return ..()

/obj/effect/meatvine_controller/proc/spawn_spacevine_piece(turf/location, piece_type = /obj/structure/meatvine/floor)
	var/obj/structure/meatvine/SV = new piece_type(location)
	SV.master = src
	growth_queue += SV
	vines += SV

	// Track papameats separately
	if(istype(SV, /obj/structure/meatvine/papameat))
		papameats += SV

/obj/effect/meatvine_controller/proc/can_spawn_papameat()
	if(vines.len < papameat_spawn_threshold)
		return FALSE
	if(papameats.len >= max_papameats)
		return FALSE

	// Calculate how many papameats we should have based on size
	var/expected_papameats = round((vines.len - papameat_spawn_threshold) / papameat_spawn_interval) + 1
	expected_papameats = min(expected_papameats, max_papameats)

	return papameats.len < expected_papameats

/obj/effect/meatvine_controller/proc/try_spawn_papameat()
	if(!can_spawn_papameat())
		return FALSE

	// Find a suitable vine to convert
	var/list/candidates = list()
	for(var/obj/structure/meatvine/floor/SV in vines)
		if(istype(SV, /obj/structure/meatvine/papameat))
			continue
		if(!isfloorturf(SV.loc))
			continue

		// Check if 5x5 area is clear
		if(!check_papameat_clearance(SV.loc))
			continue

		// Prefer vines farther from existing papameats
		var/min_dist = INFINITY
		for(var/obj/structure/meatvine/papameat/PM in papameats)
			var/dist = get_dist(SV, PM)
			if(dist < min_dist)
				min_dist = dist
		if(min_dist > 10) // At least 10 tiles from nearest papameat
			candidates += SV

	if(!length(candidates))
		// Fallback: just pick any floor vine with clearance
		for(var/obj/structure/meatvine/floor/SV in vines)
			if(!istype(SV, /obj/structure/meatvine/papameat))
				if(check_papameat_clearance(SV.loc))
					candidates += SV

	if(!length(candidates))
		return FALSE

	var/obj/structure/meatvine/floor/chosen = pick(candidates)
	var/turf/spawn_loc = get_turf(chosen)

	// Remove old vine from lists
	vines -= chosen
	growth_queue -= chosen
	qdel(chosen)

	// Spawn papameat
	spawn_spacevine_piece(spawn_loc, /obj/structure/meatvine/papameat)

	return TRUE

/obj/effect/meatvine_controller/proc/check_papameat_clearance(turf/center)
	// Check 5x5 area centered on the turf (2 tiles in each direction)
	for(var/turf/T in range(2, center))
		if(!isfloorturf(T))
			return FALSE
		if(T.is_blocked_turf())
			return FALSE
		// Check for obstructions
		if(locate(/obj/structure/meatvine/heavy) in T)
			return FALSE
		if(locate(/obj/structure/meatvine/papameat) in T)
			return FALSE
		if(locate(/obj/structure/meatvine/lair) in T)
			return FALSE
	return TRUE

/obj/effect/meatvine_controller/proc/feed_organic_matter(amount)
	organic_matter = min(organic_matter + amount, organic_matter_max)

	// Visual feedback
	var/turf/T = get_turf(src)
	if(T)
		T.pollute_turf(/datum/pollutant/rot, 50)

/obj/effect/meatvine_controller/proc/try_spawn_humor()
	if(organic_matter < organic_matter_per_humor)
		return FALSE

	if(!prob(humor_spawn_chance))
		return FALSE

	// Find a suitable location near a papameat or the controller
	var/list/spawn_locations = list()

	for(var/obj/structure/meatvine/papameat/PM in papameats)
		if(PM.master == src)
			spawn_locations += get_turf(PM)

	if(!length(spawn_locations))
		spawn_locations += get_turf(src)

	var/turf/spawn_turf = pick(spawn_locations)

	// Create the humor node
	var/obj/item/chimeric_node/humor = new()
	humor.forceMove(spawn_turf)

	// Setup the node with putrid blood type table
	var/datum/chimeric_table/putrid/table = new()

	var/list/available_slots = list()
	var/list/inputs = subtypesof(/datum/chimeric_node/input)
	var/list/outputs = subtypesof(/datum/chimeric_node/output)
	var/list/specials = subtypesof(/datum/chimeric_node/special)

	if(length(inputs))
		available_slots[INPUT_NODE] = 10
	if(length(outputs))
		available_slots[OUTPUT_NODE] = 10
	if(length(specials))
		available_slots[SPECIAL_NODE] = 1

	if(!length(available_slots))
		available_slots = list(INPUT_NODE = 10, OUTPUT_NODE = 10, SPECIAL_NODE = 1)

	var/selected_slot = pickweight(available_slots)
	var/list/node_pool

	switch(selected_slot)
		if(INPUT_NODE)
			node_pool = inputs
		if(OUTPUT_NODE)
			node_pool = outputs
		if(SPECIAL_NODE)
			node_pool = specials

	if(!length(node_pool))
		node_pool = get_weighted_nodes_by_tier(selected_slot, 3)
	else
		var/list/tier_nodes = get_weighted_nodes_by_tier(selected_slot, 3)
		for(var/node_type in tier_nodes)
			if(node_type in node_pool)
				node_pool[node_type] += tier_nodes[node_type]
			else
				node_pool[node_type] = tier_nodes[node_type]

	if(length(node_pool))
		var/datum/chimeric_node/selected_node_type = pickweight(node_pool)
		humor.node_tier = rand(1, 3)
		humor.node_purity = rand(25, 120)
		humor.setup_node(
			selected_node_type,
			table.compatible_blood_types,
			table.incompatible_blood_types,
			table.preferred_blood_types,
			table.base_blood_cost,
			table.preferred_blood_bonus,
			table.incompatible_blood_penalty,
		)

	qdel(table)

	organic_matter -= organic_matter_per_humor
	spawned_humors += humor

	return TRUE

/obj/effect/meatvine_controller/process()
	if(!vines.len)
		qdel(src)
		return
	if(!growth_queue)
		qdel(src)
		return

	// Try to spawn papameat
	if(prob(10)) // 10% chance per tick
		try_spawn_papameat()

	// Try to spawn humor if conditions are met
	if(organic_matter >= organic_matter_per_humor)
		try_spawn_humor()

	// Clean up dead papameats from tracking list
	for(var/obj/structure/meatvine/papameat/PM in papameats)
		if(QDELETED(PM) || PM.master != src)
			papameats -= PM

	if(vines.len >= collapse_size && !reached_collapse_size)
		reached_collapse_size = 1
	if(vines.len >= slowdown_size && !reached_slowdown_size)
		reached_slowdown_size = 1

	var/length = min(slowdown_size, vines.len)
	if(reached_collapse_size)
		length = 25
	else if(reached_slowdown_size)
		length = min(slowdown_size, vines.len / 10)

	if(!length)
		return

	var/i = 0
	var/list/obj/structure/meatvine/queue_end = list()
	for(var/obj/structure/meatvine/SV in growth_queue)
		i++
		growth_queue -= SV
		if(isdying)
			SV.rot()
			vines -= SV
		else
			queue_end += SV
			if(prob(20))
				SV.grow()
				continue
			else
				if(prob(25))
					var/mob/living/carbon/C = locate() in SV.loc
					if(C)
						if(!C.buckled)
							SV.buckle_mob(C)
						else
							C.try_wrap_up("meat", "meatthings")
			if(!reached_collapse_size)
				SV.spread()
		if(i >= length)
			break
	growth_queue = growth_queue + queue_end
