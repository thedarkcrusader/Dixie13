/datum/job/minor_noble
	title = "Noble"
	tutorial = "The blood of a noble family runs through your veins. You are the living proof that the minor houses \
	still exist in spite of the Monarch. You have many mammons to your name, but with wealth comes \
	danger, so keep your wits and tread lightly..."
	display_order = JDO_MINOR_NOBLE
	department_flag = NOBLEMEN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 2
	spawn_positions = 2
	min_pq = 1

	allowed_races = RACES_PLAYER_NONDISCRIMINATED

	outfit = /datum/outfit/noble
	advclass_cat_rolls = list(CTAG_NOBLEMINOR = 20)
	bypass_lastclass = TRUE

	apprentice_name = "Servant"
	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'

	allowed_ages = ALL_AGES_LIST_CHILD

	spells = list(
		/datum/action/cooldown/spell/undirected/call_bird = 1,
	)

	job_bitflag = BITFLAG_ROYALTY

// Noble classes.

//................. Baseline .............. //
/datum/outfit/noble/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/nobleboot
	backl = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather
	ring = /obj/item/clothing/ring/silver
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)

//................. Trading noble, no weapons or gear .............. //
/datum/job/advclass/noble/trader
	title = "Trading noble"
	tutorial = "You are a very wealthy individual. \
	You are well versed in the art of trade, with coins you can make men kill each other and that could get you even more wealth, thankfully your business are more profitable without blood on it."
	outfit = /datum/outfit/noble/trader
	give_bank_account = 85 // more money
	noble_income = 30 // more income
	category_tags = list(CTAG_NOBLEMINOR)
	bypass_lastclass = TRUE

/datum/outfit/noble/trader/pre_equip(mob/living/carbon/human/H)
	..()
	beltr = /obj/item/weapon/knife/dagger/steel/special
	scabbards = list(/obj/item/weapon/scabbard/knife)
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/rich, /obj/item/storage/belt/pouch/coins/rich, /obj/item/storage/keyring)
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltl = /obj/item/flashlight/flare/torch/lantern
	gloves = /obj/item/clothing/gloves/leather
	armor = /obj/item/clothing/shirt/clothvest/colored
	pants = /obj/item/clothing/pants/tights/colored/black

	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_END, -1)
	H.change_stat(STATKEY_CON, -1)
	ADD_TRAIT(H, TRAIT_SEEPRICES, type)

	H.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE) // very good at hiding behind their bodyguard
	H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 5, TRUE)

/datum/outfit/noble/trader/post_equip(mob/living/carbon/human/H)
	. = ..()
	var/static/list/selectablehat = list(
		"Fancy Hat" = /obj/item/clothing/head/fancyhat,
		"Fancy Hat with ear cover" = /obj/item/clothing/head/courtierhat,
		"Chaperon Hat" = /obj/item/clothing/head/chaperon/colored/greyscale/random,
		"Hood" = /obj/item/clothing/head/roguehood/colored/random,
		"Turban" = /obj/item/clothing/head/turban,
		"Fur Hat" = /obj/item/clothing/head/hatfur,
		"Blue Hat" = /obj/item/clothing/head/hatblu,
		"Papakha Hat" = /obj/item/clothing/head/papakha,
		"Hennin Hat" = /obj/item/clothing/head/hennin,
	)
	H.select_equippable(H, selectablehat, message = "Choose your hat of choice", title = "Noble!")
	var/static/list/selectablerobe = list(
		"Shirt" = /obj/item/clothing/shirt/tunic/colored/random,
		"Fancy shirt" = /obj/item/clothing/shirt/tunic/noblecoat,
		"Short shirt" = /obj/item/clothing/shirt/shortshirt/colored/random,
		"Fancy tunic" = /obj/item/clothing/shirt/tunic/colored/random,
		"Grenzelhoft hip shirt" = /obj/item/clothing/shirt/grenzelhoft,
		"Ornate tunic" = /obj/item/clothing/shirt/ornate/tunic,
		"Ornate dress" = /obj/item/clothing/shirt/ornate/dress,
		"Silk dress" = /obj/item/clothing/shirt/dress/silkdress/colored/random,
	)
	H.select_equippable(H, selectablerobe, message = "Choose your shirt of choice", title = "Noble!")
	..()
	var/static/list/selectablecloak = list(
		"Rain cloak" = /obj/item/clothing/cloak/raincloak/colored/random,
		"Fur cloak" = /obj/item/clothing/cloak/raincloak/furcloak,
		"Brown fur cloak" = /obj/item/clothing/cloak/raincloak/furcloak/colored/brown,
		"Black fur cloak" = /obj/item/clothing/cloak/raincloak/furcloak/colored/black,
		"Half cloak" = /obj/item/clothing/cloak/half/colored/random,
	)
	H.select_equippable(H, selectablecloak, message = "Choose your cloak", title = "Noble!")

//................. Noble Lord, the one we got currently .............. //
/datum/job/advclass/noble/common
	title = "Noble"
	tutorial = "You are a wealthy individual who shouldn't be feeding the oppositors to nobility. \
	You are skilled in the art of trade, a minor lord on the town of vanderlin, your wealth attracts the attention of the wrongdoers, wich said people wich end on a bad place after mess with you, relax and enjoy your week like any other, not like anything bad can happen right?"
	outfit = /datum/outfit/noble/common
	give_bank_account = 60 // normal noble bank
	noble_income = 20 // normal income
	category_tags = list(CTAG_NOBLEMINOR)
	bypass_lastclass = TRUE

/datum/outfit/noble/common/pre_equip(mob/living/carbon/human/H)
	..()
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	beltl = /obj/item/ammo_holder/quiver/arrows
	neck = /obj/item/storage/belt/pouch/coins/veryrich
	pants = /obj/item/clothing/pants/tights/colored/black

	if(H.gender == FEMALE)
		beltr = /obj/item/weapon/knife/dagger/steel/special
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/wine = 1, /obj/item/reagent_containers/glass/cup/silver = 1, /obj/item/storage/keyring)
	if(H.age == AGE_CHILD)
		beltr = /obj/item/weapon/knife/dagger/steel/special
		scabbards = list(/obj/item/weapon/scabbard/knife)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/glazed_teapot/tea = 1, /obj/item/reagent_containers/glass/bottle/glazed_teacup = 3, /obj/item/storage/keyring)
	else
		beltr = /obj/item/weapon/sword/rapier/dec
		scabbards = list(/obj/item/weapon/scabbard/sword/noble)
		H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/wine = 1, /obj/item/reagent_containers/glass/cup/silver = 1, /obj/item/storage/keyring)

	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_CON, 1)

	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/music, rand(1,2), TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)

/datum/outfit/noble/common/post_equip(mob/living/carbon/human/H)
	. = ..()
	var/static/list/selectablehat = list(
		"Fancy Hat" = /obj/item/clothing/head/fancyhat,
		"Fancy Hat with ear cover" = /obj/item/clothing/head/courtierhat,
		"Chaperon Hat" = /obj/item/clothing/head/chaperon/colored/greyscale/random,
		"Hood" = /obj/item/clothing/head/roguehood/colored/random,
		"Turban" = /obj/item/clothing/head/turban,
		"Fur Hat" = /obj/item/clothing/head/hatfur,
		"Blue Hat" = /obj/item/clothing/head/hatblu,
		"Papakha Hat" = /obj/item/clothing/head/papakha,
		"Hennin Hat" = /obj/item/clothing/head/hennin,
	)
	H.select_equippable(H, selectablehat, message = "Choose your hat of choice", title = "Noble!")
	var/static/list/selectablerobe = list(
		"Shirt" = /obj/item/clothing/shirt/tunic/colored/random,
		"Fancy shirt" = /obj/item/clothing/shirt/tunic/noblecoat,
		"Short shirt" = /obj/item/clothing/shirt/shortshirt/colored/random,
		"Fancy tunic" = /obj/item/clothing/shirt/tunic/colored/random,
		"Grenzelhoft hip shirt" = /obj/item/clothing/shirt/grenzelhoft,
		"Ornate tunic" = /obj/item/clothing/shirt/ornate/tunic,
		"Ornate dress" = /obj/item/clothing/shirt/ornate/dress,
		"Silk dress" = /obj/item/clothing/shirt/dress/silkdress/colored/random,
	)
	H.select_equippable(H, selectablerobe, message = "Choose your shirt of choice", title = "Noble!")
	..()
	var/static/list/selectablecloak = list(
		"Rain cloak" = /obj/item/clothing/cloak/raincloak/colored/random,
		"Fur cloak" = /obj/item/clothing/cloak/raincloak/furcloak,
		"Brown fur cloak" = /obj/item/clothing/cloak/raincloak/furcloak/colored/brown,
		"Black fur cloak" = /obj/item/clothing/cloak/raincloak/furcloak/colored/black,
		"Half cloak" = /obj/item/clothing/cloak/half/colored/random,
	)
	H.select_equippable(H, selectablecloak, message = "Choose your cloak", title = "Noble!")


//................. Minor son, the poorest yet most armed noble, aka worse than adventurers .............. //
/datum/job/advclass/noble/minorson
	title = "Minor noble"
	tutorial = "You aren't a wealthy individual yet the blood flows on your veins. \
	You are the poorest inheritor from your father, now a minor lord on the town of vanderlin, you will have to make your own fortune like your grandpa did. or you can change your ways for good or bad. it depends on you and the rusty iron armor you inherited, your older brother got the plated armor, saiga and weapons of the house."
	outfit = /datum/outfit/noble/minorson
	give_bank_account = 25 // less than a guard, is poor
	noble_income = 10 // poor income, at least his brothers won't let him starve to death on an alley.
	category_tags = list(CTAG_NOBLEMINOR)
	bypass_lastclass = TRUE

/datum/outfit/noble/minorson/pre_equip(mob/living/carbon/human/H)
	..()
	head = pick(/obj/item/clothing/head/helmet/visored/knight/iron, /obj/item/clothing/head/helmet/visored/sallet/iron)
	neck = /obj/item/clothing/neck/coif/cloth
	armor = pick(/obj/item/clothing/armor/leather/splint, /obj/item/clothing/armor/cuirass/iron)
	pants = /obj/item/clothing/pants/trou/leather/advanced
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor, /obj/item/storage/belt/pouch/coins/poor)

	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_CON, 1)

	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/music, rand(1,2), TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)

/datum/outfit/noble/minorson/post_equip(mob/living/carbon/human/H)
	. = ..()
	var/static/list/selectablerobe = list(
		"Shirt" = /obj/item/clothing/shirt/tunic/colored/random,
		"Fancy shirt" = /obj/item/clothing/shirt/tunic/noblecoat,
		"Short shirt" = /obj/item/clothing/shirt/shortshirt/colored/random,
		"Fancy tunic" = /obj/item/clothing/shirt/tunic/colored/random,
		"Grenzelhoft hip shirt" = /obj/item/clothing/shirt/grenzelhoft,
		"Ornate tunic" = /obj/item/clothing/shirt/ornate/tunic,
		"Ornate dress" = /obj/item/clothing/shirt/ornate/dress,
		"Silk dress" = /obj/item/clothing/shirt/dress/silkdress/colored/random,
	)
	H.select_equippable(H, selectablerobe, message = "Choose your shirt of choice", title = "Noble!")
	..()
	var/static/list/selectablecloak = list(
		"Rain cloak" = /obj/item/clothing/cloak/raincloak/colored/random,
		"Fur cloak" = /obj/item/clothing/cloak/raincloak/furcloak,
		"Brown fur cloak" = /obj/item/clothing/cloak/raincloak/furcloak/colored/brown,
		"Black fur cloak" = /obj/item/clothing/cloak/raincloak/furcloak/colored/black,
		"Half cloak" = /obj/item/clothing/cloak/half/colored/random,
	)
	H.select_equippable(H, selectablecloak, message = "Choose your cloak", title = "Noble!")

	var/list/selectableweapon = list(
		"Sword" = /obj/item/weapon/sword/iron, \
		"Axe" = /obj/item/weapon/axe/iron, \
		"Warhammer" = /obj/item/weapon/mace/warhammer, \
		"Spear" = /obj/item/weapon/polearm/spear, \
		"Flail" = /obj/item/weapon/flail, \
		"Great flail" = /obj/item/weapon/flail/peasant, \
		"Goedendag" = /obj/item/weapon/mace/goden, \
		"Great axe" = /obj/item/weapon/polearm/halberd/bardiche/woodcutter, \
		)
	var/weaponchoice = H.select_equippable(H, selectableweapon, message = "Choose Your armory inheritance!", title = "Poor nobleson!")
	if(!weaponchoice)
		return
	var/grant_shield = TRUE
	switch(weaponchoice)
		if("Sword")
			H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		if("Axe")
			H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		if("Mace")
			H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		if("Spear")
			H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			grant_shield = new /obj/item/weapon/shield/tower/buckleriron
		if("Flail")
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		if("Great flail")
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
			grant_shield = FALSE
		if("Goedendag")
			H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
			grant_shield = FALSE
		if("Great axe")
			H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
			grant_shield = FALSE
	if(grant_shield)
		var/shield_path = pick(list(/obj/item/weapon/shield/heater, /obj/item/weapon/shield/wood))
		var/obj/item/shield = new shield_path()
		if(!H.equip_to_appropriate_slot(shield))
			qdel(shield)

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC) // we are giving them a chance to rp get noble gear to improve their status, if they get an armor to fight they should be able to run away

//................. inhumen traits .............. //
	switch(H.patron?.type)
		if(/datum/patron/inhumen/baotha)
			H.cmode_music = 'sound/music/cmode/antag/CombatBaotha.ogg'
	switch(H.patron?.type)
		if(/datum/patron/inhumen/zizo)
			H.cmode_music = 'sound/music/cmode/antag/combat_cult.ogg'
	switch(H.patron?.type)
		if(/datum/patron/inhumen/matthios)
			H.cmode_music = 'sound/music/cmode/antag/CombatBandit1.ogg'
	switch(H.patron?.type)
		if(/datum/patron/inhumen/graggar)
			H.cmode_music = 'sound/music/cmode/antag/combat_maniac.ogg'

	if(H.dna?.species?.id == SPEC_ID_HUMEN)
		H.dna.species.soundpack_m = new /datum/voicepack/male/knight()

	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Lord"
	if(H.gender == FEMALE)
		honorary = "Lady"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"


/*
/datum/outfit/noble/noblelord/pre_equip/post_equip(mob/living/carbon/human/H)
	. = ..()
	var/static/list/selectablehat = list(
		"Fancy Hat" = /obj/item/clothing/head/fancyhat,
		"Fancy Hat with ear cover" = /obj/item/clothing/head/courtierhat,
		"Chaperon Hat" = /obj/item/clothing/head/chaperon/colored/greyscale/random,
		"Hood" = /obj/item/clothing/head/roguehood/colored/random,
		"Turban" = /obj/item/clothing/head/turban,
		"Fur Hat" = /obj/item/clothing/head/hatfur,
		"Blue Hat" = /obj/item/clothing/head/hatblu,
		"Papakha Hat" = /obj/item/clothing/head/papakha,
		"Hennin Hat" = /obj/item/clothing/head/hennin,
	)
	H.select_equippable(H, selectablehat, message = "Choose your hat of choice", title = "Noble!")
	var/static/list/selectablerobe = list(
		"Shirt" = /obj/item/clothing/shirt/tunic/colored/random,
		"Fancy shirt" = /obj/item/clothing/shirt/tunic/noblecoat,
		"Short shirt" = /obj/item/clothing/shirt/shortshirt/colored/random,
		"Fancy tunic" = /obj/item/clothing/shirt/tunic/colored/random,
		"Grenzelhoft hip shirt" = /obj/item/clothing/shirt/grenzelhoft,
		"Ornate tunic" = /obj/item/clothing/shirt/ornate/tunic,
		"Ornate dress" = /obj/item/clothing/shirt/ornate/dress,
		"Silk dress" = /obj/item/clothing/shirt/dress/silkdress/colored/random,
	)
	H.select_equippable(H, selectablerobe, message = "Choose your shirt of choice", title = "Noble!")

/datum/outfit/noble/noblelord/post_equip(mob/living/carbon/human/H, visuals_only = FALSE)
	..()
	var/static/list/selectablecloak = list(
		"Rain cloak" = /obj/item/clothing/cloak/raincloak/colored/random,
		"Fur cloak" = /obj/item/clothing/cloak/raincloak/furcloak,
		"Brown fur cloak" = /obj/item/clothing/cloak/raincloak/furcloak/colored/brown,
		"Black fur cloak" = /obj/item/clothing/cloak/raincloak/furcloak/colored/black,
		"Half cloak" = /obj/item/clothing/cloak/half/colored/random,
	)
	H.select_equippable(H, selectablecloak, message = "Choose your cloak", title = "Noble!")

/datum/job/advclass/noble/trader // challenge for the merchant, have more money in exchange for more RP money aka hire a lot of people
	title = "Trading noble"
	tutorial = "You are a very wealthy individual. \
	You are well versed in the art of trade, with coins you can make men kill each other and that could get you even more wealth, thankfully your business are more profitable without blood on it."
	outfit = /datum/outfit/noble/trader
	give_bank_account = 85
	noble_income = 30
	category_tags = list(NOBLEMEN)

*/
