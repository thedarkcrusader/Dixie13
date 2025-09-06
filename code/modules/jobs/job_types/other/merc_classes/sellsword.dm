/datum/advclass/mercenary/sellsword
	name = "Sellsword"
	tutorial = "A hardened fighter for hire, you have wandered from place to place, selling your sword to the highest bidder. Your skills are many, but your loyalties lie only with coin."
	allowed_races = RACES_PLAYER_ALL
	outfit = /datum/outfit/job/mercenary/sellsword
	category_tags = list(CTAG_MERCENARY)
	maximum_possible_slots = 5

	cmode_music = 'sound/music/cmode/adventurer/CombatWarrior.ogg'

/datum/outfit/job/mercenary/sellsword
	head = /obj/item/clothing/head/helmet/heavy/ironplate
	armor = /obj/item/clothing/armor/cuirass/iron
	neck = /obj/item/clothing/neck/gorget
	wrists = /obj/item/clothing/wrists/bracers/leather
	shirt = /obj/item/clothing/armor/gambeson/light
	gloves = /obj/item/clothing/gloves/chain/iron
	pants = /obj/item/clothing/pants/chainlegs/iron
	shoes = /obj/item/clothing/shoes/boots/leather
	belt = /obj/item/storage/belt/leather/mercenary
	beltl = /obj/item/weapon/knife/dagger
	backr = /obj/item/weapon/shield/tower/buckleriron
	backl = /obj/item/storage/backpack/satchel
	scabbards = list(/obj/item/weapon/scabbard/knife)
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor)


// Just a better adventurer warrior
/datum/outfit/job/mercenary/sellsword/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)

		H.adjust_blindness(-3)
		var/weapons = list("Spear", "Sword", "Axe", "Mace", "Flail")
		var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
		H.set_blindness(0)
		switch(weapon_choice)
			if("Spear")
				backr = /obj/item/weapon/polearm/spear
				beltr = /obj/item/weapon/shield/tower/buckleriron
				H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
			if("Sword")
				beltr = /obj/item/weapon/sword/iron
				H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			if("Axe")
				beltr = /obj/item/weapon/axe/iron
				H.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
			if("Mace")
				beltr = /obj/item/weapon/mace
				H.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
			if("Flail")
				beltr = /obj/item/weapon/flail
				H.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)

		H.merctype = 9

		H.change_stat(STATKEY_STR, 2)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_INT, -1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
