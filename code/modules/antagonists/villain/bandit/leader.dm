
/datum/antagonist/bandit/leader
	name = "Bandit Leader"
	roundend_category = "bandits"
	antagpanel_category = "Bandit"
	job_rank = ROLE_BANDITLEAD
	antag_hud_type = ANTAG_HUD_BANDIT
	antag_hud_name = "banditlead"
	var/tri_amt
	var/contrib
	antag_flags = FLAG_ANTAG_CAP_IGNORE
	confess_lines = list("I BRING THEM FREEDOM!!!", "WE WILL NOT LIVE IN YOUR WALLS!", "I AM WHY YOU CLUTCH YOUR POUCH!")

	innate_traits = list(
		TRAIT_BANDITCAMP,
		TRAIT_SEEPRICES,
		TRAIT_STEELHEARTED,
		TRAIT_VILLAIN,
	)

/datum/antagonist/bandit/leader/examine_friendorfoe(datum/antagonist/examined_datum, mob/examiner, mob/examined)
	if(istype(examined_datum, /datum/antagonist/bandit))
		if(examiner.real_name in GLOB.outlawed_players)
			if(examined.real_name in GLOB.outlawed_players)
				return span_boldnotice("One of the Free men, useful.")
			else
				return span_boldnotice("Pardoned free man?! [examined.p_them()] is a traitor, they've turned their back on me!")
		else if(examined.real_name in GLOB.outlawed_players)
			return span_boldnotice("Free man still on the run. Doomed without me.")
		else
			return span_boldnotice("One of mine, perhaps not so dumb as to stay on a poster.")

/datum/antagonist/bandit/on_gain()
	owner.special_role = "Bandit Leader"
	owner.current?.purge_combat_knowledge()
	move_to_spawnpoint()
	owner.current.roll_mob_stats()
	forge_objectives()
	. = ..()
	finalize_bandit()
	equip_bandit()
	addtimer(CALLBACK(owner.current, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "BANDIT"), 5 SECONDS)

/datum/antagonist/bandit/proc/finalize_bandit()
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/traitor.ogg', 80, FALSE, pressure_affected = FALSE)
	var/mob/living/carbon/human/H = owner.current
	H.set_patron(/datum/patron/inhumen/matthios)

/datum/antagonist/bandit/leader/greet()
	to_chat(owner.current, span_alertsyndie("I am Leader of the Bandits!"))
	to_chat(owner.current, span_info("I've led this raggedy group for quite some time it's because of me that they're alive at this point, but without them I'd be dead too."))
	owner.announce_objectives()
	..()

/datum/antagonist/bandit/proc/forge_objectives()
	return

/proc/isbandit(mob/living/M)
	return istype(M) && M.mind && M.mind.has_antag_datum(/datum/antagonist/bandit)

/datum/antagonist/bandit/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.bandit_starts))

/datum/antagonist/bandit/proc/equip_bandit()

	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds())
		owner.become_unknown_to(MF)
	for(var/datum/mind/MF in get_minds("Bandit"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)

	return TRUE

/datum/antagonist/bandit/roundend_report()
	if(owner?.current)
		var/amt = tri_amt
		var/the_name = owner.name
		if(ishuman(owner.current))
			var/mob/living/carbon/human/H = owner.current
			the_name = H.real_name
		if(!amt)
			to_chat(world, "[the_name] was a bandit.")
		else
			to_chat(world, "[the_name] was a bandit. He stole [amt] triumphs worth of loot.")
	return
