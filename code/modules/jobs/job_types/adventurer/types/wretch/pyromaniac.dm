/datum/advclass/wretch/pyromaniac
	name = "Pyromaniac"
	tutorial = "A notorious arsonist with a penchant for fire, \
	you wield your own personal vendetta against the chaotic forces within Faience. \
	Bring mayhem and destruction with flame and misfortune!"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL
	outfit = /datum/outfit/job/wretch/pyromaniac
	category_tags = list(CTAG_WRETCH)
	maximum_possible_slots = 2

/datum/outfit/job/wretch/pyromaniac/pre_equip(mob/living/carbon/human/H)
	head = /obj/item/clothing/head/roguehood/colored/red
	mask = /obj/item/clothing/face/facemask
	neck = /obj/item/clothing/neck/chaincoif/iron
	pants = /obj/item/clothing/pants/trou/leather
	armor = /obj/item/clothing/armor/leather/splint
	shirt = /obj/item/clothing/armor/chainmail/iron
	cloak = /obj/item/clothing/cloak/half/colored/red
	backl = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather/black
	beltr = /obj/item/storage/belt/pouch/coins/poor
	gloves = /obj/item/clothing/gloves/fingerless
	wrists = pick(/obj/item/rope/chain, /obj/item/rope)
	shoes = /obj/item/clothing/shoes/boots
	backpack_contents = list(
		/obj/item/explosive/bottle = 4,
		/obj/item/flint = 1,
		/obj/item/reagent_containers/glass/bottle/healthpot = 1,
		/obj/item/weapon/knife/hunting = 1,
	)
	//combat
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)

	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/engineering, 3, TRUE) //...Apparently to craft pyro ammos?
	H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/bombs, 2, TRUE) //To craft bombs.
	H.change_stat(STATKEY_END, 3)
	H.change_stat(STATKEY_CON, 3)
	H.change_stat(STATKEY_INT, 3)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)

/datum/outfit/job/wretch/pyromaniac/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	var/static/list/selectableweapon = list(
		"Bow" = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/short,
		"Crossbow" = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow,
	)
	var/weaponschoice = H.select_equippable(H, selectableweapon, message = "Choose Your Weapon of choice", title = "PYROMANIAC")
	if(!weaponschoice)
		return
	switch(weaponschoice)
		if("Bow")
			var/obj/item/ammo_holder/quiver/arrows/pyro/P = new(get_turf(src))
			H.equip_to_appropriate_slot(P)
			H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		if("Crossbow")
			var/obj/item/ammo_holder/quiver/bolts/pyro/P = new(get_turf(src))
			H.equip_to_appropriate_slot(P)
			H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	to_chat(H, span_info("You are able to make more ammunitions for your weapon of choice with iron, blast powder and some planks."))
	wretch_select_bounty(H)
