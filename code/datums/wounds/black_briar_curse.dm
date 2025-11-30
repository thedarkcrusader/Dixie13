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
	// when it can try and infect a limb again
	COOLDOWN_DECLARE(next_limb_infect)
	var/limb_infect_cooldown = 5 MINUTES

/datum/wound/black_briar_curse/get_check_name(mob/user)
	if(infection > 2 MINUTES)
		return ..()

/datum/wound/black_briar_curse/can_apply_to_mob(mob/living/affected)
	. = ..()
	if(!. || !iscarbon(affected))
		return
	return affected.getorganslot(ORGAN_SLOT_LUNGS) && !HAS_TRAIT(affected, TRAIT_TOXIMMUNE)

/datum/wound/black_briar_curse/can_stack_with(datum/wound/other)
	if(istype(other, type))
		var/datum/wound/black_briar_curse/O = other
		O.infection += 1 MINUTES
		return FALSE
	return TRUE

/datum/wound/black_briar_curse/has_special_infection()
	return get_root() == src

/datum/wound/black_briar_curse/on_mob_gain(mob/living/affected)
	. = ..()
	if(!istype(bodypart_owner, /obj/item/bodypart/chest) && !get_root())
		var/obj/item/bodypart/chest/chest = owner.get_bodypart(BODY_ZONE_CHEST)
		if(chest && !chest.has_wound(type))
		// we just got added and there's no root? let's move to the chest then and become it.
			if(infection)
				infection = min(infection, 5 MINUTES)
				COOLDOWN_START(src, next_limb_infect, limb_infect_cooldown)
			apply_to_bodypart(chest, TRUE)

/datum/wound/black_briar_curse/on_mob_loss(mob/living/affected)
	. = ..()
	if(get_root() == src) // nip it in the bud
		for(var/datum/wound/black_briar_curse/polyp in affected.get_wounds())
			if(polyp == src)
				continue
			polyp.whp = 0
			polyp.heal_wound(1)

/datum/wound/black_briar_curse/on_life()
	. = ..()
	if(get_root() == src)
		evaluate_infection()

/datum/wound/black_briar_curse/proc/evaluate_infection()
	var/total_infection = 0
	var/list/bodyparts = list(BODY_ZONE_HEAD, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
	var/mob/living/carbon/C = owner

	for(var/datum/wound/black_briar_curse/polyp in owner.get_wounds())
		bodyparts -= polyp.bodypart_owner.body_zone
		polyp.infection += max(0, rand(20, 25) - owner.STAEND)
		polyp.woundpain = LERP(0,80, clamp((polyp.infection - 1 MINUTES) / (30 MINUTES), 0, 1))
		total_infection += polyp.infection

	owner.adjust_energy(-total_infection / (4 MINUTES))
	if(total_infection < 4 MINUTES) // Rooting
		owner.remove_status_effect(/datum/status_effect/debuff/blackbriar)
		if(prob(1))
			owner.emote("yawn", forced = TRUE)
	else
		owner.apply_status_effect(/datum/status_effect/debuff/blackbriar)
		if(COOLDOWN_FINISHED(src, limb_infect_cooldown) && prob(5))
			var/obj/item/bodypart/BP = C.get_bodypart_complex(bodyparts)
			BP.add_wound(type, TRUE)

	to_chat(owner, "[total_infection / 10]")

/datum/wound/black_briar_curse/proc/get_root()
	var/obj/item/bodypart/chest/chest = owner?.get_bodypart(BODY_ZONE_CHEST)
	return chest?.has_wound(type)
