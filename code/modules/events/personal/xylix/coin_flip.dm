/datum/round_event_control/xylix_gamble
	name = "Xylix's Game"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/xylix_gamble
	weight = 7
	earliest_start = 10 MINUTES
	max_occurrences = 1
	min_players = 15

	tags = list(
		TAG_XYLIX,
		TAG_GAMBLE,
		TAG_TRICKERY,
	)

/datum/round_event_control/xylix_gamble/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	return GLOB.patron_follower_counts[/datum/patron/divine/xylix::name] > 0

/datum/round_event/xylix_gamble/start()
	var/list/valid_targets = player_humans_by_patron(/datum/patron/divine/xylix)

	if(!length(valid_targets))
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/personal/coin_flip/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	bordered_message(chosen_one, list(
		span_userdanger("YOU ARE XYLIX'S CHOSEN!"),
		span_notice("Xylix challenges you to a game! Simply flip a zenar and let fate decide your reward! Win the game, and Xylix's favor is yours. Lose, and your zenar is forfeit!"),
	))
	chosen_one.playsound_local(chosen_one, 'sound/misc/gods/xylix_omen_male_female.ogg', 100)

	chosen_one.mind.announce_personal_objectives()
