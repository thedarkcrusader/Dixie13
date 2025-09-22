/datum/advclass/wretch/necromancer
	name = "Necromancer"
	tutorial = "You have been ostracized and hunted by society for your dark deeds and perversion of life. \
	As if those fools could stop you with your newfound powers!"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL
	outfit = /datum/outfit/job/wretch/necromancer
	category_tags = list(CTAG_WRETCH)
	cmode_music = 'sound/music/cmode/adventurer/CombatSorcerer.ogg'
	maximum_possible_slots = 1

/datum/outfit/job/wretch/necromancer/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(20))//20% chance to have bandit mage music
		H.cmode_music = 'sound/music/cmode/antag/CombatRogueMage.ogg'
	if(prob(1))//1% chance to have the evil wizard music
		H.cmode_music = 'sound/music/cmode/antag/combat_evilwizard.ogg'
	H.set_patron(/datum/patron/inhumen/zizo) //Zizo only, obviously.
	H.mind.current.faction += FACTION_CABAL
	H.mana_pool?.intrinsic_recharge_sources &= ~MANA_ALL_LEYLINES
	H.mana_pool?.set_intrinsic_recharge(MANA_SOULS)
	H.mana_pool?.ethereal_recharge_rate += 0.1

	shirt = /obj/item/clothing/armor/gambeson
	shoes = /obj/item/clothing/shoes/boots
	beltr = /obj/item/storage/magebag/poor
	beltl = /obj/item/storage/belt/pouch/coins/poor
	belt = /obj/item/storage/belt/leather/black
	backl = /obj/item/storage/backpack/satchel
	gloves = /obj/item/clothing/gloves/leather
	r_hand = /obj/item/weapon/polearm/woodstaff
	backpack_contents = list(
		/obj/item/book/granter/spellbook/adept = 1,
		/obj/item/chalk = 1,
		/obj/item/reagent_containers/glass/bottle/manapot = 1,
		/obj/item/reagent_containers/glass/bottle/healthpot = 1,
	)
	//combat
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)

	//athleticism and movement
	H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)

	//misc and crafting
	//they are given sewing and medicine because we can assume
	//they did some nasty stuff to corpses they robbed from graves
	H.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)

	//stats
	if(H.age == AGE_OLD)
		H.change_stat(STATKEY_SPD, -1)
		H.change_stat(STATKEY_INT, 1)
		H.adjust_spell_points(1)
	H.change_stat(STATKEY_END, -1)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_CON, -1)
	H.change_stat(STATKEY_INT, 4)
	H.adjust_spell_points(7)
	H.grant_language(/datum/language/undead)
	H.add_spell(/datum/action/cooldown/spell/eyebite)
	H.add_spell(/datum/action/cooldown/spell/projectile/sickness)
	H.add_spell(/datum/action/cooldown/spell/conjure/raise_lesser_undead/necromancer)
	H.add_spell(/datum/action/cooldown/spell/gravemark)

	//traits
	ADD_TRAIT(H, TRAIT_CABAL, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)

/datum/outfit/job/wretch/necromancer/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	var/static/list/selectablehat = list(
		"Ominous Hood (skullcap)" = /obj/item/clothing/head/helmet/skullcap/cult,
		"Witch hat" = /obj/item/clothing/head/wizhat/witch,
		"Wizard hat" = /obj/item/clothing/head/wizhat,
		"Mage hood" = /obj/item/clothing/head/roguehood/colored/mage,
	)
	H.select_equippable(H, selectablehat, message = "Choose your wizard hat of choice", title = "NECROMANCER")
	var/static/list/selectablerobe = list(
		"Necromancer robes (DOESNT SHOW UP ON CERTAIN RACES/GENDERS)" = /obj/item/clothing/shirt/robe/necromancer,
		"Black robes" = /obj/item/clothing/shirt/robe/colored/black,
		"Mage robes" = /obj/item/clothing/shirt/robe/colored/mage,
	)
	H.select_equippable(H, selectablerobe, message = "Choose your robe of choice", title = "NECROMANCER")
	to_chat(H, span_info("You recharge mana by consuming souls. Use Arcyne Eye to see them."))
	wretch_select_bounty(H)
