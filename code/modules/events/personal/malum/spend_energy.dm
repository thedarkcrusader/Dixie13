/datum/round_event_control/spend_energy
	name = "Work Hard"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/spend_energy
	weight = 10
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 15

	tags = list(
		TAG_MALUM,
		TAG_WORK,
	)

/datum/round_event_control/spend_energy/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	return GLOB.patron_follower_counts[/datum/patron/divine/malum::name] > 0

/datum/round_event/spend_energy/start()
	var/list/valid_targets = player_humans_by_patron(/datum/patron/divine/malum)

	if(!length(valid_targets))
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/personal/energy_expenditure/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	bordered_message(chosen_one, list(
		span_userdanger("YOU ARE MALUM'S CHOSEN!"),
		span_notice("There is an honor in hard toil! Spend enough energy working to earn Malum's approval!"),
	))
	chosen_one.playsound_local(chosen_one, 'sound/magic/dwarf_chant01.ogg', 100)

	chosen_one.mind.announce_personal_objectives()
