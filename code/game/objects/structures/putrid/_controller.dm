/obj/effect/meatvine_controller
	var/list/obj/structure/meatvine/vines = list()
	var/list/growth_queue = list()
	var/reached_collapse_size
	var/reached_slowdown_size
	var/isdying = FALSE

	// Growth thresholds
	var/slowdown_size = 2000000
	var/collapse_size = 10000000

	// Papameat spawning - DYNAMIC BASED ON AREA SIZE
	var/papameat_spawn_threshold = 30 // Minimum vines before first papameat
	var/papameat_vines_per_papameat = 100 // How many vines support each papameat
	var/list/obj/structure/meatvine/papameat/papameats = list()

	// Organic matter feeding system
	var/organic_matter = 0
	var/organic_matter_max = 2000
	var/organic_matter_per_spread = 2 // Cost per spread when accelerated
	var/organic_matter_per_humor = 250 // Cost to spawn a humor node

	// Feed tracking for humor spawning
	var/total_feeds = 0 // Total number of times we've been fed
	var/feeds_per_humor = 3 // Spawn humor every X feeds
	var/humor_spawn_chance = 5 // Base chance per process tick when at max matter

	// Wall generation system
	var/list/wall_segments = list()
	var/wall_generation_cooldown = 0
	var/min_wall_generation_interval = 50
	var/wall_budget = 0
	var/wall_budget_per_tick = 0.5
	var/wall_cost = 10

	var/consumed_resource_pool = 0
	var/consumed_resource_max = 500
	var/consumed_resource_regen_rate = 2 // Per process tick

	// Wall pattern preferences
	var/list/wall_patterns = list(
		"corridor" = 3,
		"chamber" = 2,
		"snake" = 4,
		"junction" = 2
	)

	// Papameat death mechanics
	var/vines_lost_per_papameat_death = 150 // How many vines die when a papameat is destroyed

	var/list/blocked_spread_locations = list()
	var/list/obstacle_targets = list()
	var/bridge_request_cooldown = 0
	var/bridge_request_interval = 10

	var/list/obj/structure/meatvine/lair/lairs = list()
	var/lair_spawn_threshold = 10 // Minimum vines before first lair
	var/lair_vines_per_lair = 30 // How many vines support each lair
	var/min_lair_spacing = 5 // Minimum distance between lairs

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
	return ..()

/obj/effect/meatvine_controller/proc/spawn_spacevine_piece(turf/location, piece_type = /obj/structure/meatvine/floor)
	var/obj/structure/meatvine/SV = new piece_type(location)
	SV.master = src
	growth_queue += SV
	vines += SV

	// Track papameats separately
	if(istype(SV, /obj/structure/meatvine/papameat))
		papameats += SV
	if(istype(SV, /obj/structure/meatvine/lair))
		lairs += SV


/obj/effect/meatvine_controller/proc/get_max_lairs()
	// Calculate maximum lairs based on current vine count
	if(vines.len < lair_spawn_threshold)
		return 0

	return max(1, round((vines.len - lair_spawn_threshold) / lair_vines_per_lair) + 1)

/obj/effect/meatvine_controller/proc/can_spawn_lair()
	var/max_lairs = get_max_lairs()

	if(max_lairs <= 0)
		return FALSE

	if(lairs.len >= max_lairs)
		return FALSE

	return TRUE

/obj/effect/meatvine_controller/proc/can_spawn_lair_at(turf/T)
	// Check if we can spawn any lairs at all
	if(!can_spawn_lair())
		return FALSE

	// Check spacing from existing lairs
	for(var/obj/structure/meatvine/lair/existing_lair in lairs)
		if(get_dist(T, existing_lair) < min_lair_spacing)
			return FALSE

	// Check spacing from papameats (lairs shouldn't block papameat areas)
	for(var/obj/structure/meatvine/papameat/PM in papameats)
		if(get_dist(T, PM) < 8)
			return FALSE

	return TRUE

/obj/effect/meatvine_controller/proc/get_max_papameats()
	// Calculate maximum papameats based on current vine count
	if(vines.len < papameat_spawn_threshold)
		return 0

	return max(1, round((vines.len - papameat_spawn_threshold) / papameat_vines_per_papameat) + 1)

/obj/effect/meatvine_controller/proc/can_spawn_papameat()
	var/max_papameats = get_max_papameats()

	if(max_papameats <= 0)
		return FALSE

	if(papameats.len >= max_papameats)
		return FALSE

	return TRUE

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


/obj/effect/meatvine_controller/proc/lair_destroyed(obj/structure/meatvine/lair/dead_lair)
	// Remove from tracking
	lairs -= dead_lair

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
	consumed_resource_pool = min(consumed_resource_max, consumed_resource_pool + amount)
	total_feeds++

	// Visual feedback
	var/turf/T = get_turf(src)
	if(T)
		T.pollute_turf(/datum/pollutant/rot, 50)

	// Check if we should spawn humor based on feed count
	if(total_feeds >= feeds_per_humor)
		try_spawn_humor_from_feeds()

/obj/effect/meatvine_controller/proc/try_spawn_humor()
	if(organic_matter < organic_matter_per_humor)
		return FALSE

	if(!prob(humor_spawn_chance))
		return FALSE

	return spawn_humor_node()

/obj/effect/meatvine_controller/proc/try_spawn_humor_from_feeds()
	// Guaranteed humor spawn based on feed count
	if(total_feeds < feeds_per_humor)
		return FALSE

	total_feeds -= feeds_per_humor
	return spawn_humor_node()

/obj/effect/meatvine_controller/proc/spawn_humor_node()
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

	// Only consume organic matter if we spawned from matter (not feeds)
	if(organic_matter >= organic_matter_per_humor)
		organic_matter -= organic_matter_per_humor

	return TRUE

/obj/effect/meatvine_controller/proc/papameat_destroyed(obj/structure/meatvine/papameat/dead_papameat)
	// Remove from tracking
	papameats -= dead_papameat

	// Kill a portion of the vines
	var/vines_to_kill = min(vines_lost_per_papameat_death, vines.len - 1) // Always leave at least 1

	if(vines_to_kill <= 0)
		return

	// Prioritize killing vines farthest from remaining papameats
	var/list/vine_distances = list()

	for(var/obj/structure/meatvine/SV in vines)
		if(istype(SV, /obj/structure/meatvine/papameat))
			continue // Don't kill other papameats

		var/min_dist = INFINITY

		// Find distance to nearest remaining papameat
		for(var/obj/structure/meatvine/papameat/PM in papameats)
			var/dist = get_dist(SV, PM)
			if(dist < min_dist)
				min_dist = dist

		// If no papameats left, just use distance from controller
		if(min_dist == INFINITY)
			min_dist = get_dist(SV, src)

		vine_distances[SV] = min_dist

	// Sort by distance (farthest first)
	var/list/sorted_vines = sortTim(vine_distances, GLOBAL_PROC_REF(cmp_numeric_dsc), associative = TRUE)

	// Kill the farthest vines
	var/killed = 0
	for(var/obj/structure/meatvine/SV in sorted_vines)
		if(killed >= vines_to_kill)
			break

		SV.rot()
		vines -= SV
		growth_queue -= SV

		killed++

	// Visual effect at papameat location
	var/turf/death_turf = get_turf(dead_papameat)
	if(death_turf)
		death_turf.pollute_turf(/datum/pollutant/rot, 200)
		// Could add more visual effects here
	if(!length(papameats))
		die()

/obj/effect/meatvine_controller/process()
	if(!vines.len)
		qdel(src)
		return
	if(!growth_queue)
		qdel(src)
		return

	// Try to spawn papameat if we need more
	if(prob(10))
		try_spawn_papameat()

	// Try to spawn humor from organic matter
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

			// Enhanced growth chance with organic matter
			var/growth_chance = 20
			var/can_use_matter = organic_matter >= organic_matter_per_spread

			if(can_use_matter)
				growth_chance = 40 // Double chance when we have organic matter

			if(prob(growth_chance))
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
				// Try to spread with organic matter boost
				if(can_use_matter && prob(50)) // 50% chance to use matter for spread
					organic_matter -= organic_matter_per_spread
					SV.spread()
					SV.spread() // Spread twice when using organic matter
				else
					SV.spread()

		if(i >= length)
			break
	growth_queue = growth_queue + queue_end

	// Accumulate wall budget
	if(vines.len >= min_wall_generation_interval)
		wall_budget += wall_budget_per_tick

		// Try to generate walls when we have budget
		if(wall_budget >= wall_cost && wall_generation_cooldown <= 0)
			if(prob(15))
				attempt_wall_generation()

	// Update existing wall segments
	update_wall_segments()

	// Decay cooldown
	if(wall_generation_cooldown > 0)
		wall_generation_cooldown--

	if(bridge_request_cooldown > 0)
		bridge_request_cooldown--

	// Check for blocked spreads and request bridging
	if(bridge_request_cooldown <= 0 && prob(20))
		check_for_bridge_opportunities()

	// Clean up dead lairs from tracking list
	for(var/obj/structure/meatvine/lair/L in lairs)
		if(QDELETED(L) || L.master != src)
			lairs -= L

	// Regenerate resource pool for consumed mobs
	if(consumed_resource_pool < consumed_resource_max)
		consumed_resource_pool = min(consumed_resource_pool + consumed_resource_regen_rate, consumed_resource_max)

	SEND_SIGNAL(src, COMSIG_MEATVINE_RESOURCE_CHANGE, consumed_resource_pool)


/obj/effect/meatvine_controller/proc/consume_client_mob(mob/living/C)
	if(!C.client)
		return FALSE

	// Create a consumed ghost mob
	var/mob/living/simple_animal/hostile/retaliate/meatvine/consumed = new(get_turf(C))
	consumed.master = src
	// Transfer client
	C.client.mob = consumed
	consumed.ckey = C.ckey

	to_chat(consumed, "<span class='userdanger'>You have been consumed by the meatvine! You can now spread it using your abilities.</span>")
	return TRUE

/obj/effect/meatvine_controller/proc/try_spend_resources(amount)
	if(consumed_resource_pool >= amount)
		consumed_resource_pool -= amount
		return TRUE
	return FALSE

/obj/effect/meatvine_controller/proc/check_for_bridge_opportunities()
	if(!length(vines))
		return

	// Sample some vines to check for blocked spreads
	var/checks = min(10, vines.len)
	for(var/i = 1 to checks)
		var/obj/structure/meatvine/SV = pick(vines)
		var/turf/vine_turf = get_turf(SV)

		for(var/direction in GLOB.cardinals)
			var/turf/blocked = get_step(vine_turf, direction)

			// Check if this location blocks spreading
			if(!can_spread_to(blocked))
				// Look ahead to see if we can bridge across
				var/turf/bridge_target = find_bridge_target(vine_turf, direction)
				if(bridge_target)
					request_bridge(blocked, bridge_target)
					bridge_request_cooldown = bridge_request_interval
					return

/obj/effect/meatvine_controller/proc/can_spread_to(turf/T)
	if(!T)
		return FALSE
	if(istype(T, /turf/open/transparent/openspace))
		return FALSE
	if(istype(T, /turf/open/water))
		return FALSE
	if(istype(T, /turf/open/lava))
		return FALSE
	return TRUE


/obj/effect/meatvine_controller/proc/find_bridge_target(turf/start, direction)
	// Look up to 3 tiles ahead in the direction
	var/turf/current = start

	for(var/i = 1 to 3)
		current = get_step(current, direction)
		if(!current)
			return null

		// If we find a valid spread location, this is our bridge target
		if(can_spread_to(current) && isfloorturf(current))
			// Make sure there's not already a vine here
			if(!locate(/obj/structure/meatvine) in current)
				return current

	return null

/obj/effect/meatvine_controller/proc/request_bridge(turf/blocked_turf, turf/target_turf)
	// Store this bridge request
	var/datum/bridge_request/request = new()
	request.blocked_location = blocked_turf
	request.target_location = target_turf
	request.timestamp = world.time

	blocked_spread_locations += request

/obj/effect/meatvine_controller/proc/mark_obstacle_for_destruction(atom/obstacle)
	if(obstacle in obstacle_targets)
		return

	obstacle_targets += obstacle

/obj/effect/meatvine_controller/proc/check_obstacle_destroyed(atom/obstacle)
	if(obstacle in obstacle_targets)
		obstacle_targets -= obstacle

/obj/effect/meatvine_controller/proc/attempt_wall_generation()
	if(wall_budget < wall_cost)
		return FALSE

	// Pick a pattern
	var/pattern = pickweight(wall_patterns)

	// Find a suitable starting location
	var/list/candidates = list()
	for(var/obj/structure/meatvine/floor/SV in vines)
		if(istype(SV, /obj/structure/meatvine/papameat))
			continue
		if(!isfloorturf(SV.loc))
			continue

		// Prefer locations with some open space around them
		var/open_count = 0
		for(var/direction in GLOB.cardinals)
			var/turf/T = get_step(SV.loc, direction)
			if(isfloorturf(T) && !locate(/obj/structure/meatvine/heavy, T))
				open_count++

		if(open_count >= 2)
			candidates += SV

	if(!length(candidates))
		return FALSE

	var/obj/structure/meatvine/start_vine = pick(candidates)
	var/turf/start_loc = get_turf(start_vine)

	// Create wall segment based on pattern
	var/datum/wall_segment/segment
	switch(pattern)
		if("corridor")
			segment = generate_corridor(start_loc)
		if("chamber")
			segment = generate_chamber(start_loc)
		if("snake")
			segment = generate_snake_wall(start_loc)
		if("junction")
			segment = generate_junction(start_loc)

	if(segment)
		if(!validate_wall_segment(segment))
			qdel(segment)
			return FALSE

		wall_segments += segment
		wall_budget -= wall_cost
		wall_generation_cooldown = rand(30, 60)
		return TRUE

	return FALSE

/obj/effect/meatvine_controller/proc/generate_corridor(turf/start_loc)
	var/direction = pick(GLOB.cardinals)
	var/perpendicular = turn(direction, pick(90, -90))

	var/datum/wall_segment/segment = new()
	segment.pattern_type = "corridor"
	segment.growth_rate = 1

	var/turf/current = start_loc
	var/length = rand(4, 8)
	for(var/i = 1 to length)
		var/turf/next = get_step(current, direction)
		if(!can_place_wall_at(next))
			break
		segment.planned_walls += next
		current = next

	current = get_step(start_loc, perpendicular)
	if(!can_place_wall_at(current))
		current = get_step(start_loc, turn(perpendicular, 180))

	if(can_place_wall_at(current))
		segment.planned_walls += current
		for(var/i = 1 to length)
			var/turf/next = get_step(current, direction)
			if(!can_place_wall_at(next))
				break
			segment.planned_walls += next
			current = next

	return length(segment.planned_walls) >= 4 ? segment : null

/obj/effect/meatvine_controller/proc/generate_chamber(turf/start_loc)
	var/datum/wall_segment/segment = new()
	segment.pattern_type = "chamber"
	segment.growth_rate = 1

	var/width = rand(3, 6)
	var/height = rand(3, 6)

	for(var/x = 0 to width)
		var/turf/top = locate(start_loc.x + x, start_loc.y + height, start_loc.z)
		var/turf/bottom = locate(start_loc.x + x, start_loc.y, start_loc.z)

		if(can_place_wall_at(top))
			segment.planned_walls += top
		if(can_place_wall_at(bottom))
			segment.planned_walls += bottom

	for(var/y = 1 to height - 1)
		var/turf/left = locate(start_loc.x, start_loc.y + y, start_loc.z)
		var/turf/right = locate(start_loc.x + width, start_loc.y + y, start_loc.z)

		if(can_place_wall_at(left))
			segment.planned_walls += left
		if(can_place_wall_at(right))
			segment.planned_walls += right

	if(length(segment.planned_walls) > 3)
		segment.planned_walls -= pick(segment.planned_walls)

	return length(segment.planned_walls) >= 6 ? segment : null

/obj/effect/meatvine_controller/proc/generate_snake_wall(turf/start_loc)
	var/datum/wall_segment/segment = new()
	segment.pattern_type = "snake"
	segment.growth_rate = 1

	var/turf/current = start_loc
	var/current_dir = pick(GLOB.cardinals)
	var/length = rand(6, 12)

	for(var/i = 1 to length)
		var/turf/next = get_step(current, current_dir)

		if(!can_place_wall_at(next))
			var/new_dir = pick(turn(current_dir, 90), turn(current_dir, -90))
			next = get_step(current, new_dir)

			if(!can_place_wall_at(next))
				break
			current_dir = new_dir

		segment.planned_walls += next
		current = next

		if(prob(30))
			current_dir = pick(turn(current_dir, 90), turn(current_dir, -90))

	return length(segment.planned_walls) >= 4 ? segment : null

/obj/effect/meatvine_controller/proc/generate_junction(turf/start_loc)
	var/datum/wall_segment/segment = new()
	segment.pattern_type = "junction"
	segment.growth_rate = 1

	var/main_dir = pick(GLOB.cardinals)
	var/make_plus = prob(50)

	var/length = rand(3, 5)
	for(var/i = -length to length)
		var/turf/T = get_step_multiz(start_loc, main_dir, i)
		if(can_place_wall_at(T))
			segment.planned_walls += T

	var/cross_dir = turn(main_dir, 90)
	for(var/i = 1 to length)
		var/turf/T = get_step_multiz(start_loc, cross_dir, i)
		if(can_place_wall_at(T))
			segment.planned_walls += T

	if(make_plus)
		cross_dir = turn(main_dir, -90)
		for(var/i = 1 to length)
			var/turf/T = get_step_multiz(start_loc, cross_dir, i)
			if(can_place_wall_at(T))
				segment.planned_walls += T

	return length(segment.planned_walls) >= 5 ? segment : null

/obj/effect/meatvine_controller/proc/can_place_wall_at(turf/T)
	if(!isfloorturf(T))
		return FALSE
	if(T.is_blocked_turf())
		return FALSE

	if(locate(/obj/structure/meatvine/heavy, T))
		return FALSE

	for(var/obj/structure/meatvine/papameat/PM in range(3, T))
		return FALSE

	if(locate(/obj/structure/meatvine/lair, T))
		return FALSE

	return TRUE

/obj/effect/meatvine_controller/proc/validate_wall_segment(datum/wall_segment/segment)
	if(!length(segment.planned_walls))
		return FALSE

	var/list/protected_structures = list()
	for(var/obj/structure/meatvine/papameat/PM in papameats)
		if(PM.master == src)
			protected_structures += PM

	for(var/obj/structure/meatvine/lair/L in vines)
		if(L.master == src)
			protected_structures += L

	if(!length(protected_structures))
		return TRUE

	for(var/obj/structure/meatvine/protected in protected_structures)
		if(would_enclose_structure(protected, segment.planned_walls))
			return FALSE

	return TRUE

/obj/effect/meatvine_controller/proc/would_enclose_structure(obj/structure/meatvine/structure, list/new_walls)
	var/turf/center = get_turf(structure)
	if(!center)
		return FALSE

	var/check_range = istype(structure, /obj/structure/meatvine/papameat) ? 3 : 2

	var/escape_routes = 0
	var/list/checked_dirs = list()

	for(var/direction in GLOB.cardinals)
		if(has_path_out(center, direction, new_walls, check_range))
			escape_routes++
			checked_dirs += direction

			if(escape_routes >= 2)
				return FALSE

	return escape_routes < 2

/obj/effect/meatvine_controller/proc/has_path_out(turf/start, initial_direction, list/planned_walls, max_distance = 3)
	var/turf/current = start

	for(var/i = 1 to max_distance)
		current = get_step(current, initial_direction)
		if(!current || !isfloorturf(current))
			return FALSE

		if(current in planned_walls)
			return FALSE

		if(locate(/obj/structure/meatvine/heavy, current))
			return FALSE

	return TRUE

/obj/effect/meatvine_controller/proc/update_wall_segments()
	for(var/datum/wall_segment/segment in wall_segments)
		if(!length(segment.planned_walls))
			wall_segments -= segment
			qdel(segment)
			continue

		if(length(segment.planned_walls) % 3 == 0)
			if(!validate_wall_segment(segment))
				wall_segments -= segment
				qdel(segment)
				continue

		for(var/i = 1 to segment.growth_rate)
			if(!length(segment.planned_walls))
				break

			var/turf/T = segment.planned_walls[1]
			segment.planned_walls -= T

			var/obj/structure/meatvine/floor/existing = locate() in T
			if(existing && !istype(existing, /obj/structure/meatvine/heavy))
				vines -= existing
				growth_queue -= existing
				qdel(existing)

			if(can_place_wall_at(T))
				spawn_spacevine_piece(T, /obj/structure/meatvine/heavy)

/obj/effect/meatvine_controller/proc/get_step_multiz(turf/start, direction, distance)
	var/turf/current = start
	for(var/i = 1 to abs(distance))
		if(distance > 0)
			current = get_step(current, direction)
		else
			current = get_step(current, turn(direction, 180))
		if(!current)
			return null
	return current

/datum/wall_segment
	var/pattern_type = "generic"
	var/list/planned_walls = list()
	var/growth_rate = 1

/datum/bridge_request
	var/turf/blocked_location
	var/turf/target_location
	var/timestamp
