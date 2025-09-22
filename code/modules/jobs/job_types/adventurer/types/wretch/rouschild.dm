/datum/advclass/wretch/rouschild
	name = "Rouschild"
	tutorial = "A child of the sewers, abandoned at birth, \
	you were taken in by a colony of rous and raised as one of their own. \
	Living with your family has accustomed you to life in sewers and dank caves."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL
	outfit = /datum/outfit/job/wretch/rouschild
	category_tags = list(CTAG_WRETCH)
	cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'
	maximum_possible_slots = 2

/datum/outfit/job/wretch/rouschild
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/colored/brown
	mask = /obj/item/clothing/face/shepherd/clothmask
	armor = /obj/item/clothing/shirt/rags
	shirt = /obj/item/clothing/shirt/undershirt/colored/vagrant
	pants = /obj/item/clothing/pants/tights/colored/vagrant
	belt = /obj/item/storage/belt/leather/rope

/datum/outfit/job/wretch/rouschild/pre_equip(mob/living/carbon/human/H)
	..()
	//combat
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)

	//foraging skills basically
	H.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)

	//very athletic, rats can swim well, climbing because... well they live in sewers
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)

	//misc, very high taming so they can reliably tame rous and perhaps other creachers too
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/taming, 5, TRUE)

	//stats
	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_SPD, 2)
	H.change_stat(STATKEY_PER, -2)//lived in the dark all their life possibly
	H.change_stat(STATKEY_INT, -3)

	//spells
	H.add_spell(/datum/action/cooldown/spell/conjure/rous)
	H.add_spell(/datum/action/cooldown/spell/undirected/conjure_item/rat)

	//traits
	ADD_TRAIT(H, TRAIT_DARKVISION, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NASTY_EATER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LIGHT_STEP, TRAIT_GENERIC)

	H.faction = list(FACTION_RATS)


/datum/outfit/job/wretch/rouschild/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	wretch_select_bounty(H)

