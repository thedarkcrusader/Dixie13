GLOBAL_LIST_INIT(job_pack_singletons, init_jobpacks())

/proc/init_jobpacks()
	var/list/list = list()
	for(var/datum/job_pack/pack as anything in typesof(/datum/job_pack))
		if(is_abstract(pack))
			continue
		list[pack] = new pack()
	return list

/datum/job_pack
	abstract_type = /datum/job_pack
	/// Name used as a title in the modal
	var/name = "Generic"
	/// Associative list of statkey to stat value
	var/list/pack_stats = list()
	/// Associative list of skill to skill value
	var/list/pack_skills = list()
	/// List of spells
	var/list/pack_spells = list()
	/// Associative list of item to slot
	var/list/pack_contents = list()

/datum/job_pack/proc/can_pick_pack(mob/living/carbon/human/H, list/previous_picked_types)
	return TRUE

/datum/job_pack/proc/pick_pack(mob/living/carbon/human/H)
	H.remove_stat_modifier(STATMOD_PACK) // Reset so no inf stat
	H.adjust_stat_modifier_list(STATMOD_PACK, pack_stats)

	for(var/datum/skill/skill as anything in pack_skills)
		var/amount_or_list = pack_skills[skill]
		if(islist(amount_or_list))
			H.clamped_adjust_skillrank(skill, amount_or_list[1], amount_or_list[2], TRUE)
		else
			H.clamped_adjust_skillrank(skill, amount_or_list, amount_or_list) //! This was changed because what the fuck.

	for(var/datum/action/cooldown/spell/spell as anything in pack_spells)
		H.add_spell(spell, source = src)

	for(var/atom/path as anything in pack_contents)
		if(pack_contents[path] == ITEM_SLOT_HANDS)
			H.put_in_hands(new path(H), TRUE)
		else
			H.equip_to_slot_or_del(new path, pack_contents[path], TRUE)

/// Job pack that allows for selections
/datum/job_pack/selection
	abstract_type = /datum/job_pack/selection
	// Shows to the mob in order, requires mind or is random
	/// Associative list of associative lists -> "Sword" = list("Falchion" = ...), "Bow" = ...
	var/list/pack_selectables = list()

/datum/job_pack/selection/pick_pack(mob/living/carbon/human/selector)
	. = ..()
	var/list/selected = list()
	for(var/group in pack_selectables)
		var/selection = pack_selectables[group]
		selected[group] = selector.select_equippable(selector, selection, message = group, title = "ARMS OF RAVOX")
		if(QDELETED(selector))
			return

	handle_selections(selector, selected)

/// Handle your selections in here.
/datum/job_pack/selection/proc/handle_selections(mob/living/carbon/human/selector, list/selected)
	return
