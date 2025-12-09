/datum/round_event_control/antagonist/solo/zizo_cult
	name = "Zizo Cult"
	tags = list(
		TAG_ZIZO,
		TAG_COMBAT,
		TAG_VILLAIN,
	)
	roundstart = TRUE
	antag_flag = ROLE_ZIZOIDCULTIST
	shared_occurence_type = SHARED_HIGH_THREAT

	base_antags = 1
	maximum_antags = 4

	min_players = 35
	weight = 6

	earliest_start = 0 SECONDS

	typepath = /datum/round_event/antagonist/solo/zizo_cultist
	antag_datum = /datum/antagonist/zizocultist

	restricted_roles = list(
		/datum/job/lord,
		/datum/job/consort,
		/datum/job/priest,
		/datum/job/advclass/hand,
		/datum/job/captain,
		/datum/job/advclass/heir,
		/datum/job/advclass/puritan,
		/datum/job/absolver,
		/datum/job/advclass/sacrestant,
		/datum/job/advclass/adept,
		/datum/job/forestwarden,
		/datum/job/advclass/royalknight,
		/datum/job/templar,
	)

/datum/round_event/antagonist/solo/zizo_cultist
	var/leader = FALSE

/datum/round_event/antagonist/solo/zizo_cultist/add_datum_to_mind(datum/mind/antag_mind)
	if(!leader)
		antag_mind.add_antag_datum(/datum/antagonist/zizocultist/leader)
		leader = TRUE
	else
		antag_mind.add_antag_datum(antag_datum)
