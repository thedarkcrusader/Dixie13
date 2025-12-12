/datum/round_event_control/dendor_taming
	name = "Taming Challenge"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/dendor_taming
	weight = 10
	earliest_start = 10 MINUTES
	max_occurrences = 1
	min_players = 15

	tags = list(
		TAG_DENDOR,
		TAG_NATURE,
	)

/datum/round_event_control/dendor_taming/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	return GLOB.patron_follower_counts[/datum/patron/divine/dendor::name] > 0

/datum/round_event/dendor_taming/start()
	var/list/valid_targets = player_humans_by_patron(/datum/patron/divine/dendor)

	if(!length(valid_targets))
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/personal/tame_animal/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	bordered_message(chosen_one, list(
		span_userdanger("YOU ARE DENDOR'S CHOSEN!"),
		span_notice("Dendor calls you to bond with the wild creatures! Tame an animal to earn Dendor's favor!"),
	))
	chosen_one.playsound_local(chosen_one, 'sound/magic/barbroar.ogg', 100)

	chosen_one.mind.announce_personal_objectives()
