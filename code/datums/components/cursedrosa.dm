
/datum/component/cursedrosa

/datum/component/cursedrosa/Initialize(...)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/cursedrosa/RegisterWithParent()
	RegisterSignals(parent, list(COMSIG_MOVABLE_CROSSED), PROC_REF(atom_crossed))

/datum/component/cursedrosa/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_MOVABLE_CROSSED))

/datum/component/cursedrosa/proc/atom_crossed(source, atom/movable/AM)
	if(!ishuman(AM) || HAS_TRAIT(AM, TRAIT_TOXIMMUNE) || HAS_TRAIT(AM, TRAIT_PIERCEIMMUNE))
		return
	var/mob/living/carbon/human/target = AM
	if(NOBLOOD in target.dna?.species?.species_traits)
		return

	var/potential_zones = list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	var/dam = rand(ARMOR_GLOVES_LEATHER_GOOD["stab"], ARMOR_GLOVES_CHAIN["stab"] + 5)
	if(target.body_position == LYING_DOWN)
		potential_zones |= list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
	var/obj/item/bodypart/affecting = target.get_bodypart_complex(potential_zones)
	if(!affecting)
		return
	if(target.getarmor(affecting.body_zone, "stab", 0, simulate=TRUE) - dam > 0)
		return //we blocked it
	playsound(parent, 'sound/combat/hits/hi_arrow.ogg', 15, TRUE, -4)
	var/wound_type = get_black_briar_wound_type(affecting.body_zone)
	if(wound_type && (!affecting.has_wound(wound_type) || prob(30)))
		affecting.add_wound(wound_type, TRUE)
