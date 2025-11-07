GLOBAL_LIST_INIT(job_pack_singletons, init_jobpacks())

/proc/init_jobpacks()
	var/list/list = list()
	for(var/datum/job_pack/pack as anything in typesof(/datum/job_pack))
		if(is_abstract(pack))
			continue
		list |= pack
		list[pack] = new pack()
	return list

/datum/job_pack
	abstract_type = /datum/job_pack
	/// Name used as a title in the modal
	var/name = "Generic"
	/// Associtive list of statkey to stat value
	var/list/pack_stats = list()
	/// Associtive list of skill to skill value
	var/list/pack_skills = list()
	/// List of spells
	var/list/pack_spells = list()
	/// Associtive list of item to slot
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

/datum/job_pack/creed
	name = "Covenant And Creed (Broadsword + Shield)"
	pack_skills = list(
		/datum/skill/combat/swords = SKILL_LEVEL_MASTER,
		/datum/skill/combat/shields = SKILL_LEVEL_EXPERT,
	)

	pack_contents = list(
		/obj/item/weapon/sword/long/greatsword/broadsword/psy/relic = ITEM_SLOT_HANDS,
		/obj/item/paper/inqslip/arrival/inq = ITEM_SLOT_HANDS,
		/obj/item/weapon/shield/tower/metal/psy = ITEM_SLOT_BACK_R,
		/obj/item/storage/keyring/inquisitor = ITEM_SLOT_BACK_L,
	)

/datum/job_pack/creed/pick_pack(mob/living/carbon/human/H)
	var/annoyingbag = H.get_item_by_slot(ITEM_SLOT_BACK_L)
	qdel(annoyingbag)
	. = ..()

/datum/job_pack/consecratia
	name = "Covenant and Consecratia (Flail + Shield)"
	pack_skills = list(
		/datum/skill/combat/whipsflails = SKILL_LEVEL_MASTER,
		/datum/skill/combat/shields = SKILL_LEVEL_EXPERT,
	)

	pack_contents = list(
		/obj/item/weapon/flail/psydon/relic = ITEM_SLOT_HANDS,
		/obj/item/weapon/shield/tower/metal/psy = ITEM_SLOT_BACK_R,
	)

/datum/job_pack/crusade
	name = "Crusade (Greatsword) and a Silver Dagger"
	pack_skills = list(
		/datum/skill/combat/swords = SKILL_LEVEL_MASTER,
		/datum/skill/combat/knives = SKILL_LEVEL_EXPERT,
	)

	pack_contents = list(
		/obj/item/weapon/sword/long/greatsword/psydon/relic = ITEM_SLOT_HANDS,
		/obj/item/weapon/knife/dagger/silver/psydon = ITEM_SLOT_HANDS,
		/obj/item/weapon/scabbard/knife = ITEM_SLOT_BACK_L,
	)
