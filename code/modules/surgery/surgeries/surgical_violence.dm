/datum/surgery_step/throat_slit
	name = "Slit Throat"
	implements = list(
		TOOL_SHARP = 80,
		TOOL_SCALPEL = 80,
		TOOL_SAW = 65,
		TOOL_IMPROVISED_SAW = 50,
	)
	possible_locs = list(
		BODY_ZONE_PRECISE_NECK,
	)
	time = 7 SECONDS
	surgery_flags = SURGERY_INCISED | SURGERY_RETRACTED
	surgery_flags_blocked = SURGERY_BROKEN
	skill_min = SKILL_LEVEL_APPRENTICE
	skill_median = SKILL_LEVEL_JOURNEYMAN


	/datum/surgery_step/stab_heart
	name = "Spear Heart"
	time = 20 SECONDS
	accept_hand = FALSE
	implements = list(
		TOOL_SCALPEL = 80,
		TOOL_SHARP = 50,
	)

	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	surgery_flags = SURGERY_BLOODY
	skill_min = SKILL_LEVEL_JOURNEYMAN
	skill_median = SKILL_LEVEL_EXPERT
