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
	skill_used = /datum/skill/combat/knives
	time = 7 SECONDS
	surgery_flags = SURGERY_BLOODY
	skill_min = SKILL_LEVEL_APPRENTICE
	skill_median = SKILL_LEVEL_JOURNEYMAN
	preop_sound = 'sound/surgery/scalpel1.ogg'
	success_sound = 'sound/surgery/scalpel2.ogg'

/datum/surgery_step/throat_slit/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, "<span class='notice'>I prepare to slash out [target]'s [parse_zone(target_zone)]...</span>",
		"<span class='notice'>[user] prepares to slash out [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>[user] prepares to slash out [target]'s [parse_zone(target_zone)].</span>")
	return TRUE

/datum/surgery_step/throat_slit/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, "<span class='notice'>Blood drips from the slit in [target]'s throat!</span>",
		"<span class='notice'>Blood drips from the slit in [target]'s throat!</span>")
	var/obj/item/bodypart/gotten_part = target.get_bodypart(check_zone(target_zone))
	if(gotten_part)
		gotten_part.add_wound(/datum/wound/artery/neck)
	return TRUE
