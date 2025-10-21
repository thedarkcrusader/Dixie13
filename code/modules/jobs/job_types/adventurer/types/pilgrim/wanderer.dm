/datum/job/advclass/pilgrim/wanderer
	title = "Wanderer"
	tutorial = "You are a member of the Merry Band, a humble guild of wanderers who have united under one common desire. Wandering for the sake of experiencing the beauty and diversity of Faience to the fullest extent. As the motto of the Merry Band goes, ''Make every step count, and may your journeys be full of wonder''."
	allowed_races = RACES_PLAYER_ALL
	total_positions = 5
	min_pq = 0
	category_tags = list(CTAG_PILGRIM)
	outfit = /datum/outfit/adventurer/wanderingpilgrim
	allowed_sexes = list(MALE, FEMALE)

/datum/outfit/adventurer/wanderingpilgrim/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/leather/headscarf
	shoes = /obj/item/clothing/shoes/sandals
	pants = /obj/item/clothing/pants/trou/leather/quiltedkilt/colored/linen
	armor = /obj/item/clothing/shirt/clothvest/colored/random
	shirt = /obj/item/clothing/shirt/undershirt/lowcut
	wrists = /obj/item/clothing/wrists/bracers/leather
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/knife/dagger
	neck = /obj/item/clothing/neck/silveramulet
	backr = /obj/item/weapon/polearm/woodstaff/quarterstaff
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor = 1, /obj/item/reagent_containers/food/snacks/hardtack = 1)
	if (H.mind)
		var/language = pickweight(list("Dwarvish" = 1, "Elvish" = 1, "Hellspeak" = 1, "Zaladin" = 1, "Orcish" = 1, "Old Psydonic" = 1,))
		switch(language)
			if("Dwarvish")
				H.grant_language(/datum/language/dwarvish)
				to_chat(H,span_info("\
				I learned the tongue of the Dwarves through my travels.")
				)
			if("Elvish")
				H.grant_language(/datum/language/elvish)
				to_chat(H,span_info("\
				I learned the tongue of the Elves through my travels.")
				)
			if("Hellspeak")
				H.grant_language(/datum/language/hellspeak)
				to_chat(H,span_info("\
				I learned the tongue of the hellspawn through my travels.")
				)
			if("Zaladin")
				H.grant_language(/datum/language/zalad)
				to_chat(H,span_info("\
				I learned the tongue of Zaladin through my travels.")
				)
			if("Orcish")
				H.grant_language(/datum/language/orcish)
				to_chat(H,span_info("\
				I learned the tongue of the Orcs through my travels.")
				)
			if("Old Psydonic")
				H.grant_language(/datum/language/orcish)
				to_chat(H,span_info("\
				I learned to speak Old Psydonic through my travels.")
				)
		H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE) // have to be atleaast somewhat competent with one weapon to have traveled alot
		H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.change_stat(STATKEY_LCK, 1) //Wanderers are meant to be a blank slate, so they dont really have anything. But i think some bonus luck would be make sense for them.



