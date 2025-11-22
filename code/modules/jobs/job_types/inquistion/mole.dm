/datum/job/villager/mole
	title = "Res Adeptus"
	tutorial = "You are a Res Adeptus of the inquisition, unwillingly abducted and put to intense torment by the inquisition,\
	you are now a hidden traitor to your home, a heretic unwilling.\
	You follow the commands of the inquisition members and contribute by spying on the townsfolk"
	department_flag = PEASANTS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_FOREIGNERS
	total_positions = 1
	spawn_positions = 1
	min_pq = 5
	allowed_ages = ALL_AGES_LIST_CHILD
	advclass_cat_rolls = list(CTAG_TOWNER = 100)
	allowed_races = RACES_PLAYER_ALL
	can_have_apprentices = FALSE
	display_order = JDO_SHEPHERD
	selection_color = JCOLOR_INQUISITION
	faction = FACTION_TOWN
	shows_in_list = FALSE

/datum/job/villager/mole/after_spawn(mob/living/carbon/human/spawned, client/player_client)
	. = ..()
	ADD_TRAIT(spawned, TRAIT_INQMOLE, TRAIT_GENERIC)
	var/obj/item/storage/keyring/adept/L = new(get_turf(src))
	spawned.equip_to_appropriate_slot(L)
	to_chat(spawned, "<br><font color='#ff0000'><span class='bold'>I follow the orderes of the Inquisitor, and their sacresstants, Absolver too. I guess, why not.</span></font><br>")

/datum/job/advclass/orphan //This is for mule's orphan, Unlike regular orphans though, they have +1 in climbing and expert in Sneaking,  but they can't steal.
	title = "Orphan"
	tutorial = "Before you could even form words, you were abandoned, or perhaps lost. \
	Ever since, you have lived in the Orphanage under the Matron's care. \
	Will you make something of yourself, or will you die in the streets as a nobody?"
	category_tags = list(CTAG_TOWNER)
	outfit = /datum/outfit/muleorphan
	bypass_class_cat_limits = TRUE
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_CHILD)
	jobstats = list(
		STATKEY_INT = 2,
		STATKEY_CON = 1,
		STATKEY_END = 1,
	)

	skills = list(
		/datum/skill/craft/crafting = 2,
		/datum/skill/misc/athletics = 3,
		/datum/skill/misc/climbing = 5,
		/datum/skill/misc/sneaking = 4,
		/datum/skill/misc/reading = 1,
	)
	traits = list(
        TRAIT_ORPHAN,
	)

/datum/outfit/muleorphan/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/storage/belt/pouch/coins/poor
	shirt = /obj/item/clothing/shirt/undershirt/colored/random
	pants = /obj/item/clothing/pants/tights/colored/random
	belt = /obj/item/storage/belt/leather/rope
	shoes = /obj/item/clothing/shoes/simpleshoes
	cloak = pick(/obj/item/clothing/cloak/half, /obj/item/clothing/cloak/half/colored/brown)
	head = pick(/obj/item/clothing/head/knitcap, /obj/item/clothing/head/bardhat, /obj/item/clothing/head/courtierhat, /obj/item/clothing/head/fancyhat)
	r_hand = pick(/obj/item/instrument/lute, /obj/item/instrument/accord, /obj/item/instrument/guitar, /obj/item/instrument/flute, /obj/item/instrument/hurdygurdy, /obj/item/instrument/viola)
