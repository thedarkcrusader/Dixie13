/datum/advclass/wretch/disgraced //Deserted
	name = "Disgraced Knight"
	tutorial = "You were once a venerated and revered knight - now, a scum who abandoned your liege, \
	atleast according to the rumors. You live the life of an outlaw and hermit. \
	In your journey here to Vanderlin your gear has suffered, and had to be replaced, often with worse alternatives. \
	Your skills however, like your sword, remain sharp."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_NONDISCRIMINATED //Royal Knight
	outfit = /datum/outfit/job/wretch/disgraced
	category_tags = list(CTAG_WRETCH)
	maximum_possible_slots = 1
	pickprob = 20

/datum/outfit/job/wretch/disgraced/pre_equip(mob/living/carbon/human/H)
	//gear is meant to be a mismatch, some steel, some iron
	neck = /obj/item/clothing/neck/bevor
	pants = /obj/item/clothing/pants/platelegs/iron
	cloak = /obj/item/clothing/cloak/tabard/knight
	shirt = /obj/item/clothing/armor/gambeson/arming
	belt = /obj/item/storage/belt/leather
	armor = /obj/item/clothing/armor/plate/iron
	wrists = /obj/item/clothing/wrists/bracers
	gloves = /obj/item/clothing/gloves/plate/rust
	shoes = /obj/item/clothing/shoes/boots/armor/light/rust
	backl = /obj/item/storage/backpack/satchel
	beltr = /obj/item/weapon/sword/arming
	scabbards = list(/obj/item/weapon/scabbard/sword/noble)
	backpack_contents = list(
		/obj/item/weapon/knife/hunting = 1,
		/obj/item/storage/belt/pouch/coins/poor = 1,
		/obj/item/reagent_containers/glass/bottle/healthpot = 1,
	)

	//combat
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)

	//athletics and movement
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)

	//misc
	//they are given cooking and crafting since we can assume they had to do these to survive after deserting
	H.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)

	//stats
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_SPD, -1)

	//traits
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_RECOGNIZED, TRAIT_GENERIC)

	H.add_spell(/datum/action/cooldown/spell/undirected/list_target/convert_role/brotherhood)
	to_chat(H, span_info("You have an ability with which you can recruit brothers/sisters into your Brotherhood. Servants/Squires essentialy."))

	if(H.dna?.species?.id == SPEC_ID_HUMEN)
		H.dna.species.soundpack_m = new /datum/voicepack/male/knight()

/datum/outfit/job/wretch/disgraced/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Sir"
	if(H.gender == FEMALE)
		honorary = "Dame"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"

	var/static/list/selectableweapon = list( \
		"Flail" = /obj/item/weapon/flail/sflail, \
		"Halberd" = /obj/item/weapon/polearm/halberd, \
		"Longsword" = /obj/item/weapon/sword/long, \
		"Sabre" = /obj/item/weapon/sword/sabre/dec, \
		"Unarmed" = /obj/item/weapon/knife/dagger/steel, \
		"Great Axe" = /obj/item/weapon/greataxe/steel, \
		"Mace" = /obj/item/weapon/mace/goden/steel, \
		)
	var/weaponchoice = H.select_equippable(H, selectableweapon, message = "Choose Your Specialisation", title = "DISGRACED KNIGHT")
	if(!weaponchoice)
		return
	var/grant_shield = TRUE
	switch(weaponchoice)
		if("Halberd")
			grant_shield = FALSE
			H.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		if("Longsword")
			grant_shield = FALSE
			H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Unarmed")
			grant_shield = FALSE
			H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		if("Great Axe")
			grant_shield = FALSE
			H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		if("Mace")
			grant_shield = FALSE
			H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		if("Sabre")
			H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Flail")
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
	if(grant_shield)
		var/shield = new /obj/item/weapon/shield/tower/metal()
		H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
		if(!H.equip_to_appropriate_slot(shield))
			qdel(shield)
	var/static/list/selectablehelmets = list(
		"Hounskull"	= /obj/item/clothing/head/helmet/visored/hounskull,
		"Bastion Helmet" = /obj/item/clothing/head/helmet/heavy/necked,
		"Royal Knight Helmet" = /obj/item/clothing/head/helmet/visored/royalknight,
		"Knight Helmet"	= /obj/item/clothing/head/helmet/visored/knight,
		"Decoared Knight Helmet" = /obj/item/clothing/head/helmet/heavy/decorated/knight,
		"Visored Sallet" = /obj/item/clothing/head/helmet/visored/sallet,
		"Spangenhelm" = /obj/item/clothing/head/helmet/heavy/viking,
		"Decored Golden Helmet" = /obj/item/clothing/head/helmet/heavy/decorated/golden,
		"None (+1 CON)" = /obj/item/clothing/head/roguehood/colored/random,
	)
	var/helmetchoice = H.select_equippable(H, selectablehelmets, message = "Choose Your Helmet", title = "DISGRACED KNIGHT")
	if(!helmetchoice)
		return
	switch(helmetchoice)
		if("None")
			H.change_stat(STATKEY_CON, 1)
	wretch_select_bounty(H)
