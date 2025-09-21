/datum/job/guardsman
	title = "City Watchmen"
	tutorial = "You are a member of the City Watch. Originally an untrained peasant; \
	You've proven yourself worthy to the Captain and now you've got yourself a salary... \
	as long as you keep the peace that is."
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_CITYWATCHMEN
	faction = FACTION_TOWN
	total_positions = 8
	spawn_positions = 8
	min_pq = 4
	bypass_lastclass = TRUE

	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_GUARD

	outfit = /datum/outfit/job/guardsman	//Default outfit.
	advclass_cat_rolls = list(CTAG_GARRISON = 20)	//Handles class selection.
	give_bank_account = 30
	cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'

//watchmen should NOT start with steel gear. Same with adventurers
//>but the adventurers
//you can ask the steward/king/captain/etc. for better gear, or pay for it out of your own pocket
//>but the steward/king/captain didnt pay me
//so bloody protest, complain to them, or desert until you get paid
//watchmen and adventurers shouldn't be starting with steel gear, period.
//Otherwise we end up with a fucked up arms war of one class getting steel, another getting steel, and so on
//until everyone has steel and no one has iron, and then it goes from steel to blacksteel
//and that's outright madness. There needs to be a line drawn

//................. City Watchmen Base .............. //
/datum/outfit/job/guardsman/pre_equip(mob/living/carbon/human/H)
	. = ..()
	head = pick(/obj/item/clothing/head/helmet/townwatch, /obj/item/clothing/head/helmet/townwatch/alt)
	cloak = pick(/obj/item/clothing/cloak/half/guard, /obj/item/clothing/cloak/half/guardsecond)
	shirt = /obj/item/clothing/armor/gambeson
	wrists = pick(/obj/item/rope/chain, /obj/item/rope)
	shoes = /obj/item/clothing/shoes/boots/leather/advanced/watch
	belt = /obj/item/storage/belt/leather
	gloves = /obj/item/clothing/gloves/leather
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/keyring/guard, /obj/item/weapon/knife/dagger)
	if(H.dna && !(H.dna.species.id in RACES_PLAYER_NONDISCRIMINATED)) // to prevent examine stress
		mask = /obj/item/clothing/face/shepherd/clothmask

/datum/outfit/job/guardsman/post_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.cloak)
		if(!findtext(H.cloak.name,"([H.real_name])"))
			H.cloak.name = "[H.cloak.name]"+" "+"([H.real_name])"

// EVERY TOWN GUARD SHOULD HAVE AT LEAST THREE CLUB SKILL
// REMINDER THAT backl IS OCCUPIED BY THE SATCHEL

//................. Footman .............. //
/datum/advclass/garrison/footman
	name = "City Watch Footman"
	tutorial = "You are a footman of the City Watch. \
	You are well versed in holding the line with a shield while wielding a trusty sword, axe, or mace in the other hand."
	outfit = /datum/outfit/job/guardsman/footman
	category_tags = list(CTAG_GARRISON)

/datum/outfit/job/guardsman/footman/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/armor/chainmail/iron
	pants = /obj/item/clothing/pants/chainlegs/iron
	neck = /obj/item/clothing/neck/chaincoif/iron
	backr = /obj/item/weapon/shield/heater
	beltr = /obj/item/weapon/sword/short
	beltl = /obj/item/weapon/mace/bludgeon
	scabbards = list(/obj/item/weapon/scabbard/sword)

	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE) // Main weapon
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE) // Backup, lethal option
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE) // Guards should be going for less than lethal in reality. Unarmed would be a primary thing.

	//movement and stamina
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE) // Wrestling is cardio intensive, and guards wrestle with the populace a lot.

	//misc skills
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)

	//stats
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 1)

	//traits
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)

	H.verbs |= /mob/proc/haltyell

//................. Archer .............. //
/datum/advclass/garrison/archer
	name = "City Watch Archer"
	tutorial = "You are an archer of the City Watch. \
	Your training with bows makes you a formidable threat when perched atop the walls or rooftops, \
	raining arrows down upon foes with impunity."
	outfit = /datum/outfit/job/guardsman/archer
	category_tags = list(CTAG_GARRISON)

/datum/outfit/job/guardsman/archer/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/armor/leather
	pants = /obj/item/clothing/pants/trou/leather
	neck = /obj/item/clothing/neck/coif/cloth //cloth instead of leather
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	beltr = /obj/item/ammo_holder/quiver/arrows
	beltl = /obj/item/weapon/mace/cudgel

	//combat
	H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE) // Main Weapon
	H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE) // You don't even have access to crossbows
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE) // Backup
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)

	//movement and stamina
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE) // Getting up onto vantage points is common for archers.
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	//misc skills
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)

	//stats
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_SPD, 2)

	//traits
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)

	H.verbs |= /mob/proc/haltyell

//................. Pikeman .............. //
/datum/advclass/garrison/pikeman
	name = "City Watch Pikeman"
	tutorial = "You are a pikeman in the City Watch. \
	You are faster than the rest of the garrison, \
	and specialize in spears and other polearms. \
	Ideal for striking enemies from a short distance."
	outfit = /datum/outfit/job/guardsman/pikeman

	category_tags = list(CTAG_GARRISON)

/datum/outfit/job/guardsman/pikeman/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/armor/chainmail/iron
	pants = /obj/item/clothing/pants/chainlegs/iron
	neck = /obj/item/clothing/neck/chaincoif/iron
	backr = /obj/item/weapon/polearm/spear
	beltr = /obj/item/weapon/shield/tower/buckleriron

	//combat
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE) //needed to use buckler
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)

	//movement and stamina
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE) // Polearms use a lot of stamina. They'd be enduring.

	//misc
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)

	//stats
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_SPD, 1)//gets extra speed to help keep distance but gets less end than footman

	//traits
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell

//................. Flails .............. //
/datum/advclass/garrison/flailman
	name = "City Watch Flailman"
	tutorial = "You are a flailman of the City Watch. \
	You are trained to use flails. \
	Although great against armour, they are terrible to parry with and as such, you rely on your wooden shield for defense."
	outfit = /datum/outfit/job/guardsman/flailman
	category_tags = list(CTAG_GARRISON)

/datum/outfit/job/guardsman/flailman/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/armor/chainmail/iron
	pants = /obj/item/clothing/pants/chainlegs/iron
	neck = /obj/item/clothing/neck/chaincoif/iron
	backr = /obj/item/weapon/shield/wood
	beltr = pick(/obj/item/weapon/flail/militia, /obj/item/weapon/flail)
	//both the militia and normal flail are the same stat wise

	//skills and stats are basically copied from footman but slightly changed

	//combat
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE) // Main weapon
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE) // Relies on shield for defense
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE) // Backup
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)

	//movement and stamina
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)

	//misc skills
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)

	//stats
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 1)

	//traits
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)

	H.verbs |= /mob/proc/haltyell

//................. HALT! .............. //

//Stop! You have violated the law. Pay the court a fine or serve your sentence. Your stolen goods are now forfeit.
//>Resist Arrest.
//Then pay with your blood!
/mob/proc/haltyell()
	set name = "HALT!"
	set category = "Noises"
	emote("haltyell")
