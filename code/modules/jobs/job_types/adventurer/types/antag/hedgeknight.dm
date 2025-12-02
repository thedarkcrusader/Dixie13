/datum/job/advclass/bandit/hedgeknight //heavy knight class - main frontliner, single slot force modifier
	title = "Hedge Knight"
	tutorial = "A noble fallen from grace, your tarnished armor sits upon your shoulders as a heavy reminder of the life you've lost. Take back what is rightfully yours."
	outfit = /datum/outfit/bandit/hedgeknight
	allowed_races = RACES_PLAYER_NONDISCRIMINATED
	total_positions = 1
	category_tags = list(CTAG_BANDIT)
	cmode_music = 'sound/music/cmode/antag/CombatBandit1.ogg'

/datum/outfit/bandit/hedgeknight/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/visored/knight/iron
	neck = /obj/item/clothing/neck/gorget
	cloak = /obj/item/clothing/cloak/stabard
	armor = /obj/item/clothing/armor/plate/iron
	shirt = /obj/item/clothing/armor/gambeson/heavy/colored/dark
	gloves = /obj/item/clothing/gloves/chain/iron
	pants = /obj/item/clothing/pants/platelegs/rust
	shoes = /obj/item/clothing/shoes/nobleboot/thighboots
	belt = /obj/item/storage/belt/leather/black
	backr = /obj/item/storage/backpack/satchel/black
	backpack_contents = list(/obj/item/weapon/knife/dagger = 1)
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_INT, 1)
	var/weapons = list("Longsword & Shield","Eagle Beak","Two-handed Flail")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Longsword & Shield") //Survivability based
			backl = /obj/item/weapon/shield/tower/metal
			beltl = /obj/item/weapon/sword/long
			scabbards = list(/obj/item/weapon/scabbard/sword/noble)
			H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
		if("Eagle Beak") //More lethal two handed option
			backl = /obj/item/weapon/polearm/eaglebeak
			H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		if("Two-handed Flail") //Nerfed strength so you aren't deleting people, get ready to facetank because you also can't block
			backl = /obj/item/weapon/flail/peasant
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
			H.change_stat(STATKEY_STR, -1)
			H.change_stat(STATKEY_CON, 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC) //hey buddy you hear about roleplaying
