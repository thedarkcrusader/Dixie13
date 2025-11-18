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

/datum/outfit/adventurer/noble/pre_equip(mob/living/carbon/human/H)
	..()
	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Lord"
	if(H.gender == FEMALE)
		honorary = "Lady"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"
	shoes = /obj/item/clothing/shoes/nobleboot
	backl = /obj/item/storage/backpack/satchel
	neck = /obj/item/storage/belt/pouch/coins/veryrich
	belt = /obj/item/storage/belt/leather
	ring = /obj/item/clothing/ring/silver
	if(H.gender == FEMALE)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		pants = /obj/item/clothing/pants/tights/colored/black
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
		beltr = /obj/item/weapon/knife/dagger/steel/special
		beltl = /obj/item/ammo_holder/quiver/arrows
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/wine = 1, /obj/item/reagent_containers/glass/cup/silver = 1)
	if(H.gender == MALE)
		H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		pants = /obj/item/clothing/pants/tights/colored/black
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
		beltr = /obj/item/weapon/sword/rapier/dec
		beltl = /obj/item/ammo_holder/quiver/arrows
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/wine = 1, /obj/item/reagent_containers/glass/cup/silver = 1)

//skills
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/music, rand(1,2), TRUE)

//traits
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)

//jobstats
	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_CON, 1)

/datum/outfit/adventurer/noble/post_equip(mob/living/carbon/human/H)
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