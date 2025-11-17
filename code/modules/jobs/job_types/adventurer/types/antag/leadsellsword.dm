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
	backpack_contents = list(
		/obj/item/needle/thorn = 1, /obj/item/natural/cloth = 1,
	)

	H.adjust_blindness(-3)


/datum/outfit/banditlead/leadsellsword/post_equip(mob/living/carbon/human/H)
	var/list/selectableweapon = list(
		"Halberd" = /obj/item/weapon/polearm/halberd, \
		"Warhammer and Shield" = /obj/item/weapon/mace/warhammer/steel, \
		)
	var/weaponchoice = H.select_equippable(H, selectableweapon, message = "Choose Your Specialisation", title = "Fighter!")
	H.set_blindness(0)
	if(!weaponchoice)
		return
	var/grant_shield = TRUE
	var/grant_sword = TRUE
	switch(weaponchoice)
		if("Halberd")
			H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			grant_shield = FALSE
		if("Warhammer and Shield")
			H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
			grant_sword = FALSE
	if(grant_shield)
		var/shield_path = pick(list(/obj/item/weapon/shield/heater))
		var/obj/item/shield = new shield_path()
		if(!H.equip_to_appropriate_slot(shield))
			qdel(shield)
	if(grant_sword)
		var/sword_path = pick(list(/obj/item/weapon/sword))
		var/obj/item/sword = new sword_path()
		if(!H.equip_to_appropriate_slot(sword))
			qdel(sword)
