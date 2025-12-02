/datum/job/banditlead //pysdon above there's like THREE bandit.dms now I'm so sorry. This one is latejoin bandits, the one in villain is the antag datum, and the one in the 'antag' folder is an old adventurer class we don't use. Good luck!
	title = "Bandit Leader"
	tutorial = "You've led this raggedy group for quite some time \
	it's because of you that they're alive at this point but without them you'd be dead too. \
	You've steeled yourself at this point, more money, more infamy. It's all you're living for."
	department_flag = OUTSIDERS
	job_flags = (JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE | JOB_SHOW_IN_CREDITS)
	display_order = JDO_BANDITLEAD
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	blacklisted_species = list(SPEC_ID_KOBOLD, SPEC_ID_HALF_ORC, SPEC_ID_TIEFLING) // The leader's got some infamy, also been around awhile, no short-lived species
	spells = list(
		/datum/action/cooldown/spell/undirected/bandit_call,
	)
	faction = FACTION_NEUTRAL
	total_positions = 1
	spawn_positions = 1
	min_pq = 10
	antag_job = TRUE

	advclass_cat_rolls = list(CTAG_BANDITLEAD = 20)

	is_foreigner = TRUE
	job_reopens_slots_on_death = FALSE //no endless stream of bandits, unless the migration waves deem it so
	same_job_respawn_delay = 30 MINUTES

	can_have_apprentices = FALSE
	cmode_music = 'sound/music/cmode/antag/combat_bandit2.ogg'

	traits = list(TRAIT_NOAMBUSH)

	antag_role = /datum/antagonist/bandit/leader

/datum/job/banditlead/after_spawn(mob/living/carbon/spawned, client/player_client)
	..()
	spawned.add_spell(/datum/action/cooldown/spell/undirected/bandit_call)
