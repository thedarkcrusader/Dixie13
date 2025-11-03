
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

/datum/surgery_step/heart_stab/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
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
