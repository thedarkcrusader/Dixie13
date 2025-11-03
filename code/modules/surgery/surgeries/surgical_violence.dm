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
	surgery_flags = SURGERY_BLOODY
	skill_min = SKILL_LEVEL_APPRENTICE
	skill_median = SKILL_LEVEL_JOURNEYMAN
	preop_sound = 'sound/surgery/scalpel1.ogg'
	success_sound = 'sound/surgery/scalpel2.ogg'

/datum/surgery_step/incise/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, "<span class='notice'>I prepare to slash out [target]'s [parse_zone(target_zone)]...</span>",
		"<span class='notice'>[user] prepares to slash out [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>[user] prepares to slash out [target]'s [parse_zone(target_zone)].</span>")
	return TRUE

/datum/surgery_step/incise/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, "<span class='notice'>Blood drips from the slit in [target]'s throat!</span>",
		"<span class='notice'>Blood drips from the slit in [target]'s throat!</span>")
	var/obj/item/bodypart/gotten_part = target.get_bodypart(check_zone(target_zone))
	if(gotten_part)
		gotten_part.add_wound(/datum/wound/artery/neck)
	return TRUE

	/datum/surgery_step/heart_stab
	name = "Spear Heart"
	implements = list(
		TOOL_SHARP = 80,
		TOOL_SCALPEL = 80,

	)
	possible_locs = list(
		BODY_ZONE_CHEST,
	)
	time = 20 SECONDS
	surgery_flags = SURGERY_BLOODY
	skill_min = SKILL_LEVEL_JOURNEYMAN
	skill_median = SKILL_LEVEL_EXPERT
	preop_sound = 'sound/surgery/scalpel1.ogg'
	success_sound = 'sound/surgery/organ2.ogg'

	/datum/surgery_step/heart_stab/(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, "<span class='notice'>I begin to line up my strike on [target]'s [parse_zone(target_zone)]...</span>",
		"<span class='notice'>[user] begins to line up a stab on [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>[user] begins to line up a stab on [target]'s [parse_zone(target_zone)].</span>")
	return TRUE

/datum/surgery_step/saw/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, "<span class='notice'>I spear [target]'s heart!</span>",
		"<span class='notice'>[user] spears [target]'s [parse_zone(target_zone)] ! Blood sprays everywhere!</span>",
		"<span class='notice'>[user] spears [target]'s [parse_zone(target_zone)] ! Blood sprays everywhere!</span>")
	var/obj/item/bodypart/bodypart = target.get_bodypart(check_zone(target_zone))
	if(bodypart)
		var/fracture_type = /datum/wound/fracture
		//yes we ignore crit resist here because this is a proper surgical procedure, not a crit
		switch(bodypart.body_zone)
			if(BODY_ZONE_CHEST)
				fracture_type = /datum/wound/fracture/chest
		bodypart.add_wound(fracture_type)
		bodypart.add_wound(/datum/wound/artery/chest)
	target.emote("scream")
	return TRUE
