/datum/advclass/wretch/plaguebearer
	name = "Plaguebearer"
	tutorial = "A physicker in theory. \
	In practice, you have become somewhat infamous for your ability and wilingness to produce poisons and bombs. \
	To the point that you have been declared an outlaw... or was it a heretic? \
	You don't care, you now revel in spreading suffering, and seeing your poisons in action."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL
	outfit = /datum/outfit/job/wretch/plaguebearer
	category_tags = list(CTAG_WRETCH)
	maximum_possible_slots = 2

/datum/outfit/job/wretch/plaguebearer/pre_equip(mob/living/carbon/human/H)
	..()
	mask = /obj/item/clothing/face/phys
	head = /obj/item/clothing/head/roguehood/phys
	shoes = /obj/item/clothing/shoes/boots/leather
	shirt = /obj/item/clothing/shirt/undershirt/colored/black
	backl = /obj/item/storage/backpack/satchel/surgbag/shit
	backr = /obj/item/storage/backpack/satchel
	pants = /obj/item/clothing/pants/tights/colored/random
	gloves = /obj/item/clothing/gloves/leather/phys
	armor = /obj/item/clothing/shirt/robe/phys
	neck = /obj/item/clothing/neck/phys
	belt = /obj/item/storage/belt/leather/rope
	beltl = /obj/item/gun/ballistic/revolver/grenadelauncher/blowgun
	beltr = /obj/item/ammo_holder/dartpouch/poisondarts

	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/poison = 2,
		//they are given 2 bottles, they can pour one into the other and have a spare bottle for bombs
		/obj/item/smokebomb/poison_bomb = 2,
		/obj/item/storage/belt/pouch/coins/poor = 1,
	)

	//combat
	H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)

	//athletics and movement
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)

	//crafting
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/bombs, 1, TRUE) //to craft smoke and poison bombs

	//misc
	H.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)

	//stats
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_SPD, 1)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_CON, 1)

	//traits
	ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)

/datum/outfit/job/wretch/plaguebearer/post_equip(mob/living/carbon/human/H, visualsOnly)
	wretch_select_bounty(H)
	to_chat(H, span_info("You are able to make smoke bombs with a bottle, fyritus, and two handfuls of ash."))
	to_chat(H, span_info("You are able to make poison bombs with a smoke bomb, atropa, and paris."))


