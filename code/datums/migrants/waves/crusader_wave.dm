/datum/migrant_role/inquisitor
	name = "Episcopal Inquisitor"
	description = "These lands have forfeited Psydon and the Ten. You have come to restore the True faith to these people and tear out the rot festering within."
	migrant_job = /datum/job/specialinquisitor

/datum/job/specialinquisitor
	title = "Episcopal Inquisitor"
	tutorial = "These lands have forfeited Psydon and the Ten. You have come to restore the True faith to these people and tear out the rot festering within."
	outfit = /datum/outfit/job/specialinquisitor
	antag_role = /datum/antagonist/purishep
	allowed_races = list(SPEC_ID_HUMEN)
	is_recognized = TRUE

	jobstats = list(
		STATKEY_INT = 2,
		STATKEY_STR = 1,
		STATKEY_PER = 2,
		STATKEY_SPD = 2,
		STATKEY_END = 1,
	)

	skills = list(
		/datum/skill/misc/sewing = 2,
		/datum/skill/misc/medicine = 2,
		/datum/skill/combat/unarmed = 2,
		/datum/skill/combat/wrestling = 4,
		/datum/skill/misc/reading = 3,
		/datum/skill/combat/swords = 4,
		/datum/skill/combat/crossbows = 3,
		/datum/skill/misc/climbing = 4,
		/datum/skill/misc/riding = 1,
		/datum/skill/misc/athletics = 4,
		/datum/skill/misc/swimming = 2,
		/datum/skill/misc/lockpicking = 2,
		/datum/skill/combat/firearms = 3,
		/datum/skill/combat/knives = 3,
		/datum/skill/labor/mathematics = 3,
	)

	traits = list(
		TRAIT_DODGEEXPERT,
		TRAIT_STEELHEARTED,
		TRAIT_NOBLE,
		TRAIT_MEDIUMARMOR,
	)

	languages = list(/datum/language/oldpsydonic)

/datum/job/specialinquisitor/after_spawn(mob/living/carbon/human/spawned, client/player_client)
	. = ..()
	spawned.set_patron(/datum/patron/psydon)
	spawned.verbs |= /mob/living/carbon/human/proc/torture_victim
	spawned.verbs |= /mob/living/carbon/human/proc/faith_test
	spawned.mind?.teach_crafting_recipe(/datum/repeatable_crafting_recipe/reading/confessional)

	var/datum/species/species = spawned.dna?.species
	if(!species)
		return
	species.native_language = "Old Psydonic"
	species.accent_language = species.get_accent(species.native_language)

/datum/outfit/job/specialinquisitor
	wrists = /obj/item/clothing/neck/psycross/silver
	neck = /obj/item/clothing/neck/bevor
	shirt = /obj/item/clothing/shirt/undershirt/fancy
	belt = /obj/item/storage/belt/leather/knifebelt/black/psydon
	shoes = /obj/item/clothing/shoes/otavan/inqboots
	pants = /obj/item/clothing/pants/trou/leather
	backr = /obj/item/storage/backpack/satchel
	head = /obj/item/clothing/head/leather/inqhat
	gloves = /obj/item/clothing/gloves/leather/otavan/inqgloves
	beltr = /obj/item/storage/belt/pouch/coins/rich
	beltl = /obj/item/weapon/sword/rapier
	mask = /obj/item/clothing/face/spectacles/inqglasses
	armor = /obj/item/clothing/armor/medium/scale/inqcoat

	backpack_contents = list(
		/obj/item/weapon/knife/dagger/silver,
		/obj/item/flashlight/flare/torch/lantern/copper,
	)

/datum/migrant_role/crusader
	name = "Episcopal Crusader"
	description = "Crusader of the true faith, you came from Grenzelhoft under the command of the Inquisitor. Obey them as they lead you to smite the heathens."
	migrant_job = /datum/job/adventurer/crusader

// :((
/datum/job/advclass/pilgrim/rare/crusader/inquisition
	title = "Episcopal Crusader"
	tutorial = "Crusader of the true faith, you came from Grenzelhoft under the command of the Inquisitor. Obey them as they lead you to smite the heathens."
	allowed_races = RACES_PLAYER_GRENZ
	is_recognized = TRUE
	allowed_patrons = null
	category_tags = null
	roll_chance = null
	total_positions = 0

/datum/job/advclass/pilgrim/rare/crusader/inquisition/after_spawn(mob/living/carbon/human/spawned, client/player_client)
	. = ..()
	spawned.set_patron(/datum/patron/psydon)

	var/datum/species/species = spawned.dna?.species
	if(!species)
		return
	species.native_language = "Old Psydonic"
	species.accent_language = species.get_accent(species.native_language)

/datum/migrant_wave/crusade
	name = "The Holy Crusade"
	shared_wave_type = /datum/migrant_wave/crusade
	downgrade_wave = /datum/migrant_wave/crusade_down_one
	weight = 5
	max_spawns = 1
	roles = list(
		/datum/migrant_role/inquisitor = 1,
		/datum/migrant_role/crusader = 4)
	greet_text = "These heathens, they have forsaken the teaching of everything that is good. We shan't let them insults the true Gods no more. The Inquisitor will lead us to make sure of that."

/datum/migrant_wave/crusade_down_one
	name = "The Holy Crusade"
	shared_wave_type = /datum/migrant_wave/crusade
	downgrade_wave = /datum/migrant_wave/crusade_down_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/inquisitor = 1,
		/datum/migrant_role/crusader = 3)
	greet_text = "These heathens, they have forsaken the teaching of everything that is good. We shan't let them insults the true Gods no more. The Inquisitor will lead us to make sure of that."

/datum/migrant_wave/crusade_down_two
	name = "The Holy Crusade"
	shared_wave_type = /datum/migrant_wave/crusade
	downgrade_wave = /datum/migrant_wave/crusade_down_three
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/inquisitor = 1,
		/datum/migrant_role/crusader = 2)
	greet_text = "These heathens, they have forsaken the teaching of everything that is good. We shan't let them insults the true Gods no more. The Inquisitor will lead us to make sure of that."

/datum/migrant_wave/crusade_down_three
	name = "The Holy Crusade"
	shared_wave_type = /datum/migrant_wave/crusade
	downgrade_wave = /datum/migrant_wave/crusade_down_four
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/inquisitor = 1,
		/datum/migrant_role/crusader = 1)
	greet_text = "These heathens, they have forsaken the teaching of everything that is good. We shan't let them insults the true Gods no more. The Inquisitor will lead us to make sure of that."

/datum/migrant_wave/crusade_down_four
	name = "The One-Man Crusade"
	shared_wave_type = /datum/migrant_wave/crusade
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/inquisitor = 1)
	greet_text = "These heathens, they have forsaken the teaching of everything that is good. I shan't let them insult the true Gods no more. I will make sure of that."
