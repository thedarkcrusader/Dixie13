/datum/job/advclass/banditlead/leadsellsword //Strength class, starts with axe or flails and medium armor training
	title = "Travelled Mercenary"
	tutorial = "You used to fight for coin, being paid to end lives by those who never had to risk their own, you were the best of the best, employers would pay for your ferry just for a chance at your services. Eventually you realized how insufferable these employers were, you brought your sellswords to join you on this new life, the one where you could simply punch the nobles you couldn't stomach."
	outfit = /datum/outfit/banditlead/leadsellsword
	category_tags = list(CTAG_BANDITLEAD)
	cmode_music = 'sound/music/cmode/antag/combat_bandit2.ogg'

/datum/outfit/banditlead/leadsellsword/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	belt = /obj/item/storage/belt/leather
	pants = /obj/item/clothing/pants/chainlegs
	shirt = /obj/item/clothing/armor/chainmail
	shoes = /obj/item/clothing/shoes/boots
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/needle/thorn = 1, /obj/item/natural/cloth = 1)
	mask = /obj/item/clothing/face/facemask/goldmask
	wrists = /obj/item/clothing/wrists/bracers/jackchain
	neck = /obj/item/clothing/neck/chaincoif
	armor = /obj/item/clothing/armor/brigandine/light
	head = /obj/item/clothing/head/hatfur
	gloves = /obj/item/clothing/gloves/leather
	cloak = /obj/item/clothing/cloak/cape/crusader
	H.change_stat(STATKEY_STR, 1) //more int statted sellsword, forced middle age/old so -1 spd with +1 end aswell
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_INT, 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.adjust_blindness(-3)
	var/weapons = list("Halberd","Warhammer and Shield")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Halberd") //Deserter watchman. Maybe should be shield and spear? spear and crossbow is kinda clumsy
			backl= /obj/item/weapon/polearm/halberd
			H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			beltl = /obj/item/weapon/sword
			scabbards = list(/obj/item/weapon/scabbard/sword)
		if("Warhammer and Shield") //Mercenary on the wrong side of the law
			beltl = /obj/item/weapon/mace/warhammer/steel
			backl = /obj/item/weapon/shield/heater
			H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
