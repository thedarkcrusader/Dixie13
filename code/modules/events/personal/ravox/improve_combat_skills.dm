/datum/round_event_control/ravox_combat
	name = "Get Stronger"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/ravox_combat
	weight = 10
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 15

	tags = list(
		TAG_RAVOX,
	)

/datum/round_event_control/ravox_combat/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	return GLOB.patron_follower_counts[/datum/patron/divine/ravox::name] > 0

/datum/round_event/ravox_combat/start()
	var/list/valid_targets = player_humans_by_patron(/datum/patron/divine/ravox)

	if(!length(valid_targets))
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/personal/improve_combat/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	bordered_message(chosen_one, list(
		span_userdanger("YOU ARE RAVOX'S CHOSEN!"),
		span_notice("Ravox demands you prove your might! Improve your combat skills to earn Ravox's favor!"),
	))
	chosen_one.playsound_local(chosen_one, 'sound/vo/male/knight/rage (6).ogg', 70)

	chosen_one.mind.announce_personal_objectives()
