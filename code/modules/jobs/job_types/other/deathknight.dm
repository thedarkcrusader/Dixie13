/datum/job/skeleton/knight
	title = "Death Knight"

	outfit = /datum/outfit/deathknight
	cmode_music = 'sound/music/cmode/combat_weird.ogg'
	antag_role = /datum/antagonist/skeleton/knight
	magic_user = TRUE

	jobstats = list(
		STATKEY_STR = 2,
		STATKEY_CON = 2,
		STATKEY_END = 2,
		STATKEY_INT = 3,
		STATKEY_SPD = -3
	)

	skills = list(
		/datum/skill/combat/polearms = 2,
		/datum/skill/combat/axesmaces = 2,
		/datum/skill/combat/wrestling = 4,
		/datum/skill/combat/unarmed = 3,
		/datum/skill/combat/swords = 3,
		/datum/skill/misc/riding = 3,
		/datum/skill/misc/athletics = 3,
		/datum/skill/magic/arcane = 3
	)

	traits = list(
		TRAIT_HEAVYARMOR,
		TRAIT_CRITICAL_WEAKNESS
	)

	spells = list(
		/datum/action/cooldown/spell/projectile/lightning,
		/datum/action/cooldown/spell/projectile/fetch
	)

/datum/job/skeleton/knight/after_spawn(mob/living/carbon/spawned, client/player_client)
	SSmapping.find_and_remove_world_trait(/datum/world_trait/death_knight)
	SSmapping.retainer.death_knights |= spawned.mind
	. = ..()

	spawned.name = "Death Knight"
	spawned.real_name = "Death Knight"

	if(spawned.patron != /datum/patron/inhumen/zizo)
		spawned.set_patron(/datum/patron/divine/noc)

/datum/outfit/deathknight/pre_equip(mob/living/carbon/human/H)
	. = ..()
	belt = /obj/item/storage/belt/leather
	pants = /obj/item/clothing/pants/platelegs/blk/death
	shoes = /obj/item/clothing/shoes/boots/armor/blkknight
	shirt = /obj/item/clothing/shirt/undershirt/colored/black
	armor = /obj/item/clothing/armor/plate/blkknight/death
	gloves = /obj/item/clothing/gloves/plate/blk/death
	backl = /obj/item/weapon/sword/long/death
	head = /obj/item/clothing/head/helmet/visored/knight/blk

/obj/item/clothing/armor/plate/blkknight/death
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/shoes/boots/armor/blkknight/death
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/gloves/plate/blk/death
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/pants/platelegs/blk/death
	color = CLOTHING_SOOT_BLACK
