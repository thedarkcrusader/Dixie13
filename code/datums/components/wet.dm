/datum/component/wet
	var/water_stacks = 0 // 0 = Dry
	var/max_water_stacks = -20 // Fully wet
	var/dirty_water = FALSE
	var/washed = FALSE

/datum/component/wet/Initialize(stacks = 0)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	water_stacks = CLAMP(stacks, max_water_stacks, 0)

	RegisterSignal(parent, COMSIG_ATOM_WATER_USE, PROC_REF(try_use_water_stacks))
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(register_usage))
	RegisterSignal(parent, COMSIG_ATOM_WATER_INCREASE, PROC_REF(try_increase_water_stacks))
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))

/datum/component/wet/proc/on_examine(datum/source, mob/user, list/examine_list)
	if(water_stacks < 0)
		examine_list += span_warning("It's wet.")
		if(dirty_water)
			examine_list += span_warning("And smells very bad...")

/// Using water (drying)
/datum/component/wet/proc/try_use_water_stacks(atom/source, stacks)
	// Stacks is how much water to remove (positive)
	if(water_stacks == 0)
		if(washed)
			washed = FALSE
		return FALSE // Already fully dry

	water_stacks = min(0, water_stacks + stacks)
	return TRUE

/// Adding water (getting wetter)
/datum/component/wet/proc/try_increase_water_stacks(atom/source, stacks, dirty = FALSE, wash = FALSE)
	// If it is dirty, this can only be removed by drying properly on the structure.
	if(dirty)
		dirty_water = TRUE
	// If it it washed in a clean water/bin.
	if(wash)
		washed = TRUE
	// Stacks is how much wetness to add (positive)
	if(water_stacks <= max_water_stacks)
		return FALSE // Already fully soaked

	water_stacks = max(max_water_stacks, water_stacks - stacks)
	return TRUE

/datum/component/wet/proc/try_proxy_use_water(mob/proxy, atom/source, stacks, check_only = FALSE)
	if(water_stacks == 0)
		return FALSE // Dry

	if(check_only)
		return TRUE

	water_stacks = min(0, water_stacks + stacks)
	return TRUE

/datum/component/wet/proc/register_usage(atom/source, mob/living/equipped)
	RegisterSignal(equipped, COMSIG_ATOM_PROXY_WATER_USE, PROC_REF(try_proxy_use_water), override = TRUE)
	RegisterSignal(parent,COMSIG_ITEM_DROPPED, PROC_REF(unregister_usage), override = TRUE)

/datum/component/wet/proc/unregister_usage(atom/source, mob/living/dropper)
	UnregisterSignal(parent, COMSIG_ITEM_DROPPED)
	UnregisterSignal(dropper, COMSIG_ATOM_PROXY_WATER_USE)
