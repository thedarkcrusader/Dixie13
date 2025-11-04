/datum/job/advclass/brigand //Strength class, starts with axe or flails and medium armor training
	title = "Brigand"
	tutorial = "Cast from society, you use your powerful physical might and endurance to take from those who are weaker from you."
	outfit = /datum/outfit/bandit/brigand
	category_tags = list(CTAG_BANDIT)
	cmode_music = 'sound/music/cmode/antag/combat_bandit_brigand.ogg'

/datum/outfit/bandit/brigand/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	belt = /obj/item/storage/belt/leather
	pants = /obj/item/clothing/pants/trou/leather/splint
	shirt = /obj/item/clothing/armor/chainmail/iron
	shoes = /obj/item/clothing/shoes/boots
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/needle/thorn = 1, /obj/item/natural/cloth = 1)
	mask = /obj/item/clothing/face/facemask/steel
	neck = /obj/item/clothing/neck/chaincoif/iron
	head = /obj/item/clothing/head/helmet/leather/volfhelm
	armor = /obj/item/clothing/armor/cuirass/iron/rust
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_INT, -3)
	H.change_stat(STATKEY_SPD, -1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.adjust_blindness(-3)
	var/weapons = list("Battleaxe & Mace","Katar")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Battleaxe & Mace") //one weapon to hurt people one weapon to kill people
			backl= /obj/item/weapon/axe/battle
			beltr = /obj/item/weapon/mace
			gloves = /obj/item/clothing/gloves/leather
			H.change_stat(STATKEY_STR, 1)
			H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		if("Katar") //Unarmed grappler, less strength so it's not as absurd hopefully, katar so they have staying power
			beltr = /obj/item/weapon/katar
			H.change_stat(STATKEY_SPD, 2)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			gloves = /obj/item/clothing/gloves/bandages/weighted //Craftable and only needing 6 cloth and level 2 sewing, reckon it's fine to give
