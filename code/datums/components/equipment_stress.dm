/// Apply a stress type to a user upon equipping the item. This assumes the stress type will not be stacking.
/datum/component/equipment_stress
	/// a /datum/stress_event
	var/stress_type
	/// an associative list of traits that receive an alternative stress type.
	/// If this could overlap, place them in priority order (best/worst first).
	/// If no traits are found, uses the default stress type.
	/// Assign null event associations to make negation cases.
	var/list/alist/alt_stress
	/// Optional override for specific flags e.g. shirt but not armor. Leave null to use item defaults.
	var/slot_flags_override
	/// Additional slot flags. You'd mostly likely use this for ITEM_SLOT_HANDS if this is for weird clothing stuff.
	var/additional_slot_flags

/datum/component/equipment_stress/Initialize(stress_type, alt_stress, slot_flags_override, additional_slot_flags, ...)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	src.stress_type = stress_type
	src.alt_stress = alt_stress
	src.slot_flags_override = slot_flags_override
	src.additional_slot_flags = additional_slot_flags

/datum/component/equipment_stress/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(user_equipped))
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(user_dropped))

/datum/component/equipment_stress/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))

/datum/component/equipment_stress/proc/user_equipped(obj/item/source,mob/user, slot)
	SIGNAL_HANDLER
	if(!user)
		return

	if(is_valid_slot(slot))
		apply_stress(user)

/datum/component/equipment_stress/proc/user_dropped(obj/item/source, mob/user)
	SIGNAL_HANDLER
	if(!user)
		return
	if(is_valid_slot(user.get_slot_by_item(parent)))
		clear_stress(user, FALSE)

/datum/component/equipment_stress/proc/apply_stress(mob/user)
	for(var/trait in alt_stress)
		if(HAS_TRAIT(user, trait))
			if(ispath(alt_stress[trait], /datum/stress_event))
				user.add_stress(alt_stress[trait])
			return
	user.add_stress(stress_type)

/datum/component/equipment_stress/proc/clear_stress(mob/user)
	// traits can potentially fluctuate so let's do a flush of these. better than getting stuck with it.
	for(var/trait in alt_stress)
		user.remove_stress(alt_stress[trait])
	user.remove_stress(stress_type)


/datum/component/equipment_stress/proc/is_valid_slot(slot)
	var/obj/item/I = parent
	return slot & ((slot_flags_override || I.slot_flags) | additional_slot_flags)


/// job specific variety for equipment stress
/datum/component/equipment_stress/job_specific
	/// these jobs will not gain the stress event
	var/list/immune_jobs
	/// These department flags will not be affected. Defaults NONE
	var/immune_departments
	/// Jobs to make exception to within department flags
	var/list/department_exceptions
	/// Invert the behaviors so only the immune jobs/departments are affected instead. Defaults FALSE
	var/inverse

/datum/component/equipment_stress/job_specific/Initialize(stress_type, alt_stress, slot_flags_override, additional_slot_flags, immune_jobs, immune_departments, department_exceptions, inverse)
	. = ..()
	if(. == COMPONENT_INCOMPATIBLE)
		return
	src.immune_jobs = immune_jobs
	src.immune_departments = immune_departments
	src.department_exceptions = department_exceptions
	src.inverse = inverse

/datum/component/equipment_stress/job_specific/apply_stress(mob/user)
	var/datum/job/J = SSjob.GetJob(user.job)
	if(istype(J))
		// This is extremely fucked up and weird.
		// When you invert this it'll return true for any immune job or non-exceptioned department job.
		// This or statement has to be done in this order because it lets you do some weird but neat stuff without shorthand.
			// An example of this is targeting the OUTSIDER department, but making exception to pilgrim adv classes.
			// This evaluates the first part to false, so it checks the second half.
			// Now we can shove something like /datum/job/advclass/pilgrim/noble in the immune_jobs, which evaluates to TRUE, so TRUE ^ TRUE == FALSE
		if(inverse ^ ((J.department_flag & immune_departments && !is_type_in_list(J, department_exceptions)) || is_type_in_list(J, immune_jobs)))
			return
	else if(inverse) //jobless try to conform to the general rule
		return
	return ..()

