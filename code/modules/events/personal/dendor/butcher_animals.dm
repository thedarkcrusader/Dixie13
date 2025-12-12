/datum/round_event_control/butcher_animals
	name = "Predator's Duty"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/butcher_animals
	weight = 10
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 20

	tags = list(
		TAG_DENDOR,
		TAG_NATURE,
		TAG_BLOOD,
	)

/datum/round_event_control/butcher_animals/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE
	return GLOB.patron_follower_counts[/datum/patron/divine/dendor::name] > 0

/datum/round_event/butcher_animals/start()
	var/list/valid_targets = player_humans_by_patron(/datum/patron/divine/dendor)
	if(!length(valid_targets))
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/personal/butcher_animals/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	bordered_message(chosen_one, list(
		span_userdanger("YOU ARE DENDOR'S CHOSEN!"),
		span_notice("Predators must hunt the weak and old, clearing the way for a new generation. Such is nature. Butcher animals to enforce this order!"),
	))
	chosen_one.playsound_local(chosen_one, 'sound/magic/barbroar.ogg', 100)

	chosen_one.mind.announce_personal_objectives()
