/datum/migrant_role/khan
	name = "Khan"
	greet_text = "You are the khan of a horde of nomads, you have migrated to these lands with them"
	migrant_job = /datum/job/migrant/khan

/datum/job/migrant/khan
	title = "khan"
	tutorial = "You were apart of an expedition sent by the Monarch to Kingsfield, you and those under your command have returned upon fullfiling your task."
	outfit = /datum/outfit/khan
	allowed_races = RACES_PLAYER_FOREIGNNOBLE

	jobstats = list(
		STATKEY_STR = 2,
		STATKEY_INT = 2,
		STATKEY_END = 2,
	)

	skills = list(
		/datum/skill/combat/swords = 4,
        /datum/skill/craft/crafting = 2,
		/datum/skill/craft/tanning = 3,
		/datum/skill/combat/bows = 3,
		/datum/skill/combat/knives = 2,
		/datum/skill/craft/cooking = 1,
		/datum/skill/labor/butchering = 2,
		/datum/skill/labor/taming = 4,
		/datum/skill/misc/medicine = 1,
		/datum/skill/misc/sewing = 2,
		/datum/skill/misc/sneaking = 2,
		/datum/skill/craft/traps = 3,
		/datum/skill/misc/athletics = 3,
		/datum/skill/misc/climbing = 2,
		/datum/skill/misc/swimming = 1,
		/datum/skill/misc/riding = 6,
    )

	traits = list(
		TRAIT_HEAVYARMOR,
        TRAIT_MEDIUMARMOR,
		TRAIT_STEELHEARTED,
        TRAIT_DUALWIELDER,
        TRAIT_NOBLE,
	)

	cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'

/datum/job/migrant/khan/after_spawn(mob/living/carbon/human/spawned, client/player_client)
	. = ..()
	var/prev_real_name = spawned.real_name
	var/prev_name = spawned.name
	var/honorary = "Khan"
	spawned.real_name = "[honorary] [prev_real_name]"
	spawned.name = "[honorary] [prev_name]"
	new /mob/living/simple_animal/hostile/retaliate/saigabuck/tame/saddled(get_turf(spawned))

/datum/outfit/khan
	name = "khan"
	shoes = /obj/item/clothing/shoes/boots/leather
	gloves = /obj/item/clothing/gloves/leather
	belt = /obj/item/storage/belt/leather/mercenary/black
	wrists = /obj/item/clothing/wrists/bracers/leather
	beltr = /obj/item/weapon/sword/sabre
	beltl= /obj/item/ammo_holder/quiver/arrows
	shirt = /obj/item/clothing/armor/gambeson/light/steppe
	pants = /obj/item/clothing/pants/tights/colored/red
	neck = /obj/item/storage/belt/pouch/coins/rich
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/short
	backr = /obj/item/storage/backpack/satchel
	armor = /obj/item/clothing/armor/medium/scale/steppe
	head = /obj/item/clothing/head/helmet/bascinet/steppe
	scabbards = list(/obj/item/weapon/scabbard/sword)
	backpack_contents = list(/obj/item/weapon/knife/hunting = 1, /obj/item/tent_kit = 1, /obj/item/clothing/face/facemask/steel/steppe = 1)

/datum/migrant_role/nomadrider
	name = "Nomad Rider"
	greet_text = "You were apart of an expedition sent by the Monarch to Kingsfield, you and your serjeant-at-arms have returned upon fullfiling your task."
	migrant_job = /datum/job/migrant/nomadrider

/datum/job/migrant/nomadrider
	title = "Nomad Rider"
	tutorial = "You were apart of an expedition sent by the Monarch to Kingsfield, you and your serjeant-at-arms have returned upon fullfiling your task."
	outfit = /datum/outfit/nomadrider
	allowed_races = RACES_PLAYER_ALL
	is_foreigner = FALSE

	jobstats = list(
		STATKEY_PER = 2,
		STATKEY_END = 1,
		STATKEY_SPD = 2,
	)

	skills = list(
		/datum/skill/craft/crafting = 2,
		/datum/skill/craft/tanning = 3,
		/datum/skill/combat/bows = 3,
		/datum/skill/combat/knives = 2,
		/datum/skill/craft/cooking = 1,
		/datum/skill/labor/butchering = 2,
		/datum/skill/labor/taming = 4,
		/datum/skill/misc/medicine = 1,
		/datum/skill/misc/sewing = 2,
		/datum/skill/misc/sneaking = 2,
		/datum/skill/craft/traps = 3,
		/datum/skill/misc/athletics = 3,
		/datum/skill/misc/climbing = 2,
		/datum/skill/misc/swimming = 1,
		/datum/skill/misc/riding = 4,
	)

	traits = list(
		TRAIT_DODGEEXPERT,
	)

	cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'

/datum/outfit/nomadrider
	name = "Nomad Rider"
	pants = /obj/item/clothing/pants/tights/colored/random
	shirt =  /obj/item/clothing/armor/gambeson/light/steppe
	shoes = /obj/item/clothing/shoes/boots/leather
	neck = /obj/item/storage/belt/pouch/coins/poor
	head = /obj/item/clothing/head/papakha
	cloak = /obj/item/clothing/cloak/volfmantle
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/short
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/ammo_holder/quiver/arrows
	beltl = /obj/item/storage/meatbag
	backpack_contents = list(/obj/item/bait = 1, /obj/item/weapon/knife/hunting = 1, /obj/item/tent_kit = 1)

/datum/job/migrant/khan/after_spawn(mob/living/carbon/human/spawned, client/player_client)

/datum/migrant_wave/nomad_migration
	name = "The Khan's Migration"
	max_spawns = 2
	shared_wave_type = /datum/migrant_wave/nomad_migration
	downgrade_wave = /datum/migrant_wave/nomad_migration_down
	weight = 40
	roles = list(
		/datum/migrant_role/khan = 1,
		/datum/migrant_role/nomadrider = 5,
	)
	greet_text = "You were apart of an expedition sent by the Monarch to Kingsfield, as it is done, you now return."

/datum/migrant_wave/nomad_migration_down
	name = "The Khan's Migration"
	shared_wave_type = /datum/migrant_wave/nomad_migration
	downgrade_wave = /datum/migrant_wave/nomad_migration_down_one
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/khan = 1,
		/datum/migrant_role/nomadrider = 4,
	)
	greet_text = "You were apart of an expedition sent by the Monarch to Kingsfield, as it is done, you now return."

/datum/migrant_wave/nomad_migration_down_one
	name = "The Khan's Migration"
	shared_wave_type = /datum/migrant_wave/nomad_migration
	downgrade_wave = /datum/migrant_wave/nomad_migration_down_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/khan = 1,
		/datum/migrant_role/nomadrider = 3,
	)
	greet_text = "You were apart of an expedition sent by the Monarch to Kingsfield, as it is done, you now return."

/datum/migrant_wave/nomad_migration_down_two
	name = "The Khan's Migration"
	shared_wave_type = /datum/migrant_wave/nomad_migration
	downgrade_wave = /datum/migrant_wave/nomad_migration_down_three
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/khan = 1,
		/datum/migrant_role/nomadrider = 2,
	)
	greet_text = "You were apart of an expedition sent by the Monarch to Kingsfield, as it is done, you now return."

/datum/migrant_wave/nomad_migration_down_three
	name = "The Khan's Migration"
	shared_wave_type = /datum/migrant_wave/nomad_migration
	downgrade_wave = /datum/migrant_wave/nomad_migration_down_four
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/khan = 1,
		/datum/migrant_role/nomadrider = 1,
	)
	greet_text = "You were apart of an expedition sent by the Monarch to Kingsfield, as it is done, you now return."

/datum/migrant_wave/nomad_migration_down_four
	name = "The Khan's Migration"
	shared_wave_type = /datum/migrant_wave/nomad_migration
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/khan = 1,
	)
	greet_text = "You were apart of an expedition sent by the Monarch to Kingsfield, as it is done, you now return."
