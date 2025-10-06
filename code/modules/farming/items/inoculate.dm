/obj/item/neuFarm/seed/inoculate
	name = "mushroom inoculate"
	desc = "A cloth covered in mushroom spores, used to inoculate mushroom mounds for cultivation."
	icon_state = "inoculate"
	icon = 'icons/roguetown/items/produce.dmi'
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	possible_item_intents = list(/datum/intent/use)

var/datum/plant_genetics/inoculate_genetics

/obj/item/neuFarm/seed/inoculate/Initialize(mapload, datum/plant_genetics/passed_genetics)
	. = ..()
	if(!passed_genetics)
		if(!inoculate_genetics)
			var/datum/plant_def/plant_def_instance = GLOB.plant_defs[plant_def_type]
			inoculate_genetics = new /datum/plant_genetics(plant_def_instance)
		else
			inoculate_genetics = new inoculate_genetics()
	else
		inoculate_genetics = passed_genetics.copy()

/obj/item/neuFarm/seed/inoculate/Crossed(mob/living/L)
	. = ..()
	if(prob(10) && istype(L))
		playsound(loc,"seedextract", 40, FALSE)
		visible_message(span_warning("[L] crushes [src] underfoot."))
		qdel(src)

/obj/item/neuFarm/seed/inoculate/examine(mob/user)
	. = ..()
	var/show_real_identity = FALSE
	if(isliving(user))
		var/mob/living/living = user
		// Seed knowers, know the seeds AND inoculates (druids and such)
		if(HAS_TRAIT(living, TRAIT_SEEDKNOW))
			show_real_identity = TRUE
		// Journeyman farmers know them too
		else if(living.get_skill_level(/datum/skill/labor/farming) >= 2)
			show_real_identity = TRUE
	else
		show_real_identity = TRUE
	if(show_real_identity)
		var/datum/plant_def/plant_def_instance = GLOB.plant_defs[plant_def_type]
		if(plant_def_instance)
			var/examine_name = "[plant_def_instance.inoculate_identity]"
			var/datum/plant_genetics/inoculate_genetics_instance = inoculate_genetics
			if(inoculate_genetics_instance.inoculate_identity_modifier)
				examine_name = "[inoculate_genetics_instance.inoculate_identity_modifier] " + examine_name
			. += span_notice("I can tell this is a [examine_name].")
			. += plant_def_instance.get_examine_details()

/obj/item/neuFarm/seed/inoculate/proc/try_plant_inoculate(mob/living/user, obj/structure/soil/mushmound/mushmound)
	if(mushmound.plant)
		to_chat(user, span_warning("There is already something planted in \the [mushmound]!"))
		return
	if(!plant_def_type)
		return
	to_chat(user, span_notice("I plant \the [src] in \the [mushmound]."))
	mushmound.insert_plant(GLOB.plant_defs[plant_def_type], inoculate_genetics)
	qdel(src)

/obj/item/neuFarm/seed/inoculate/attack_atom(atom/attacked_atom, mob/living/user)
	if(!isturf(attacked_atom))
		return ..()

	var/turf/T = attacked_atom
	var/obj/structure/soil/soil = get_soil_on_turf(T)
	var/obj/structure/mushmound/mushmound
	if(mushmound)
		try_plant_seed(user, soil)
		return TRUE
	if(soil)
		to_chat(user, span_warning("I cannot plant this into regular soil!")
		return FALSE
	return ..()

/obj/item/neuFarm/seed/inoculate/coprinus
	plant_def_type = /datum/plant_def/coprinus

/obj/item/neuFarm/seed/inoculate/reishi
	plant_def_type = /datum/plant_def/reishi

/obj/item/neuFarm/seed/inoculate/morel
	plant_def_type = /datum/plant_def/morel

/obj/item/neuFarm/seed/inoculate/oyster
	plant_def_type = /datum/plant_def/oyster

/obj/item/neuFarm/seed/inoculate/porcini
	plant_def_type = /datum/plant_def/porcini

/obj/item/neuFarm/seed/inoculate/chanterelle
	plant_def_type = /datum/plant_def/chanterelle
