/datum/surgery_step/heart_stab
	name = "Spear Heart"
	implements = list(
		TOOL_SCALPEL = 65,
		TOOL_SHARP = 50,
	)
	possible_locs = list(
		BODY_ZONE_CHEST,
	)
	skill_used = /datum/skill/combat/knives
	time = 20 SECONDS
	surgery_flags = SURGERY_BLOODY
	skill_min = SKILL_LEVEL_APPRENTICE
	skill_median = SKILL_LEVEL_JOURNEYMAN
	preop_sound = 'sound/surgery/scalpel1.ogg'
	success_sound = 'sound/surgery/organ2.ogg'

/datum/surgery_step/heart_stab/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, "<span class='notice'>I line up my strike on [target]'s [parse_zone(target_zone)]...</span>",
		"<span class='notice'>[user] lines up a stab on [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>[user] lines up a stab on [target]'s [parse_zone(target_zone)].</span>")
	return TRUE

/datum/surgery_step/heart_stab/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, "<span class='notice'>Blood spews from puncture in [target]'s heart!</span>",
		"<span class='notice'>Blood spews from the puncture in [target]'s heart!</span>")
	var/obj/item/bodypart/gotten_part = target.get_bodypart(check_zone(target_zone))
	if(gotten_part)
		gotten_part.add_wound(/datum/wound/artery/chest)
		gotten_part.add_wound(/datum/wound/fracture/chest)
	return TRUE
