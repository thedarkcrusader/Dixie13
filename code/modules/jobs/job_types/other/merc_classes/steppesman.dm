/datum/job/advclass/mercenary/steppesman
	title = "Steppesman"
	tutorial = "A mercenary from hailing from the wild frontier steppes. There are three things you value most; saigas, freedom, and coin."
	allowed_races = list(\
		SPEC_ID_HUMEN,\
		SPEC_ID_ELF,\
		SPEC_ID_HALF_ELF,\
		SPEC_ID_AASIMAR,\
	)
	outfit = /datum/outfit/mercenary/steppesman
	category_tags = list(CTAG_MERCENARY)
	total_positions = 5

	cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'

/datum/outfit/mercenary/steppesman/pre_equip(mob/living/carbon/human/H)

	var/classes = list("The Archer", "The Swordsman")
	var/classchoice = browser_input_list(H, "Choose your archetypes", "Available archetypes", classes)
	switch(classchoice)
		if("The Swordsman")
			sword_equip(H)
		if("The Archer")
			archer_equip(H)

	shoes = /obj/item/clothing/shoes/boots/leather
	gloves = /obj/item/clothing/gloves/leather
	belt = /obj/item/storage/belt/leather/mercenary/black
	wrists = /obj/item/clothing/wrists/bracers/leather
	beltr = /obj/item/weapon/sword/sabre
	beltl= /obj/item/ammo_holder/quiver/arrows
	shirt = /obj/item/clothing/armor/gambeson/light/steppe
	pants = /obj/item/clothing/pants/tights/colored/red
	neck = /obj/item/storage/belt/pouch/coins/poor
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/short
	backr = /obj/item/storage/backpack/satchel
	scabbards = list(/obj/item/weapon/scabbard/sword)
	backpack_contents = list(/obj/item/weapon/knife/hunting = 1, /obj/item/tent_kit = 1)
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

/datum/outfit/mercenary/steppesman/proc/archer_equip(mob/living/carbon/human/H) // light armor cavalry archer
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
	head = /obj/item/clothing/head/papakha
	cloak = /obj/item/clothing/cloak/raincloak/furcloak
	mask = /obj/item/clothing/face/facemask/steel/steppebeast
	armor = /obj/item/clothing/armor/leather/hide/steppe
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_SPD, 2)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DUALWIELDER, TRAIT_GENERIC)
	new /mob/living/simple_animal/hostile/retaliate/saiga/tame/saddled(get_turf(H))

/datum/outfit/mercenary/steppesman/proc/sword_equip(mob/living/carbon/human/H) // medium armor cavalry swordsman
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	armor = /obj/item/clothing/armor/medium/scale/steppe
	head = /obj/item/clothing/head/helmet/bascinet/steppe
	mask = /obj/item/clothing/face/facemask/steel/steppe
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_END, 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DUALWIELDER, TRAIT_GENERIC)
	new /mob/living/simple_animal/hostile/retaliate/saiga/tame/saddled(get_turf(H))

