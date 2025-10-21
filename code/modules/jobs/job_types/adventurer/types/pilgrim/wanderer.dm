/datum/job/advclass/pilgrim/wanderer
	title = "Wanderer"
	tutorial = "You are a member of the Merry Band, a guild of wanderers who have united under one simple desire, to wander for the sake of experiencing the beauty and diversity of Faience to the fullest extent. As the motto of the Merry Band goes, ''Make every step matter, and may your journeys be full of wonder''."
	allowed_races = RACES_PLAYER_ALL
	cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
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
		H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE) // haha staff go bonk
		H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)

		H.change_stat(STATKEY_PER, 1)
		H.change_stat(STATKEY_CON, 2) //they got no armor dawg!
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_STR, 1)



