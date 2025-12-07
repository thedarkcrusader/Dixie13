/datum/round_event_control/antagonist/solo/werewolf
	name = "Verevolfs"
	tags = list(
		TAG_DENDOR,
		TAG_GRAGGAR,
		TAG_COMBAT,
		TAG_HAUNTED,
		TAG_VILLAIN,
	)
	roundstart = TRUE
	antag_flag = ROLE_WEREWOLF
	shared_occurence_type = SHARED_HIGH_THREAT

	denominator = 55

	base_antags = 1
	maximum_antags = 2

	weight = 12

	earliest_start = 0 SECONDS
	min_players = 45

	typepath = /datum/round_event/antagonist/solo/werewolf
	antag_datum = /datum/antagonist/werewolf

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
		/datum/job/merchant,
		/datum/job/forestwarden,
		/datum/job/advclass/royalknight,
		/datum/job/templar,
	)

/datum/round_event/antagonist/solo/werewolf
