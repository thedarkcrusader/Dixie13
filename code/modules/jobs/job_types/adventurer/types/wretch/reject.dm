/datum/advclass/wretch/reject
	name = "Rejected Royal"
	tutorial = "You were once a member of the royal family, \
	but due to your actions, you have been cast out to roam the wilds. \
	Now, you return, seeking redemption or perhaps... revenge."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ROYALTY
	maximum_possible_slots = 1
	allowed_ages = list(AGE_ADULT, AGE_CHILD)
	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'
	outfit = /datum/outfit/job/wretch/reject
	category_tags = list(CTAG_WRETCH)

/datum/outfit/job/wretch/reject/pre_equip(mob/living/carbon/human/H)
	..()
	addtimer(CALLBACK(SSfamilytree, TYPE_PROC_REF(/datum/controller/subsystem/familytree, AddRoyal), H, FAMILY_PROGENY), 5 SECONDS)
	if(GLOB.keep_doors.len > 0)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(know_keep_door_password), H), 5 SECONDS)
	ADD_TRAIT(H, TRAIT_KNOWKEEPPLANS, TRAIT_GENERIC)

	//in terms of stats and gear, they are a mix between Daring Twit and Sheltered Aristocrat

	head = /obj/item/clothing/head/roguehood/colored/random
	//we can assume they had their circlet taken away, or had to sell it
	cloak = /obj/item/clothing/cloak/raincloak
	mask = /obj/item/clothing/face/shepherd/rag
	armor = /obj/item/clothing/armor/leather
	pants = /obj/item/clothing/pants/trou/leather
	shirt = /obj/item/clothing/armor/chainmail/iron
	shoes = /obj/item/clothing/shoes/nobleboot
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/sword
	scabbards = list(/obj/item/weapon/scabbard/sword)
	beltl = /obj/item/ammo_holder/quiver/bolts
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	neck = /obj/item/storage/belt/pouch/coins/mid
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/strongpoison = 1,
		/obj/item/weapon/knife/dagger/steel/special = 1,
		/obj/item/lockpickring/mundane = 1,
	)

	//combat
	H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)

	//athletics and movement
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	//crafting
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)

	//misc
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)

	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)

	//stats
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_SPD, 1)
	H.change_stat(STATKEY_LCK, 1)

	//traits
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BEAUTIFUL, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

	wretch_select_bounty(H)
