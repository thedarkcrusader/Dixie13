/datum/job/advclass/sellsword //Polearm strength class, starts with billhook or godendag with medium armor training
	title = "Sellsword"
	tutorial = "Perhaps a mercenary, perhaps a deserter - at one time, you killed for a master in return for gold. Now you live with no such master over your head - and take what you please."
	allowed_sexes = list(MALE, FEMALE)

	outfit = /datum/outfit/bandit/sellsword
	category_tags = list(CTAG_BANDIT)
	cmode_music = 'sound/music/cmode/antag/combat_bandit2.ogg'

/datum/outfit/bandit/sellsword/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
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
	shirt = /obj/item/clothing/armor/gambeson/heavy
	wrists = /obj/item/clothing/wrists/bracers/ironjackchain
	shoes = /obj/item/clothing/shoes/boots/armor/ironmaille
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/needle/thorn = 1, /obj/item/natural/cloth = 1)
	mask = /obj/item/clothing/face/facemask/steel
	neck = /obj/item/clothing/neck/chaincoif
	armor = /obj/item/clothing/armor/brigandine/light
	head = /obj/item/clothing/head/helmet/nasal
	gloves = /obj/item/clothing/gloves/leather
	beltl = /obj/item/weapon/sword
	scabbards = list(/obj/item/weapon/scabbard/sword)
	H.change_stat(STATKEY_STR, 2) //less buffs than brigand but no int debuff
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_SPD, 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.adjust_blindness(-3)
	var/weapons = list("Billhook","Godendag")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Billhook") //More lethal of the two, basic pikeman
			backl= /obj/item/weapon/polearm/spear/billhook
			H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		if("Godendag") //More anti armor/non lethal of the two, still very capable of being a lineman
			backl= /obj/item/weapon/mace/goden
			H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
