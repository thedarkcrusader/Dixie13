//Essentialy a stronger mage, both in terms of mind and matter
/datum/advclass/wretch/hedgemage
	name = "Hedge Mage"
	tutorial = "They reject your genius, they cast you out, they call you unethical. \
	They do not understand the SACRIFICES you must make. \
	But it does not matter anymore, your magical prowess eclipses that of any of these fools. Show them TRUE POWER."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL
	outfit = /datum/outfit/job/wretch/hedgemage
	category_tags = list(CTAG_WRETCH)
	cmode_music = 'sound/music/cmode/adventurer/CombatSorcerer.ogg'
	maximum_possible_slots = 2

/datum/outfit/job/wretch/hedgemage
	allowed_patrons = list(/datum/patron/divine/noc, /datum/patron/inhumen/zizo)

/datum/outfit/job/wretch/hedgemage/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(1))//1% chance to have the evil wizard music
		H.cmode_music = 'sound/music/cmode/antag/combat_evilwizard.ogg'

	if(H.patron.type == /datum/patron/inhumen/zizo)
		H.grant_language(/datum/language/undead)

	H.mana_pool?.set_intrinsic_recharge(MANA_ALL_LEYLINES)

	shoes = /obj/item/clothing/shoes/simpleshoes
	belt = /obj/item/storage/belt/leather/rope
	backr = /obj/item/storage/backpack/satchel
	beltr = /obj/item/storage/magebag/poor
	beltl = /obj/item/reagent_containers/glass/bottle/manapot
	backl = /obj/item/weapon/polearm/woodstaff/quarterstaff/iron
	backpack_contents = list(
		/obj/item/book/granter/spellbook/adept = 1,
		/obj/item/chalk = 1,
		/obj/item/mana_battery/mana_crystal/small/focus = 1,
		/obj/item/storage/belt/pouch/coins/mid = 1,
		)

	//combat
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)

	//athletics and movement
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	//misc
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)

	//stats
	H.change_stat(STATKEY_INT, 4)
	H.change_stat(STATKEY_CON, -2)
	H.change_stat(STATKEY_SPD, -1)
	if(H.age == AGE_OLD)
		H.adjust_spell_points(2)
		H.change_stat(STATKEY_INT, 1)
	H.adjust_spell_points(10)

/datum/outfit/job/wretch/hedgemage/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	var/static/list/selectablehat = list(
		"Witch hat" = /obj/item/clothing/head/wizhat/witch,
		"Wizard hat" = /obj/item/clothing/head/wizhat,
		"Mage hood" = /obj/item/clothing/head/roguehood/colored/mage,
		"Black hood" = /obj/item/clothing/head/roguehood/colored/black,
	)
	H.select_equippable(H, selectablehat, message = "Choose your hat of choice", title = "HEDGEMAGE")
	var/static/list/selectablerobe = list(
		"Black robes" = /obj/item/clothing/shirt/robe/colored/black,
		"Mage robes" = /obj/item/clothing/shirt/robe/colored/mage,
	)
	H.select_equippable(H, selectablerobe, message = "Choose your robe of choice", title = "HEDGEMAGE")
	wretch_select_bounty(H)
