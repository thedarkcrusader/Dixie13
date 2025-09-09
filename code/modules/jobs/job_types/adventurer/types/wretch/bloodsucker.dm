/datum/advclass/wretch/bloodsucker
	name = "Bloodsucker"
	tutorial = "You are a warrior feared for your brutality, dedicated to using your might for your own gain. Might equals right, and you are the reminder of such a saying."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL
	category_tags = list(CTAG_WRETCH)
	outfit = /datum/outfit/job/wretch/bloodsucker
	maximum_possible_slots = 2

/datum/outfit/job/wretch/bloodsucker/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		if(H.mind.has_antag_datum(/datum/antagonist))
			return
		var/datum/antagonist/vampire/new_antag = new /datum/antagonist/vampire
		H.mind.add_antag_datum(new_antag)
		H.set_patron(/datum/patron/godless, TRUE)
		if(H.clan)
			H.not_clan_leader = TRUE
	//Small health vial
	var/classes = list("The Noble", "The Count")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	switch(classchoice)
		if("The Noble")
			noble_equip(H)
		if("The Count")
			grenzel_equip(H)

/datum/outfit/job/wretch/bloodsucker/proc/noble_equip(mob/living/carbon/human/H)
	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Lord"
	if(H.gender == FEMALE)
		honorary = "Lady"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/music, rand(1,2), TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.change_stat(STATKEY_INT, 1)
	shoes = /obj/item/clothing/shoes/boots
	backl = /obj/item/storage/backpack/satchel
	neck = /obj/item/storage/belt/pouch/coins/mid
	belt = /obj/item/storage/belt/leather

	if(H.gender == FEMALE)
		H.change_stat(STATKEY_SPD, 1)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		shirt = /obj/item/clothing/shirt/dress/silkdress/colored/random
		head = /obj/item/clothing/head/hatfur
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
		beltr = /obj/item/weapon/knife/dagger/steel/special
		beltl = /obj/item/ammo_holder/quiver/arrows
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/wine = 1, /obj/item/reagent_containers/glass/cup/silver = 1)
	if(H.gender == MALE)
		H.change_stat(STATKEY_CON, 1)
		H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		pants = /obj/item/clothing/pants/tights/colored/black
		shirt = /obj/item/clothing/shirt/tunic/colored/random
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
		head = /obj/item/clothing/head/fancyhat
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
		beltr = /obj/item/weapon/sword/rapier/dec
		beltl = /obj/item/ammo_holder/quiver/arrows
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/wine = 1, /obj/item/reagent_containers/glass/cup/silver = 1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)

/datum/outfit/job/wretch/bloodsucker/proc/grenzel_equip(mob/living/carbon/human/H)
	shoes = /obj/item/clothing/shoes/rare/grenzelhoft
	gloves = /obj/item/clothing/gloves/angle/grenzel
	head = /obj/item/clothing/head/helmet/skullcap/grenzelhoft
	belt = /obj/item/storage/belt/leather/plaquegold
	beltl = /obj/item/weapon/sword/sabre/dec
	backr = /obj/item/storage/backpack/satchel
	ring = /obj/item/clothing/ring/gold
	shirt = /obj/item/clothing/shirt/grenzelhoft
	pants = /obj/item/clothing/pants/grenzelpants
	neck = /obj/item/clothing/neck/gorget
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/mid)
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/armor/gambeson/heavy/dress/alt
		beltl = /obj/item/weapon/sword/rapier/dec
	if(H.mind)
		H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Count"
		if(H.gender == FEMALE)
			honorary = "Countess"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"
		if(!H.has_language(/datum/language/oldpsydonic))
			H.grant_language(/datum/language/oldpsydonic)
			to_chat(H, "<span class='info'>I can speak Old Psydonic with ,m before my speech.</span>")
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_END, 2)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_FOREIGNER, TRAIT_GENERIC)
