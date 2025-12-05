#define BBC_TIME_LATE 	0.7
#define BBC_TIME_MID	0.3
#define BBC_TIME_HIDDEN	0.1

#define BBC_TIME_MAX (60 MINUTES)
#define BBC_TIME_MAX_LIMB BBC_TIME_MAX * 0.5

// carbons only! this shit is mostly about limbs
/datum/wound/black_briar_curse
	abstract_type = (/datum/wound/black_briar_curse)

	category = "Disease"
	name = "umbrosal cordycepsis"
	desc = "Commonly referred to as the Black Briar curse."
	check_name = "<span class='briar'><B>BLACK BRIAR</B></span>"

	severity = WOUND_SEVERITY_BIOHAZARD
	sleep_healing = 0
	bleed_rate = null

	// the body zones this curse type targets
	var/list/body_zones
	// all of these instances of this in a body
	var/list/root_network

	var/max_infection = BBC_TIME_MAX_LIMB
	// this goes up every onlife. once the total reaches 30 MINUTES, you are dead. non-root infection contributes to the root, nasty.
	var/infection = 0
	var/infection_percent = 0
	// used to skip rebuilds when they're unnecessary
	var/can_rebuild = TRUE

/datum/wound/black_briar_curse/Destroy(force)
	. = ..()
	LAZYNULL(root_network)

/datum/wound/black_briar_curse/get_check_name(mob/user)
	if(infection > BBC_TIME_HIDDEN * max_infection)
		return ..()

/datum/wound/black_briar_curse/can_apply_to_bodypart(obj/item/bodypart/affected)
	. = ..()
	if(!(affected.body_zone in body_zones))
		return FALSE

/datum/wound/black_briar_curse/can_apply_to_mob(mob/living/affected)
	. = ..()
	if(!iscarbon(affected))
		return FALSE
	var/mob/living/carbon/human/C = affected
	if(C.dna?.species && (NOBLOOD in C.dna.species.species_traits))
		return FALSE
	return . && affected.getorganslot(ORGAN_SLOT_LUNGS) && !HAS_TRAIT(affected, TRAIT_TOXIMMUNE)

/datum/wound/black_briar_curse/can_stack_with(datum/wound/other)
	if(istype(other, /datum/wound/black_briar_curse))
		if(!(src in GLOB.primordial_wounds)) //idk why someone would be using these this way but i'd prefer not to build up its infection
			var/datum/wound/black_briar_curse/O = other
			O.infection = min(O.infection + O.max_infection * 0.05, O.max_infection)
			remove_immunity(owner)
		return FALSE
	return TRUE

/datum/wound/black_briar_curse/on_bodypart_gain(obj/item/bodypart/affected)
	. = ..()
	infection = min(infection, max_infection * BBC_TIME_HIDDEN)
	infection_percent = min(infection_percent, BBC_TIME_HIDDEN)

/datum/wound/black_briar_curse/on_mob_gain(mob/living/affected)
	. = ..()
	// you'd think we would want this in bodypart_gain but this calls last in all the procs so it won't screw things up
	if(bodypart_owner?.body_zone != BODY_ZONE_CHEST)
		var/obj/item/bodypart/chest/chest = owner.get_bodypart()
		if(istype(chest) && !chest.has_wound(/datum/wound/black_briar_curse/chest)) // we just got added and there's no root? let's make a chest wound instead.
			can_rebuild = FALSE
			var/datum/wound/black_briar_curse/chest/wound = chest.add_wound(/datum/wound/black_briar_curse/chest, TRUE)
			wound?.infection = min(infection, wound.max_infection * BBC_TIME_HIDDEN)
			wound?.infection_percent = min(infection_percent, BBC_TIME_HIDDEN)
			qdel(src)
			return
		remove_immunity(affected) // if we're just a new wound, delete that shit
	can_rebuild = TRUE
	rebuild_root_network(affected)

/datum/wound/black_briar_curse/on_mob_loss(mob/living/affected)
	. = ..()
	rebuild_root_network(affected)

/datum/wound/black_briar_curse/on_life()
	. = ..()
	// No, this will not correlate to dungeon or island waits. But it's expensive to check, so we're gonna deal with asynced rate.
	infection = clamp(infection + (rand(20, 25) - owner.STAEND) * (SSmobs.wait * 0.1) , 0, max_infection)
	infection_percent = min(infection / max_infection, 1)
	//basically what we're doing is forcing a multiplicative inverse function to actually land where we want it to on the max pain.
	//so we take the inverse of the function and run our pain against it, which is the second number, and that is our offset from 1
	//if someone ends up tweaking it for balance this will be very annoying to actually understand
	var/woundpain_inverse = (1 - BBC_TIME_HIDDEN) / (1 + 40)
	//the pain should roughly start just a little bit after the infection is no longer hidden
	//because we really don't wanna overshoot somehow and get an undefined number we're gonna give a .001 bump
	woundpain = max(0, (1 - BBC_TIME_HIDDEN) / (1.001 + woundpain_inverse - infection_percent) - 1)
	to_chat(owner, "[bodypart_owner.body_zone] - [round(infection / 10)] sec - [round(infection_percent * 100, 0.5)]%")

/datum/wound/black_briar_curse/proc/rebuild_root_network(mob/living/affected)
	if(!can_rebuild)
		return
	var/list/new_roots
	var/list/networked_tumors = list()
	for(var/datum/wound/black_briar_curse/tumor in affected.get_wounds())
		var/obj/item/bodypart/bp = tumor.bodypart_owner
		if(bp?.body_zone) // each tumor tries to grab its body zone
			var/datum/weakref/tumor_ref = LAZYACCESS(tumor.root_network, bp.body_zone)
			if(!tumor_ref?.resolve())
				tumor_ref = WEAKREF(tumor)
			LAZYSET(new_roots, tumor.bodypart_owner.body_zone, tumor_ref)
			networked_tumors += tumor
		LAZYNULL(tumor.root_network)
	for(var/datum/wound/black_briar_curse/tumor in networked_tumors)
		tumor.root_network = new_roots.Copy()

/// somehow you've triggered your immunity to get lost, like getting more stacks added to you
/datum/wound/black_briar_curse/proc/remove_immunity(mob/living/affected)
	var/list/was_immune = GET_TRAIT_SOURCES(affected, TRAIT_BLACK_BRIAR)
	if(was_immune)
		REMOVE_TRAIT(affected, TRAIT_BLACK_BRIAR, was_immune)


/datum/wound/black_briar_curse/chest
	//show_in_book = FALSE
	body_zones = list(BODY_ZONE_CHEST)
	max_infection = BBC_TIME_MAX
	// when it can try and infect a limb again, world.time + BBC_SPREAD_COOLDOWN
	var/next_limb_infection = 0

/datum/wound/black_briar_curse/chest/has_special_infection()
	return TRUE

/datum/wound/black_briar_curse/chest/on_mob_loss(mob/living/affected)
	. = ..()
	can_rebuild = FALSE
	for(var/datum/wound/black_briar_curse/tumor in affected.get_wounds()) // killed it at the source, we can kill the others too
		if(tumor != src)
			tumor.can_rebuild = FALSE
			qdel(tumor)
	affected.remove_status_effect(/datum/status_effect/debuff/black_briar1)
	affected.remove_status_effect(/datum/status_effect/debuff/black_briar2)

/datum/wound/black_briar_curse/chest/on_life()
	. = ..()
	if(length(root_network) < 2) // we can't get worse without a limb being infected
		infection = min(infection, max_infection * BBC_TIME_LATE)
		infection_percent = min(infection_percent, BBC_TIME_LATE)
	owner.adjust_energy((owner.STAEND - 20) * (SSmobs.wait * 0.1) * infection_percent)
	if(infection_percent >= 1)
		owner.death()
	if(infection_percent > BBC_TIME_LATE)
		owner.apply_status_effect(/datum/status_effect/debuff/black_briar2)
	else
		owner.remove_status_effect(/datum/status_effect/debuff/black_briar2)
	if(infection_percent > BBC_TIME_MID)
		owner.apply_status_effect(/datum/status_effect/debuff/black_briar1)
		if(!HAS_TRAIT(owner, TRAIT_BLACK_BRIAR) && world.time > next_limb_infection && prob(4))
			var/list/uninfected_bodyparts = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
			uninfected_bodyparts -= root_network
			var/mob/living/carbon/C = owner
			var/obj/item/bodypart/BP = C.get_bodypart_complex(uninfected_bodyparts)
			var/wound_type = get_black_briar_wound_type(BP?.body_zone)
			if(wound_type)
				BP.add_wound(wound_type, TRUE)
			next_limb_infection = world.time + max_infection * BBC_TIME_HIDDEN
	else
		owner.remove_status_effect(/datum/status_effect/debuff/black_briar1)
		var/_emote = pick("yawn", "cough", "clearthroat")
		if(prob(0.5))
			owner.emote(_emote, forced = TRUE)


/datum/wound/black_briar_curse/head
	show_in_book = FALSE
	body_zones = list(BODY_ZONE_HEAD)

/datum/wound/black_briar_curse/head/on_life()
	. = ..()
	if(infection_percent > BBC_TIME_HIDDEN && prob(3 * infection_percent))
		owner.blur_eyes(rand(4, 6))
		owner.stuttering = max(owner.stuttering, 10)

/datum/wound/black_briar_curse/arm
	//show_in_book = FALSE
	body_zones = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)

/datum/wound/black_briar_curse/arm/on_life()
	. = ..()
	if((infection_percent > BBC_TIME_LATE) ^ disabling) // if these two are synced up, we dont need to callw
		disabling = !disabling
		if(bodypart_owner.can_be_disabled)
			bodypart_owner.update_disabled()


/datum/wound/black_briar_curse/leg
	//show_in_book = FALSE
	body_zones = list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	// used for left and rights.
	var/specific_zone
	//prevents redundant calls on second leg
	var/too_slow = FALSE

/datum/wound/black_briar_curse/leg/on_bodypart_gain(obj/item/bodypart/affected)
	. = ..()
	specific_zone = affected.body_zone

/datum/wound/black_briar_curse/leg/on_mob_loss(mob/living/affected)
	. = ..()
	var/datum/wound/black_briar_curse/leg/other
	if(!too_slow)
		var/datum/weakref/WR = LAZYACCESS(root_network, specific_zone == BODY_ZONE_L_LEG ? BODY_ZONE_R_LEG : BODY_ZONE_L_LEG)
		other = WR?.resolve()
		other?.too_slow = TRUE
		REMOVE_TRAIT(affected, TRAIT_IMMOBILIZED, "[type]")
	affected.remove_movespeed_modifier("[MOVESPEED_ID_BLACK_BRIAR]_[specific_zone]", (!other == TRUE))
	too_slow = FALSE

/datum/wound/black_briar_curse/leg/on_life()
	. = ..()
	var/datum/wound/black_briar_curse/leg/other
	if(!too_slow)
		var/datum/weakref/WR = LAZYACCESS(root_network, specific_zone == BODY_ZONE_L_LEG ? BODY_ZONE_R_LEG : BODY_ZONE_L_LEG)
		other = WR?.resolve()
		other?.too_slow = TRUE
		var/immobilizing = HAS_TRAIT_FROM(owner, TRAIT_IMMOBILIZED, "[type]")
		if(other?.infection_percent >= 1 && infection_percent >= 1 && !HAS_TRAIT(owner, TRAIT_NO_IMMOBILIZE))
			if(!immobilizing)
				ADD_TRAIT(owner, TRAIT_IMMOBILIZED, "[type]")
		else if(immobilizing)
			REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, "[type]")
	//only the second leg updates on these if they exist
	owner.add_movespeed_modifier("[MOVESPEED_ID_BLACK_BRIAR]_[specific_zone]", (!other == TRUE), multiplicative_slowdown = infection_percent, override = TRUE)
	too_slow = FALSE

#undef BBC_TIME_MAX_LIMB
#undef BBC_TIME_MAX

/proc/get_black_briar_wound_type(var/def_zone)
	switch(def_zone)
		if(BODY_ZONE_HEAD)
			return /datum/wound/black_briar_curse/head
		if(BODY_ZONE_CHEST)
			return /datum/wound/black_briar_curse/chest
		if(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
			return /datum/wound/black_briar_curse/arm
		if(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			return /datum/wound/black_briar_curse/leg
