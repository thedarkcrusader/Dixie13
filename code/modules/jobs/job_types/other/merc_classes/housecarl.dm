/datum/job/advclass/mercenary/housecarl
	title = "Elven Housecarl"
	tutorial = "Once a mighty guard for your clan leader now freelancer looking to put bread on the table, you have ventured to distance lands for work. Either it be guarding the gold horde of the merchant or the life of the king, you and others like you have been sought out by many to protect their lives and property."
allowed_races = RACES_PLAYER_ELF
	outfit = /datum/outfit/mercenary/housecarl
	category_tags = list(CTAG_MERCENARY)
	cmode_music = 'sound/music/cmode/adventurer/CombatWarrior.ogg'
		total_positions = 3


/datum/outfit/mercenary/housecarl/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/axesmaces), 1, TRUE
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, pick(0,1,1), TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)

	if(H.gender == FEMALE)
		H.underwear = "Femleotard"
		H.underwear_color = CLOTHING_SOOT_BLACK
		H.update_body()

	head = /obj/item/clothing/head/helmet/nasal
	shoes = /obj/item/clothing/shoes/boots
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	gloves = /obj/item/clothing/gloves/leather/black
	backr = /obj/item/weapon/polearm/halberd/bardiche/woodcutter
	wrists = /obj/item/clothing/wrists/bracers/leather
	neck = /obj/item/clothing/neck/highcollier
	armor = /obj/item/clothing/armor/chainmail/hauberk
	belt = /obj/item/storage/belt/leather/mercenary/black
	pants = /obj/item/clothing/pants/trou/leather
	backl = /obj/item/weapon/shield/tower/metal

	H.merctype = 2

	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_CON, -1)
	H.change_stat(STATKEY_INT, -2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
