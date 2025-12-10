/datum/job/advclass/pilgrim/noble
	title = "Noble"
	tutorial = "The blood of a noble family runs through your veins. Perhaps you are visiting from some place far away, \
	looking to enjoy the hospitality of the ruler. You have many mammons to your name, but with wealth comes \
	danger, so keep your wits and tread lightly..."
	allowed_races = RACES_PLAYER_FOREIGNNOBLE
	outfit = /datum/outfit/pilgrim/noble
	category_tags = list(CTAG_PILGRIM)
	total_positions = 2
	apprentice_name = "Servant"
	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'
	spells = list(
		/datum/action/cooldown/spell/undirected/call_bird = 1,
	)

	jobstats = list(
		STATKEY_INT = 1
	)

	skills = list(
		/datum/skill/misc/reading = 2,
		/datum/skill/misc/riding = 2,
		/datum/skill/misc/sneaking = 2,
		/datum/skill/misc/athletics = 2,
		/datum/skill/combat/unarmed = 1,
		/datum/skill/combat/wrestling = 1,
		/datum/skill/combat/bows = 2
	)

	traits = list(
		TRAIT_NOBLE
	)

/datum/job/advclass/pilgrim/noble/after_spawn(mob/living/carbon/human/spawned, client/player_client)
	. = ..()
	var/prev_real_name = spawned.real_name
	var/prev_name = spawned.name
	var/honorary = "Lord"
	if(spawned.pronouns == SHE_HER)
		honorary = "Lady"
	spawned.real_name = "[honorary] [prev_real_name]"
	spawned.name = "[honorary] [prev_name]"

	spawned.adjust_skillrank(/datum/skill/misc/music, pick(1, 2), TRUE)

	if(spawned.gender == FEMALE)
		spawned.adjust_stat_modifier("job_stats", STATKEY_SPD, 1)
		spawned.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	if(spawned.gender == MALE)
		spawned.adjust_stat_modifier("job_stats", STATKEY_CON, 1)
		spawned.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)

/datum/outfit/pilgrim/noble
	name = "Noble (Pilgrim)"
	shoes = /obj/item/clothing/shoes/boots
	backl = /obj/item/storage/backpack/satchel
	neck = /obj/item/storage/belt/pouch/coins/veryrich
	belt = /obj/item/storage/belt/leather
	ring = /obj/item/clothing/ring/silver

/datum/outfit/adventurer/noble/pre_equip(mob/living/carbon/human/equipped_human, visuals_only)
	. = ..()
	if(equipped_human.gender == FEMALE)
		shirt = /obj/item/clothing/shirt/dress/silkdress/colored/random
		head = /obj/item/clothing/head/hatfur
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
		beltr = /obj/item/weapon/knife/dagger/steel/special
		beltl = /obj/item/ammo_holder/quiver/arrows
		backpack_contents = list(
			/obj/item/reagent_containers/glass/bottle/wine = 1,
			/obj/item/reagent_containers/glass/cup/silver = 1
		)
	if(equipped_human.gender == MALE)
		pants = /obj/item/clothing/pants/tights/colored/black
		shirt = /obj/item/clothing/shirt/tunic/colored/random
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
		head = /obj/item/clothing/head/fancyhat
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
		beltr = /obj/item/weapon/sword/rapier/dec
		beltl = /obj/item/ammo_holder/quiver/arrows
		backpack_contents = list(
			/obj/item/reagent_containers/glass/bottle/wine = 1,
			/obj/item/reagent_containers/glass/cup/silver = 1
		)