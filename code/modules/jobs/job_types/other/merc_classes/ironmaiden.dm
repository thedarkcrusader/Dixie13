/datum/advclass/mercenary/ironmaiden
	name = "Iron Maiden"
	tutorial = "You're a battlefield medic and have forsaken the blade for the scalpel. \
	Your vile apperance has been hidden under layers of iron, allowing you to ply your trade to all those who have the coin."
	allowed_races = list(SPEC_ID_MEDICATOR)
	outfit = /datum/outfit/job/mercenary/ironmaiden
	category_tags = list(CTAG_MERCENARY)
	maximum_possible_slots = 5

	cmode_music = 'sound/music/cmode/nobility/combat_physician.ogg'

/datum/outfit/job/mercenary/ironmaiden
	head = /obj/item/clothing/head/helmet/sallet
	mask = /obj/item/clothing/face/facemask
	armor = /obj/item/clothing/armor/plate/full/iron
	shirt = /obj/item/clothing/armor/chainmail/iron
	gloves = /obj/item/clothing/gloves/plate/iron
	belt = /obj/item/storage/belt/leather/mercenary
	backl = /obj/item/storage/backpack/satchel/surgbag
	backr = /obj/item/storage/backpack/satchel
	beltr = /obj/item/weapon/knife/dagger/steel
	beltl = /obj/item/weapon/knife/cleaver
	pants = /obj/item/clothing/pants/platelegs/iron
	shoes = /obj/item/clothing/shoes/boots/armor
	backpack_contents = list(
		/obj/item/storage/belt/pouch/coins/poor
	)

/datum/outfit/job/mercenary/ironmaiden/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)

	H.merctype = 9

	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_INT, 2)

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
