/datum/job/south/general
	title = "Confederate General"
	tutorial = "You are a General in the Confederate Army. You command the forces of the \
	South, leading your men into battle against the Union forces. Your strategic mind and \
	leadership skills are crucial to defending Southern independence."
	department_flag = SOUTH
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_CONFEDERATE_GENERAL
	faction = FACTION_SOUTH
	total_positions = 1
	spawn_positions = 1
	bypass_lastclass = TRUE
	job_bitflag = BITFLAG_SOUTH


	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/south/general
	advclass_cat_rolls = list(CTAG_SOUTH = 20)
	give_bank_account = 50

	exp_type = list(EXP_TYPE_LIVING)
	exp_types_granted = list(EXP_TYPE_SOUTH, EXP_TYPE_COMBAT)
	exp_requirements = list(
		EXP_TYPE_LIVING = 500
	)

/datum/outfit/south/general/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.set_skillrank(/datum/skill/combat/firearms, SKILL_LEVEL_JOURNEYMAN, TRUE)

/datum/job/south/lieutenant
	title = "Confederate Lieutenant"
	tutorial = "You are a Lieutenant in the Confederate Army. You serve under the General, \
	leading smaller units into battle and executing strategic orders. Your experience and \
	tactical knowledge make you a valuable officer in the fight for Southern independence."
	department_flag = SOUTH
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_CONFEDERATE_LIEUTENANT
	faction = FACTION_SOUTH
	total_positions = 3
	spawn_positions = 3
	bypass_lastclass = TRUE

	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/south/lieutenant
	advclass_cat_rolls = list(CTAG_SOUTH = 20)
	give_bank_account = 40

	exp_type = list(EXP_TYPE_LIVING)
	exp_types_granted = list(EXP_TYPE_SOUTH, EXP_TYPE_COMBAT)
	exp_requirements = list(
		EXP_TYPE_LIVING = 300
	)

/datum/outfit/south/lieutenant/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.set_skillrank(/datum/skill/combat/firearms, SKILL_LEVEL_JOURNEYMAN, TRUE)

/datum/job/south/sergeant
	title = "Confederate Sergeant"
	tutorial = "You are a Sergeant in the Confederate Army. You lead squads of Privates \
	into battle, maintaining discipline and ensuring orders are followed. Your combat \
	experience and leadership keep your men alive on the battlefield."
	department_flag = SOUTH
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_CONFEDERATE_SERGEANT
	faction = FACTION_SOUTH
	total_positions = 5
	spawn_positions = 5
	bypass_lastclass = TRUE

	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/south/sergeant
	advclass_cat_rolls = list(CTAG_SOUTH = 20)
	give_bank_account = 30

	exp_type = list(EXP_TYPE_LIVING)
	exp_types_granted = list(EXP_TYPE_SOUTH, EXP_TYPE_COMBAT)
	exp_requirements = list(
		EXP_TYPE_LIVING = 200
	)

/datum/outfit/south/sergeant/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.set_skillrank(/datum/skill/combat/firearms, SKILL_LEVEL_JOURNEYMAN, TRUE)

/datum/job/south/private
	title = "Confederate Private"
	tutorial = "You are a Private in the Confederate Army. You are a common soldier \
	fighting for Southern independence. Follow orders, fight bravely, and support your \
	fellow soldiers in the struggle against the Union."
	department_flag = SOUTH
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_CONFEDERATE_PRIVATE
	faction = FACTION_SOUTH
	total_positions = 10
	spawn_positions = 10
	bypass_lastclass = TRUE

	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/south/private
	advclass_cat_rolls = list(CTAG_SOUTH = 20)
	give_bank_account = 20

	exp_type = list(EXP_TYPE_LIVING)
	exp_types_granted = list(EXP_TYPE_SOUTH, EXP_TYPE_COMBAT)
	exp_requirements = list(
		EXP_TYPE_LIVING = 100
	)

/datum/outfit/south/private/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.set_skillrank(/datum/skill/combat/firearms, SKILL_LEVEL_JOURNEYMAN, TRUE)

/datum/job/south/doctor
	title = "Confederate Doctor"
	tutorial = "You are a Doctor serving with the Confederate Army. You tend to the \
	wounded and sick, saving lives on and off the battlefield. Your medical skills are \
	essential to keeping the Confederate forces fighting fit."
	department_flag = SOUTH
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_CONFEDERATE_DOCTOR
	faction = FACTION_SOUTH
	total_positions = 2
	spawn_positions = 2
	bypass_lastclass = TRUE

	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/south/doctor
	advclass_cat_rolls = list(CTAG_SOUTH = 20)
	give_bank_account = 35

	exp_type = list(EXP_TYPE_LIVING)
	exp_types_granted = list(EXP_TYPE_SOUTH, EXP_TYPE_COMBAT)
	exp_requirements = list(
		EXP_TYPE_LIVING = 250
	)

/datum/outfit/south/doctor/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.set_skillrank(/datum/skill/combat/firearms, SKILL_LEVEL_JOURNEYMAN, TRUE)

