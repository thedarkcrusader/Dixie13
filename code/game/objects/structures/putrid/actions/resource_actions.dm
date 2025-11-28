/datum/action/cooldown/meatvine
	name = "Putrid Ability"
	desc = "Spread the putrid"
	button_icon = 'icons/obj/cellular/putrid_abilities.dmi'
	background_icon = 'icons/obj/cellular/putrid_abilities.dmi'
	base_background_icon_state = "button_bg"
	active_background_icon_state = "button_bg1"
	button_icon_state = "spread"
	panel = "Putrid"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_PHASED
	click_to_activate = TRUE
	unset_after_click = TRUE
	cooldown_time = 3 SECONDS

	var/resource_cost = 10
	var/spread_type = /obj/structure/meatvine/floor
	var/spread_range = 7

/datum/action/cooldown/meatvine/IsAvailable()
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/simple_animal/hostile/retaliate/meatvine/consumed = owner
	if(!istype(consumed))
		return FALSE

	if(!consumed.master)
		return FALSE

	if(consumed.master.consumed_resource_pool < resource_cost)
		return FALSE

	return TRUE

/datum/action/cooldown/meatvine/Activate(atom/target)
	var/mob/living/simple_animal/hostile/retaliate/meatvine/consumed = owner
	if(!istype(consumed) || !consumed.master)
		return FALSE

	var/turf/T = get_turf(target)
	if(!T)
		return FALSE

	// Check range
	if(get_dist(owner, T) > spread_range)
		to_chat(owner, "<span class='warning'>Too far away!</span>")
		return FALSE

	// Check if valid turf
	if(!can_spread_to_turf(T))
		to_chat(owner, "<span class='warning'>Cannot spread there!</span>")
		return FALSE

	// Try to spend resources
	if(!consumed.master.try_spend_resources(resource_cost))
		to_chat(owner, "<span class='warning'>Not enough resources! ([consumed.master.consumed_resource_pool]/[resource_cost])</span>")
		return FALSE

	// Spawn the meatvine piece
	do_spread(T, consumed.master)

	to_chat(owner, "<span class='notice'>Spread complete. Resources: [consumed.master.consumed_resource_pool]/[consumed.master.consumed_resource_max]</span>")

	return ..()

/datum/action/cooldown/meatvine/proc/can_spread_to_turf(turf/T)
	if(!isfloorturf(T))
		return FALSE
	if(T.is_blocked_turf())
		return FALSE
	if(locate(/obj/structure/meatvine) in T)
		return FALSE
	return TRUE

/datum/action/cooldown/meatvine/proc/do_spread(turf/T, obj/effect/meatvine_controller/controller)
	controller.spawn_spacevine_piece(T, spread_type)

/datum/action/cooldown/meatvine/spread_floor
	name = "Spread Floor"
	desc = "Spread meatvine floor to target location. Cost: 10 resources."
	button_icon_state = "spread"
	resource_cost = 10
	spread_type = /obj/structure/meatvine/floor

/datum/action/cooldown/meatvine/spread_wall
	name = "Spread Wall"
	desc = "Spread meatvine wall to target location. Cost: 25 resources."
	button_icon_state = "wall"
	resource_cost = 25
	spread_type = /obj/structure/meatvine/heavy
	spread_range = 5

/datum/action/cooldown/meatvine/spread_wall/can_spread_to_turf(turf/T)
	if(!..())
		return FALSE

	// Walls need to be built on adjacent or ontop of existing
	var/has_adjacent = FALSE
	for(var/direction in GLOB.cardinals)
		var/turf/check = get_step(T, direction)
		if(locate(/obj/structure/meatvine) in check)
			has_adjacent = TRUE
			break
	if(locate(/obj/structure/meatvine) in T)
		has_adjacent = TRUE

	return has_adjacent

/datum/action/cooldown/meatvine/spread_lair
	name = "Spread Lair"
	desc = "Spread meatvine lair to target location. Spawns hostile creatures. Cost: 200 resources."
	button_icon_state = "lair"
	resource_cost = 200
	spread_type = /obj/structure/meatvine/lair
	spread_range = 5
	cooldown_time = 4 MINUTES

/datum/action/cooldown/meatvine/spread_lair/IsAvailable()
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/simple_animal/hostile/retaliate/meatvine/consumed = owner
	if(!consumed.master)
		return FALSE

	// Check if we can spawn more lairs
	if(!consumed.master.can_spawn_lair())
		return FALSE

	return TRUE

/datum/action/cooldown/meatvine/spread_lair/can_spread_to_turf(turf/T)
	if(!..())
		return FALSE

	var/mob/living/simple_animal/hostile/retaliate/meatvine/consumed = owner
	if(!consumed.master)
		return FALSE

	// Use controller's lair placement checks
	return consumed.master.can_spawn_lair_at(T)

/datum/action/cooldown/meatvine/spread_spike
	name = "Build Tentacle Spike"
	desc = "Build a tentacle spike on meatvine floor. Can stack up to 5 spikes on one tile. Cost: 50 resources."
	button_icon_state = "tentacle_spikes"
	resource_cost = 50
	spread_type = /obj/structure/meatvine/tentacle_spike
	spread_range = 5
	cooldown_time = 30 SECONDS

/datum/action/cooldown/meatvine/spread_spike/can_spread_to_turf(turf/T)
	if(!isfloorturf(T))
		return FALSE

	// Must have a meatvine floor
	var/obj/structure/meatvine/floor/floor_vine = locate(/obj/structure/meatvine/floor) in T
	if(!floor_vine)
		return FALSE

	// Check if there's already a spike here
	var/obj/structure/meatvine/tentacle_spike/existing_spike = locate(/obj/structure/meatvine/tentacle_spike) in T
	if(existing_spike)
		// If spike exists, check if we can add to it
		if(!existing_spike.can_add_spike())
			return FALSE

	return TRUE

/datum/action/cooldown/meatvine/spread_spike/do_spread(turf/T, obj/effect/meatvine_controller/controller)
	// Check if there's already a spike
	var/obj/structure/meatvine/tentacle_spike/existing_spike = locate(/obj/structure/meatvine/tentacle_spike) in T

	if(existing_spike)
		// Add to existing spike
		if(existing_spike.add_spike())
			to_chat(owner, "<span class='notice'>Added spike to existing cluster. ([existing_spike.spike_count]/[existing_spike.max_spikes])</span>")
			return
		else
			to_chat(owner, "<span class='warning'>Maximum spikes reached!</span>")
			return

	// Create new spike
	var/obj/structure/meatvine/tentacle_spike/new_spike = new spread_type(T)
	new_spike.master = controller
	controller.vines += new_spike
	controller.growth_queue += new_spike

/datum/action/cooldown/meatvine/spread_healing_well
	name = "Build Healing Well"
	desc = "Build a healing well on meatvine floor. Provides regenerative aura to nearby creatures. Only one per area. Cost: 200 resources."
	button_icon_state = "heal_pool" // Adjust to your icon
	resource_cost = 200
	spread_type = /obj/structure/meatvine/healing_well
	spread_range = 5
	cooldown_time = 3 MINUTES

/datum/action/cooldown/meatvine/spread_healing_well/can_spread_to_turf(turf/T)
	if(!isfloorturf(T))
		return FALSE

	// Must have a meatvine floor
	var/obj/structure/meatvine/floor/floor_vine = locate(/obj/structure/meatvine/floor) in T
	if(!floor_vine)
		return FALSE

	// Check if there's already a healing well here
	if(locate(/obj/structure/meatvine/healing_well) in T)
		return FALSE

	// Check if there's a healing well nearby (non-stacking)
	for(var/obj/structure/meatvine/healing_well/existing_well in range(7, T))
		return FALSE

	return TRUE

/datum/action/cooldown/meatvine/spread_healing_well/Activate(atom/target)
	var/turf/T = get_turf(target)
	if(!T)
		return FALSE

	// Additional check for nearby wells
	for(var/obj/structure/meatvine/healing_well/existing_well in range(7, T))
		to_chat(owner, "<span class='warning'>Too close to another healing well!</span>")
		return FALSE

	return ..()

/datum/action/cooldown/meatvine/spread_healing_well/do_spread(turf/T, obj/effect/meatvine_controller/controller)
	// Create new healing well
	var/obj/structure/meatvine/healing_well/new_well = new spread_type(T)
	new_well.master = controller
	controller.vines += new_well
	controller.growth_queue += new_well
