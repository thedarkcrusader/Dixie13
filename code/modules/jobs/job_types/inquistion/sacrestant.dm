/datum/job/sacrestant
	title = "Sacrestant"
	tutorial = "\
	You are a student of the Oratorium in training to become a full Inquisitor. \
	You have come here under the stern gaze of the Herr Prafekt to prove your wits and skill. \
	This is the week. The week of the Iter Maledictum. \
	The last exam to determine whether or not you may become an Inquisitor. And only one of you may succeed.\
	There can be only one."
	//https://www.youtube.com/watch?v=sqcLjcSloXs
	department_flag = INQUISITION
	faction = FACTION_TOWN
	total_positions = 3
	spawn_positions = 3
	allowed_races = RACES_PLAYER_INQ
	bypass_lastclass = TRUE
	cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'
	allowed_patrons = list(
		/datum/patron/psydon
	)

	selection_color = JCOLOR_INQUISITION

	outfit = null
	outfit_female = null


	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_ORTHODOXIST
	min_pq = 0
	//PQ locks were removed in favour of timelocks

	advclass_cat_rolls = list(CTAG_INQUISITION = 20)
	same_job_respawn_delay = 30 MINUTES
	antag_role = /datum/antagonist/inquisition

	languages = list(/datum/language/oldpsydonic)

/datum/job/sacrestant/after_spawn(mob/living/carbon/human/spawned, client/player_client)
	. = ..()

	spawned.verbs |= /mob/living/carbon/human/proc/torture_victim
	spawned.verbs |= /mob/living/carbon/human/proc/faith_test
	spawned.verbs |= /mob/living/carbon/human/proc/view_inquisition

	spawned.hud_used?.shutdown_bloodpool()
	spawned.hud_used?.initialize_bloodpool()
	spawned.hud_used?.bloodpool.set_fill_color("#dcdddb")
	spawned.hud_used?.bloodpool?.name = "Psydon's Grace: [spawned.bloodpool]"
	spawned.hud_used?.bloodpool?.desc = "Devotion: [spawned.bloodpool]/[spawned.maxbloodpool]"
	spawned.maxbloodpool = 1000

	var/datum/species/species = spawned.dna?.species
	if(species)
		species.native_language = "Old Psydonic"
		species.accent_language = species.get_accent(species.native_language)
