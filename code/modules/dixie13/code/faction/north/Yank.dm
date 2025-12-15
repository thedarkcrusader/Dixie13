/datum/job/north/general
	title = "Union General"
	tutorial = "You are a General in the Union Army. You command the forces of the North, \
	leading your men into battle against the Confederate forces. Your strategic mind and \
	leadership skills are crucial to the war effort."
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_UNION_GENERAL
	faction = FACTION_NORTH
	total_positions = 1
	spawn_positions = 1
	bypass_lastclass = TRUE

	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/north/general
	advclass_cat_rolls = list(CTAG_GARRISON = 20)
	give_bank_account = 50

	exp_type = list(EXP_TYPE_LIVING)
	exp_types_granted = list(EXP_TYPE_GARRISON, EXP_TYPE_COMBAT)
	exp_requirements = list(
		EXP_TYPE_LIVING = 500
	)

/datum/outfit/north/general/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.set_skillrank(/datum/skill/combat/firearms, SKILL_LEVEL_JOURNEYMAN, TRUE)

/datum/job/north/lieutenant
	title = "Union Lieutenant"
	tutorial = "You are a Lieutenant in the Union Army. You serve under the General, \
	leading smaller units into battle and executing strategic orders. Your experience \
	and tactical knowledge make you a valuable officer."
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_UNION_LIEUTENANT
	faction = FACTION_NORTH
	total_positions = 3
	spawn_positions = 3
	bypass_lastclass = TRUE

	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/north/lieutenant
	advclass_cat_rolls = list(CTAG_GARRISON = 20)
	give_bank_account = 40

	exp_type = list(EXP_TYPE_LIVING)
	exp_types_granted = list(EXP_TYPE_GARRISON, EXP_TYPE_COMBAT)
	exp_requirements = list(
		EXP_TYPE_LIVING = 300
	)

/datum/outfit/north/lieutenant/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.set_skillrank(/datum/skill/combat/firearms, SKILL_LEVEL_JOURNEYMAN, TRUE)

/datum/job/north/sergeant
	title = "Union Sergeant"
	tutorial = "You are a Sergeant in the Union Army. You lead squads of Privates into \
	battle, maintaining discipline and ensuring orders are followed. Your combat experience \
	and leadership keep your men alive on the battlefield."
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_UNION_SERGEANT
	faction = FACTION_NORTH
	total_positions = 5
	spawn_positions = 5
	bypass_lastclass = TRUE

	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/north/sergeant
	advclass_cat_rolls = list(CTAG_GARRISON = 20)
	give_bank_account = 30

	exp_type = list(EXP_TYPE_LIVING)
	exp_types_granted = list(EXP_TYPE_GARRISON, EXP_TYPE_COMBAT)
	exp_requirements = list(
		EXP_TYPE_LIVING = 200
	)

/datum/outfit/north/sergeant/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.set_skillrank(/datum/skill/combat/firearms, SKILL_LEVEL_JOURNEYMAN, TRUE)

/datum/job/north/private
	title = "Union Private"
	tutorial = "You are a Private in the Union Army. You are a common soldier fighting \
	for the Union cause. Follow orders, fight bravely, and support your fellow soldiers \
	in the struggle against the Confederacy."
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_UNION_PRIVATE
	faction = FACTION_NORTH
	total_positions = 10
	spawn_positions = 10
	bypass_lastclass = TRUE

	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/north/private
	advclass_cat_rolls = list(CTAG_GARRISON = 20)
	give_bank_account = 20

	exp_type = list(EXP_TYPE_LIVING)
	exp_types_granted = list(EXP_TYPE_GARRISON, EXP_TYPE_COMBAT)
	exp_requirements = list(
		EXP_TYPE_LIVING = 100
	)

/datum/outfit/north/private/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.set_skillrank(/datum/skill/combat/firearms, SKILL_LEVEL_JOURNEYMAN, TRUE)

/datum/job/north/doctor
	title = "Union Doctor"
	tutorial = "You are a Doctor serving with the Union Army. You tend to the wounded \
	and sick, saving lives on and off the battlefield. Your medical skills are essential \
	to keeping the Union forces fighting fit."
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_UNION_DOCTOR
	faction = FACTION_NORTH
	total_positions = 2
	spawn_positions = 2
	bypass_lastclass = TRUE

	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/north/doctor
	advclass_cat_rolls = list(CTAG_GARRISON = 20)
	give_bank_account = 35

	exp_type = list(EXP_TYPE_LIVING)
	exp_types_granted = list(EXP_TYPE_GARRISON, EXP_TYPE_COMBAT)
	exp_requirements = list(
		EXP_TYPE_LIVING = 250
	)

/datum/outfit/north/doctor/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.set_skillrank(/datum/skill/combat/firearms, SKILL_LEVEL_JOURNEYMAN, TRUE)

