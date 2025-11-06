/datum/job/advclass/pilgrim/noble
	title = "Noble"
	tutorial = "The blood of a noble family runs through your veins. Perhaps you are visiting from some place far away, \
	looking to enjoy the hospitality of the ruler. You have many mammons to your name, but with wealth comes \
	danger, so keep your wits and tread lightly..."
	allowed_races = RACES_PLAYER_FOREIGNNOBLE
	outfit = /datum/outfit/adventurer/noble
	category_tags = list(CTAG_PILGRIM)
	total_positions = 2
	apprentice_name = "Servant"
	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'
	spells = list(
		/datum/action/cooldown/spell/undirected/call_bird = 1,
	)

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

/datum/outfit/adventurer/noble
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

/datum/outfit/adventurer/noble/common/post_equip(mob/living/carbon/human/H)
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
