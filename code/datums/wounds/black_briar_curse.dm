#define INFECTION_DEATH (5 MINUTES)
#define INFECTION_LATE 0.6
#define INFECTION_MID 0.3
#define INFECTION_HIDDEN 0.1
#define INFECTION_NEXT_SPREAD_COOLDOWN INFECTION_DEATH * 0.05

#define INFECTION_ROOT_MAX INFECTION_DEATH
#define INFECTION_ROOT_LATE INFECTION_ROOT_MAX * INFECTION_LATE
#define INFECTION_ROOT_MID INFECTION_ROOT_MAX * INFECTION_MID

#define INFECTION_LIMB_MAX INFECTION_DEATH * INFECTION_LATE
#define INFECTION_LIMB_DISABLE INFECTION_LIMB_MAX * 0.8

// carbons only! this shit is mostly about limbs
/datum/wound/black_briar_curse
	category = "Disease"
	name = "umbrosal cordycepsis"
	desc = "Commonly referred to as the Black Biar curse."
	check_name = "<span class='briar'><B>BLACK BRIAR</B></span>"

	severity = WOUND_SEVERITY_BIOHAZARD
	sleep_healing = 0

	// this goes up every onlife. once the total reaches 30 MINUTES, you are dead. non-root infection contributes to the root, nasty.
	var/infection = 0
	// when it can try and infect a limb again, world.time + INFECTION_NEXT_SPREAD_COOLDOWN
	var/next_limb_infection

/datum/wound/black_briar_curse/get_check_name(mob/user)
	if(infection > INFECTION_HIDDEN * ((bodypart_owner.body_part & CHEST) ? INFECTION_ROOT_MAX : INFECTION_LIMB_MAX))
		return ..()

/datum/wound/black_briar_curse/can_apply_to_mob(mob/living/affected)
	. = ..()
	if(!. || !iscarbon(affected))
		return
	return affected.getorganslot(ORGAN_SLOT_LUNGS) && !HAS_TRAIT(affected, TRAIT_TOXIMMUNE)

/datum/wound/black_briar_curse/can_stack_with(datum/wound/other)
	if(istype(other, type))
		var/datum/wound/black_briar_curse/O = other
		O.infection += ((bodypart_owner.body_part & CHEST) ? INFECTION_ROOT_MAX : INFECTION_LIMB_MAX) * 0.01
		return FALSE
	return TRUE

/datum/wound/black_briar_curse/has_special_infection()
	return bodypart_owner.body_part & CHEST

/datum/wound/black_briar_curse/on_mob_gain(mob/living/affected)
	. = ..()
	var/obj/item/bodypart/chest/chest = owner.get_bodypart(BODY_ZONE_CHEST)
	if(chest && !chest.has_wound(type))
		// we just got added and there's no root? let's move to the chest then and become it.
		if(infection)
			infection = min(infection, INFECTION_LIMB_MAX * INFECTION_HIDDEN)
		apply_to_bodypart(chest, TRUE)

/datum/wound/black_briar_curse/on_mob_loss(mob/living/affected)
	. = ..()
	if(bodypart_owner?.body_part & CHEST)
		REMOVE_TRAIT(affected, TRAIT_IMMOBILIZED, "[type]")
		affected.remove_movespeed_modifier(MOVESPEED_ID_BLACK_BRIAR)
		//kill all the tumors
		for(var/datum/wound/black_briar_curse/tumor in affected.get_wounds())
			if(tumor == src)
				continue
			tumor.whp = 0
			tumor.heal_wound(1)

/datum/wound/black_briar_curse/on_life()
	. = ..()
	var/max_infection = (bodypart_owner.body_part & CHEST) ? INFECTION_ROOT_MAX : INFECTION_LIMB_MAX
	infection = clamp(infection + rand(20, 25) - owner.STAEND, 0, max_infection)
	var/infection_percent = min(infection / max_infection, 1) // this shouldnt actually happen but there might be a rounding error at some point
	//basically what we're doing is forcing an inverse multiplicative graph to actually land where we want it to on the max pain.
	//so we take the inverse of the function and run our pain against it, which is currently 40, and that is our offset from 1
	//if someone ends up tweaking it for balance this will be very annoying to actually understand
	var/woundpain_inverse = (1 - INFECTION_HIDDEN) / (1 + 40)
	//the pain should roughly start just a little bit after the infection is no longer hidden
	//because we really don't wanna overshoot somehow and get an undefined number we're gonna give a .001 bump
	woundpain = max(0, (1 - INFECTION_HIDDEN) / (1.001 + woundpain_inverse - infection_percent) - 1)

	switch(bodypart_owner.body_zone)
		if(BODY_ZONE_HEAD)
			if(infection_percent > INFECTION_HIDDEN && prob(2 * infection_percent))
				owner.blur_eyes(rand(3, 6))
		if(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
			if(infection > INFECTION_LIMB_DISABLE ^ disabling)
				disabling = TRUE ^ disabling
				bodypart_owner.update_disabled()
		if(BODY_ZONE_CHEST) // root/chest. This should be the only one assigning traits, movespeed mods, etc. It'll be a pain in the ass to track otherwise.
			owner.adjust_energy((owner.STAEND - 20) * infection_percent)
			var/list/uninfected_bodyparts = list(BODY_ZONE_HEAD, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
			var/mob/living/carbon/C = owner
			var/total_infection = 0
			var/slowdown = 0
			for(var/datum/wound/black_briar_curse/tumor in owner.get_wounds())
				uninfected_bodyparts -= tumor.bodypart_owner.body_zone
				total_infection += tumor.infection
				if(tumor.bodypart_owner.body_part & LEGS)
					slowdown += tumor.infection

			if(slowdown)
				var/immobilizing = HAS_TRAIT_FROM(owner, TRAIT_IMMOBILIZED, "[type]")
				if(slowdown >= (INFECTION_LIMB_DISABLE * 2) && !HAS_TRAIT(owner, TRAIT_NO_IMMOBILIZE))
					if(!immobilizing)
						ADD_TRAIT(owner, TRAIT_IMMOBILIZED, "[type]")
				else if(immobilizing)
					REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, "[type]")
				slowdown /= INFECTION_LIMB_MAX * owner.num_legs
				owner.add_movespeed_modifier(MOVESPEED_ID_BLACK_BRIAR, multiplicative_slowdown = slowdown / (INFECTION_LIMB_MAX * owner.num_legs), override = TRUE)
			else
				owner.remove_movespeed_modifier(MOVESPEED_ID_BLACK_BRIAR)


			to_chat(owner, "[total_infection / 10] - [total_infection / INFECTION_DEATH * 100]%")

			if(total_infection > INFECTION_ROOT_LATE)
				owner.apply_status_effect(/datum/status_effect/debuff/black_briar2)
			else
				owner.remove_status_effect(/datum/status_effect/debuff/black_briar2)
			if(total_infection > INFECTION_ROOT_MID)
				owner.apply_status_effect(/datum/status_effect/debuff/black_briar1)
				if(world.time > next_limb_infection && prob(4))
					var/obj/item/bodypart/BP = C.get_bodypart_complex(uninfected_bodyparts)
					BP?.add_wound(type, TRUE)
					next_limb_infection = world.time + INFECTION_NEXT_SPREAD_COOLDOWN
			else
				owner.remove_status_effect(/datum/status_effect/debuff/black_briar1)
				var/_emote = pick("yawn", "cough", "clearthroat")
				if(prob(0.5))
					owner.emote(_emote, forced = TRUE)


#undef INFECTION_LIMB_DISABLE
#undef INFECTION_LIMB_MAX

#undef INFECTION_ROOT_MID
#undef INFECTION_ROOT_LATE
#undef INFECTION_ROOT_MAX

#undef INFECTION_NEXT_SPREAD_COOLDOWN
#undef INFECTION_HIDDEN
#undef INFECTION_MID
#undef INFECTION_LATE
#undef INFECTION_DEATH
