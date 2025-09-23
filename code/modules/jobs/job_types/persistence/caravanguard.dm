/datum/job/caravanguard_p
	title = "Caravan Guard"
	tutorial = "Placeholder description"
	department_flag = PEASANTS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 8
	spawn_positions = 8
	allowed_races = list(ALL_RACES_LIST)
	outfit = /datum/outfit/job/caravanguard_p
	cmode_music = 'sound/music/cmode/towner/CombatTowner.ogg'

/datum/outfit/job/caravanguard_p/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(50))
		cmode_music = 'sound/music/cmode/towner/CombatTowner2.ogg'
	//general skills
	H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)

	//job specific skills
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)

	//stats
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_END, 1)

	//traits
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

	//gear
	head = /obj/item/clothing/head/helmet/ironpot
	armor = /obj/item/clothing/armor/cuirass/iron
	shirt = pick(/obj/item/clothing/armor/gambeson/heavy, /obj/item/clothing/armor/gambeson, /obj/item/clothing/armor/gambeson/light)
	pants = pick(/obj/item/clothing/pants/trou, /obj/item/clothing/pants/tights/colored/random)
	shoes = /obj/item/clothing/shoes/boots/leather

	neck = /obj/item/storage/belt/pouch/coins/poor
	wrists = /obj/item/clothing/wrists/bracers/leather
	belt = pick(/obj/item/storage/belt/leather, /obj/item/storage/belt/leather/rope)
