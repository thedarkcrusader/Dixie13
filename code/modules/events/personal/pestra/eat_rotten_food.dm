/datum/round_event_control/pestra_rotten_feast
	name = "Rotten Feast"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/pestra_rotten_feast
	weight = 10
	earliest_start = 10 MINUTES
	max_occurrences = 1
	min_players = 20

	tags = list(
		TAG_PESTRA,
	)

/datum/round_event_control/pestra_rotten_feast/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	return GLOB.patron_follower_counts[/datum/patron/divine/pestra::name] > 0

/datum/round_event/pestra_rotten_feast/start()
	var/list/valid_targets = player_humans_by_patron(/datum/patron/divine/pestra)

	if(!length(valid_targets))
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/personal/rotten_feast/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	bordered_message(chosen_one, list(
		span_userdanger("YOU ARE PESTRA'S CHOSEN!"),
		span_notice("Everything can be reused. Consume rotten food to earn Pestra's favor!"),
	))
	chosen_one.playsound_local(chosen_one, 'sound/magic/cosmic_expansion.ogg', 100)

	chosen_one.mind.announce_personal_objectives()
