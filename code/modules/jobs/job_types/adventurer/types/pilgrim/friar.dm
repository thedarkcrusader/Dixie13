/datum/job/advclass/combat/friar
	title = "Friar"
	tutorial = "Friars are wandering servants of the Gods, you have come to this land to exert their influence. (INHUMEN SPECIES CANNOT BE TENNITE)"
	allowed_races = RACES_PLAYER_ALL
	outfit = /datum/outfit/adventurer/friar
	category_tags = list(CTAG_PILGRIM)
	min_pq = 0
	total_positions = 2

/datum/outfit/adventurer/friar/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.dna && (H.dna.species.id in RACES_PLAYER_HERETICAL_RACE) && !istype(H.patron, /datum/patron/inhumen))
		var/list/inhumen = list(
			/datum/patron/inhumen/graggar,
			/datum/patron/inhumen/zizo,
			/datum/patron/inhumen/matthios,
			/datum/patron/inhumen/baotha
		)
		var/picked = pick(inhumen)
		H.set_patron(picked)
		to_chat(H, span_warning("My patron had not endorsed my practices in my younger years. I've since grown acustomed to [H.patron]."))
	H.virginity = TRUE
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/storage/belt/pouch/coins/poor
	backl = /obj/item/weapon/polearm/woodstaff/quarterstaff
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/needle)
	switch(H.patron?.type)
		if(/datum/patron/divine/astrata)
			head = /obj/item/clothing/head/roguehood/astrata
			neck = /obj/item/clothing/neck/psycross/silver/astrata
			wrists = /obj/item/clothing/wrists/wrappings
			shoes = /obj/item/clothing/shoes/sandals
			armor = /obj/item/clothing/shirt/robe/astrata
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/necra) //Necra acolytes are now gravetenders
			head = /obj/item/clothing/head/padded/deathshroud
			neck = /obj/item/clothing/neck/psycross/silver/necra
			shoes = /obj/item/clothing/shoes/boots
			pants = /obj/item/clothing/pants/trou/leather/mourning
			armor = /obj/item/clothing/shirt/robe/necra
			H.cmode_music = 'sound/music/cmode/church/CombatGravekeeper.ogg'
			ADD_TRAIT(H, TRAIT_DEADNOSE, TRAIT_GENERIC)//accustomed to death
		if(/datum/patron/divine/eora)
			mask = /obj/item/clothing/face/operavisage
			neck = /obj/item/clothing/neck/psycross/silver/eora
			shoes = /obj/item/clothing/shoes/sandals
			armor = /obj/item/clothing/shirt/robe/eora
			H.cmode_music = 'sound/music/cmode/church/CombatEora.ogg'
			ADD_TRAIT(H, TRAIT_BEAUTIFUL, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
			H.virginity = FALSE
			H.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
		if(/datum/patron/divine/noc)
			head = /obj/item/clothing/head/roguehood/nochood
			neck = /obj/item/clothing/neck/psycross/silver/noc
			wrists = /obj/item/clothing/wrists/nocwrappings
			shoes = /obj/item/clothing/shoes/sandals
			armor = /obj/item/clothing/shirt/robe/noc
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
			H.adjust_skillrank(/datum/skill/labor/mathematics, 2, TRUE)
			var/language = pickweight(list("Dwarvish" = 1, "Elvish" = 1, "Hellspeak" = 1, "Zaladin" = 1, "Orcish" = 1,))
			switch(language)
				if("Dwarvish")
					H.grant_language(/datum/language/dwarvish)
					to_chat(H,span_info("\
					I learned the tongue of the mountain dwellers.")
					)
				if("Elvish")
					H.grant_language(/datum/language/elvish)
					to_chat(H,span_info("\
					I learned the tongue of the primordial race.")
					)
				if("Hellspeak")
					H.grant_language(/datum/language/hellspeak)
					to_chat(H,span_info("\
					I learned the tongue of the hellspawn.")
					)
				if("Zaladin")
					H.grant_language(/datum/language/zalad)
					to_chat(H,span_info("\
					I learned the tongue of Zaladin.")
					)
				if("Orcish")
					H.grant_language(/datum/language/orcish)
					to_chat(H,span_info("\
					I learned the tongue of the savages in my time.")
					)
		if(/datum/patron/divine/pestra)
			head = /obj/item/clothing/head/padded/pestra
			neck = /obj/item/clothing/neck/psycross/silver/pestra
			shoes = /obj/item/clothing/shoes/sandals
			armor = /obj/item/clothing/shirt/robe/pestra
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
			H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
			backpack_contents = list(/obj/item/needle/blessed)
		if(/datum/patron/divine/dendor)
			head = /obj/item/clothing/head/padded/briarthorns
			neck = /obj/item/clothing/neck/psycross/silver/dendor
			shoes = /obj/item/clothing/shoes/sandals
			armor = /obj/item/clothing/shirt/robe/dendor
			H.cmode_music = 'sound/music/cmode/garrison/CombatForestGarrison.ogg'
			H.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
			H.adjust_skillrank(/datum/skill/labor/taming, 1, TRUE)
			ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)
		if(/datum/patron/divine/abyssor)
			head = /obj/item/clothing/head/padded/abyssor
			neck = /obj/item/clothing/neck/psycross/silver/abyssor
			shoes = /obj/item/clothing/shoes/boots
			armor = /obj/item/clothing/shirt/robe/abyssor
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
			H.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		if(/datum/patron/divine/ravox)
			head = /obj/item/clothing/head/roguehood/colored/random
			neck = /obj/item/clothing/neck/psycross/silver/ravox
			shoes = /obj/item/clothing/shoes/boots
			armor = /obj/item/clothing/shirt/robe/colored/plain
			H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'
			H.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		if(/datum/patron/divine/xylix)
			head = /obj/item/clothing/head/roguehood/colored/random
			neck = /obj/item/clothing/neck/psycross/silver/xylix
			shoes = /obj/item/clothing/shoes/boots
			armor = /obj/item/clothing/shirt/robe/colored/plain
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
			H.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/music, 3, TRUE)
		if(/datum/patron/divine/malum)
			head = /obj/item/clothing/head/roguehood/colored/random
			neck = /obj/item/clothing/neck/psycross/silver/malum
			shoes = /obj/item/clothing/shoes/boots
			armor = /obj/item/clothing/shirt/robe/colored/plain
			backpack_contents += /obj/item/weapon/hammer/iron
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
			H.adjust_skillrank(/datum/skill/craft/blacksmithing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/craft/smelting, 2, TRUE)
			H.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
			H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
			ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
		if(/datum/patron/inhumen/zizo)
			head = /obj/item/clothing/head/roguehood/colored/black
			shoes = /obj/item/clothing/shoes/boots
			armor = /obj/item/clothing/shirt/robe/colored/black
			H.cmode_music = 'sound/music/cmode/antag/combat_cult.ogg'
			ADD_TRAIT(H, TRAIT_CABAL, TRAIT_GENERIC) // find the other zizoids and make a cabal
		if(/datum/patron/inhumen/matthios)
			head = /obj/item/clothing/head/roguehood/colored/random
			shoes = /obj/item/clothing/shoes/boots
			armor = /obj/item/clothing/shirt/robe/colored/plain
			H.cmode_music = 'sound/music/cmode/antag/CombatBandit1.ogg'
			H.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
		if(/datum/patron/inhumen/baotha)
			head = /obj/item/clothing/head/roguehood/colored/random
			shoes = /obj/item/clothing/shoes/boots
			armor = /obj/item/clothing/shirt/robe/colored/plain
			H.cmode_music = 'sound/music/cmode/antag/CombatBaotha.ogg'
			H.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
			H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		if(/datum/patron/inhumen/graggar)
			head = /obj/item/clothing/head/roguehood/colored/random
			shoes = /obj/item/clothing/shoes/boots
			armor = /obj/item/clothing/shirt/robe/colored/plain
			H.cmode_music = 'sound/music/cmode/antag/combat_werewolf.ogg'
			H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		else // Failsafe
			head = /obj/item/clothing/head/roguehood/colored/random
			neck = /obj/item/clothing/neck/psycross/silver
			shoes = /obj/item/clothing/shoes/boots
			armor = /obj/item/clothing/shirt/robe/colored/plain
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'


	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE) // They get this and a wooden staff to defend themselves
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_END, 2) // For casting lots of spells, and working long hours without sleep at the church
	H.change_stat(STATKEY_PER, -1)

	var/holder = H.patron.devotion_holder
	if(holder)
		var/datum/devotion/devotion = new holder()
		devotion.make_acolyte()
		devotion.grant_to(H)
