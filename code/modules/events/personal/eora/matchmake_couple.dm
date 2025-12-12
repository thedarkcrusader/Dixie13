/datum/round_event_control/eora_marriage
	name = "Marriage Broker"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/eora_marriage
	weight = 7
	earliest_start = 15 MINUTES
	max_occurrences = 1
	min_players = 35

	tags = list(
		TAG_EORA,
		TAG_BOON,
		TAG_WIDESPREAD,
	)

/datum/round_event_control/eora_marriage/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	return GLOB.patron_follower_counts[/datum/patron/divine/eora::name] > 0

/datum/round_event/eora_marriage/start()
	var/list/valid_targets = player_humans_by_patron(/datum/patron/divine/eora)

	if(!length(valid_targets))
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/personal/marriage_broker/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	bordered_message(chosen_one, list(
		span_userdanger("YOU ARE EORA'S CHOSEN!"),
		span_notice("Eora wishes to see love blossom! Arrange a marriage between any two people to earn Eora's favor!"),
	))
	to_chat(chosen_one, span_notice("You were given a power to conduct secret marriage ceremonies outside of the chapel. Let nothing stand in the way of true love!"))
	chosen_one.playsound_local(chosen_one, 'sound/vo/female/gen/giggle (1).ogg', 100)

	chosen_one.mind.announce_personal_objectives()
