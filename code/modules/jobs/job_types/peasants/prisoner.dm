/datum/job/prisoner
	title = "Prisoner"
	tutorial = "You are scum, and you am unrepentant about it. Cursed to rot in this cold mask, you live well-beneath \
	the castle walls of the nobility. You hear the festivities at night as the chains around your wrists chafe the skin, \
	casting blood from your body, and the flies and maggots eat at the decaying chunks of flesh. You've tried - God knows you have, \
	but you can never shake your captors. Your brothers believing you dead, your only predictable and inevitable fate is to \
	run through the tomb of your god like a rat, to seek riches for your captors. Your life should have ended at the noose, \
	and yet this is how you die. There's no point in running. Drink death and descend."
	department_flag = PEASANTS
	display_order = JDO_PRISONER
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 0
	spawn_positions = 4 // It's a full party of dungeon rats. God help them all.
	min_pq = -100
	can_random = FALSE
	banned_leprosy = FALSE
	bypass_lastclass = TRUE

	allowed_races = RACES_PLAYER_FOREIGNNOBLE

	outfit = /datum/outfit/prisoner
	give_bank_account = 173

	cmode_music = 'sound/music/cmode/towner/CombatPrisoner.ogg'
	can_have_apprentices = FALSE

/datum/outfit/prisoner/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/pants/loincloth/colored/brown
	mask = /obj/item/clothing/face/facemask/prisoner
	if(H.wear_mask)
		var/obj/I = H.wear_mask
		H.dropItemToGround(H.wear_mask, TRUE)
		qdel(I)

	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE) // Don't give them much wrestling. If they act out, the dungeoneer needs to be able to beat the shit out of em.
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE) // They'll probably level this up as the round goes on.
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.set_patron(/datum/patron/inhumen/matthios)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_END, -1)
	H.change_stat(STATKEY_CON, -1) // They have to work together to survive. These are their baseline advantages.
	var/datum/antagonist/new_antag = new /datum/antagonist/prisoner()
	H.mind?.add_antag_datum(new_antag)
	ADD_TRAIT(H, TRAIT_BANDITCAMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_PRISONER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

	var/prisarchetype = pickweight(list("Swords" = 3, "Polearms" = 3, "Maces" = 3, "Daggers" = 3, "Flails" = 2, "BERSERKERRR" = 2, "Unarmed" = 1,)) // Archetype roll!
	switch(prisarchetype)
		if("Swords")
			H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE) // All-rounder. Eh stabs minotaurs and doesn't afraid of anything.
			H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
			H.change_stat(STATKEY_INT, 1)
			H.change_stat(STATKEY_END, 1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			to_chat(H,span_info("\
			The sword is the weapon of kings. Ironic, that I tried to slay one with his own.")
			)
		if("Polearms")
			H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.change_stat(STATKEY_SPD, -1) // Big boy.
			H.change_stat(STATKEY_STR, 1)
			H.change_stat(STATKEY_END, 1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			to_chat(H,span_info("\
			Formations do not phase me. With my warhammer, I will break them down and slaughter their women.")
			)
		if("Maces")
			H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
			H.change_stat(STATKEY_SPD, -2) // Bigger boy.
			H.change_stat(STATKEY_STR, 1)
			H.change_stat(STATKEY_PER, -1)
			ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
			to_chat(H,span_info("\
			A noble threw me a false purse, once. I found him blabbering to the guards. I broke both their heads in with a cudgel.")
			)
		if("Daggers")
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			armor = /obj/item/clothing/armor/leather/jacket/sea
			H.change_stat(STATKEY_SPD, 2)
			H.change_stat(STATKEY_END, 2)
			H.change_stat(STATKEY_STR, -2)
			H.change_stat(STATKEY_CON, -1)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			to_chat(H,span_info("\
			Murder is the mark of an amateur... I beg to differ. Tell that to the man with a knife in his ribs.")
			)
		if("Flails")
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
			H.change_stat(STATKEY_SPD, -2)
			H.change_stat(STATKEY_END, 1)
			H.change_stat(STATKEY_CON, 1)
			ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
			to_chat(H,span_info("\
			I hear the air split with the rattle of my chains. Break your skull, shatter your spine!")
			)
		if("BERSERKERRR")
			H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			armor = /obj/item/clothing/armor/leather/hide/steppe // They REALLY need it.
			H.change_stat(STATKEY_END, 1)
			H.change_stat(STATKEY_CON, 3) // They spawn with -1 con, it's +2
			H.change_stat(STATKEY_PER, -3)
			H.change_stat(STATKEY_INT, -2)
			ADD_TRAIT(H, TRAIT_DUALWIELDER, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
			to_chat(H,span_info("\
			In my two hands I wield the key to your fate. Stand still, allow me to unlock your chest.")
			)
		if("Unarmed")
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			head = /obj/item/clothing/head/helmet/leather/headscarf
			H.change_stat(STATKEY_SPD, 2)
			H.change_stat(STATKEY_END, 2)
			H.change_stat(STATKEY_CON, 2)
			H.change_stat(STATKEY_STR, 2) // Rare roll, fuck it.
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
			to_chat(H,span_info("\
			I drowned a petty noble in his own bath. He squirmed, he cried, he begged. I washed the sins off of his soul that night... Fucking rich people.")
			)
