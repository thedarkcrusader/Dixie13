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
//trait
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

    jobstats = list(
        STATKEY_INT = 1,
        STATKEY_PER = 1,
        STATKEY_STR = -1,
        STATKEY_END = -1,
        STATKEY_CON = -1,
    )
    skills = list(
        /datum/skill/misc/reading = SKILL_LEVEL_MASTER,
        /datum/skill/labor/mathematics = SKILL_LEVEL_MASTER,
        /datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
        /datum/skill/misc/stealing = SKILL_LEVEL_JOURNEYMAN,
        /datum/skill/misc/lockpicking = SKILL_LEVEL_APPRENTICE,
        /datum/skill/misc/riding = SKILL_LEVEL_APPRENTICE,
    )

    traits = list(TRAIT_SEEPRICES)

/datum/outfit/noble/trader
    name = "Trading Noble"
    beltr = /obj/item/weapon/knife/dagger/steel/special
    scabbards = list(/obj/item/weapon/scabbard/knife)
    backpack_contents = list(/obj/item/storage/belt/pouch/coins/rich, /obj/item/storage/belt/pouch/coins/rich, /obj/item/storage/keyring)
    belt = /obj/item/storage/belt/leather/plaquesilver
    beltl = /obj/item/flashlight/flare/torch/lantern
    gloves = /obj/item/clothing/gloves/leather
    armor = /obj/item/clothing/shirt/clothvest/colored
    pants = /obj/item/clothing/pants/tights/colored/black

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
    give_bank_account = 60
    noble_income = 20 
    category_tags = list(CTAG_NOBLEMINOR)
    bypass_lastclass = TRUE

    jobstats = list(
        STATKEY_INT = 1,
        STATKEY_PER = 1,
        STATKEY_CON = 1,
    )
    skills = list(
        /datum/skill/misc/reading = SKILL_LEVEL_MASTER,
        /datum/skill/labor/mathematics = SKILL_LEVEL_JOURNEYMAN,
        /datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
        /datum/skill/misc/riding = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/music, rand(1,2),
		/datum/skill/combat/bows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_APPRENTICE,
    )

/datum/outfit/noble/common
    name = "Noble"
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	beltl = /obj/item/ammo_holder/quiver/arrows
	neck = /obj/item/storage/belt/pouch/coins/veryrich
	pants = /obj/item/clothing/pants/tights/colored/black

//gender & age code
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

    jobstats = list(
        STATKEY_INT = 1,
        STATKEY_PER = 1,
        STATKEY_CON = 1,
    )
    skills = list(
        /datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
        /datum/skill/labor/mathematics = SKILL_LEVEL_APPRENTICE,
        /datum/skill/misc/sneaking = SKILL_LEVEL_APPRENTICE,
        /datum/skill/misc/riding = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/music, SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/bows = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/crossbows = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
    )

	traits = list(TRAIT_HEAVYARMOR)

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
		"Dagger" = /obj/item/weapon/knife/dagger, \
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
		if("Daggers")
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			grant_shield = FALSE
	if(grant_shield)
		var/shield_path = pick(list(/obj/item/weapon/shield/heater, /obj/item/weapon/shield/wood))
		var/obj/item/shield = new shield_path()
		if(!H.equip_to_appropriate_slot(shield))
			qdel(shield)

//................. Uplifted peasant, a commision to have a worker noble .............. //

/
/datum/job/advclass/noble/peasant
	title = "Field Noble"
	tutorial = "You are a new addition to nobility, uplifted by your lord chosen by astrata herself. \
	You aren't skilled in the art of trade since your hands know the work, a minor lord on the town of vanderlin, you don't seem to adapt fully to this life of pleasure and diplomacy, yet this is your future for now on..."
	outfit = /datum/outfit/noble/peasant
	give_bank_account = 60 // normal noble bank
	noble_income = 20 // normal income
	category_tags = list(CTAG_NOBLEMINOR)
	bypass_lastclass = TRUE

    jobstats = list(
        STATKEY_INT = 1,
        STATKEY_PER = 1,
        STATKEY_CON = 1,
    )
    skills = list(
        /datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
        /datum/skill/labor/mathematics = SKILL_LEVEL_NOVICE,
        /datum/skill/misc/lockpicking = SKILL_LEVEL_APPRENTICE,
        /datum/skill/misc/riding = SKILL_LEVEL_NOVICE,
		/datum/skill/labor/farming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/tanning = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/bows = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/polearms = SKILL_LEVEL_APPRENTICE,
    )

    traits = list(TRAIT_SEEDKNOW)

/datum/outfit/noble/peasant
    name = "Field Noble"
	backr = /obj/item/weapon/pitchfork
	beltl = /obj/item/weapon/sword/decorated// his first sword
	neck = /obj/item/storage/belt/pouch/coins/veryrich
	pants = /obj/item/clothing/pants/tights/colored/black
	backpack_contents = list(/obj/item/reagent_containers/glass/bottle/wine = 1, /obj/item/reagent_containers/glass/cup/silver = 1, /obj/item/storage/keyring, , /obj/item/weapon/knife/villager)

/datum/outfit/noble/peasant/post_equip(mob/living/carbon/human/H)
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

//................. inhumen traits .............. //
	switch(H.patron?.type)
		if(/datum/patron/inhumen/baotha)
			H.cmode_music = 'sound/music/cmode/antag/CombatBaotha.ogg'
		if(/datum/patron/inhumen/zizo)
			H.cmode_music = 'sound/music/cmode/antag/combat_cult.ogg'
		if(/datum/patron/inhumen/matthios)
			H.cmode_music = 'sound/music/cmode/antag/CombatBandit1.ogg'
		if(/datum/patron/inhumen/graggar)
			H.cmode_music = 'sound/music/cmode/antag/combat_maniac.ogg'

//voices
	if(H.dna?.species?.id == SPEC_ID_HUMEN)
		H.dna.species.soundpack_m = new /datum/voicepack/male/knight()

//noble honorary
	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Lord"
	if(H.gender == FEMALE)
		honorary = "Lady"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"
