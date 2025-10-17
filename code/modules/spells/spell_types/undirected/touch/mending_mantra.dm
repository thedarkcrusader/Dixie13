/datum/intent/mending_mantra
	noaa = TRUE
	misscost = 0
	releasedrain = 0
	candodge = FALSE
	canparry = FALSE
	reach = 1
	name = "touch"
	icon_state = "intouch"

/datum/action/cooldown/spell/undirected/touch/mending_mantra
	name = "Malum's Mantra"
	desc = "Beeseech Malum to bless your touch, and coax a damaged item into function once more."

	spell_type = SPELL_MIRACLE
	associated_skill = /datum/skill/magic/holy
	school = SCHOOL_CONJURATION

	cooldown_time = 10 SECONDS

	hand_path = /obj/item/melee/touch_attack/mending_mantra
	draw_message = "I draw a mending power through my fingertips."
	drop_message = "I dispell my mantra."
	charges = 10

/datum/action/cooldown/spell/undirected/touch/orison/can_cast_spell(feedback)
	. = ..()
	if(!.)
		return FALSE

	if(!ishuman(owner))
		return FALSE

/datum/action/cooldown/spell/undirected/touch/mending_mantra/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/human/caster, list/modifiers)
	if(!istype(caster))
		return
	var/integrity = victim.get_integrity()
	var/max_integrity = victim.max_integrity
	var/bladeintgood = TRUE
	if(istype(victim, /obj/item))
		var/obj/item/sord = victim
		if(sord.blade_int < sord.max_blade_int)
			bladeintgood = FALSE
	if(!integrity)
		to_chat(humcaster, span_info("\The [victim] cannot be repaired in the first place."))
		return
	if(integrity >= max_integrity && bladeintgood)
		to_chat(humcaster, span_info("\The [victim] appears to be in pefect condition."))
		return

	var/fatigue_spent = 0
	var/fatigue_used = max(3, humcaster.get_skill_level(associated_skill))
	humcaster.visible_message(span_info("[humcaster] holds [humcaster.p_their()] hand up to [victim], a haze of orange energy flowing from [humcaster.p_their()] fingertips."), span_notice("I beeseech Malum to return [victim] to health and function..."))
	while(do_after(humcaster, 0.5 SECONDS, victim))
		if((victim.get_integrity() == victim.max_integrity))
			if(istype(victim, /obj/item))
				var/obj/item/sord = victim
				if(sord.blade_int >= sord.max_blade_int)
					break
			else
				break
		if(humcaster.cleric.devotion - 1 < 0)
			break
		victim.repair_damage(max_integrity * (0.02 * humcaster.get_skill_level(associated_skill)))
		victim.atom_fix()
		if(istype(victim, /obj/item))
			var/obj/item/sord = victim
			sord.add_bintegrity(sord.max_blade_int * (0.02 * humcaster.get_skill_level(associated_skill)))
		fatigue_spent += fatigue_used
		humcaster.adjust_stamina(fatigue_used)
		humcaster.cleric?.update_devotion(-1)
	var/skill_level = humcaster.get_skill_level(associated_skill)
	if(skill_level <= SKILL_LEVEL_EXPERT)
		adjust_experience(humcaster, associated_skill, fatigue_spent)

/obj/item/melee/touch_attack/mending_mantra
	name = "\improper mending mantra"
	desc = "Let forth streams of mending energy from your fingertips."
	possible_item_intents = list(/datum/intent/mending_mantra)
