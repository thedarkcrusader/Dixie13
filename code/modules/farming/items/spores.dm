/obj/item/neuFarm/spore
	name = "mushroom spores"
	desc = "Used to inoculate mushroom mounds for cultivation."
	icon_state = "spores"
	icon = 'icons/roguetown/items/produce.dmi'
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	possible_item_intents = list(/datum/intent/use)
	var/datum/plant_def/plant_def_type

	var/datum/plant_genetics/spore_genetics

/obj/item/neuFarm/spore/Initialize(mapload, datum/plant_genetics/passed_genetics)
	. = ..()
	if(plant_def_type)
		var/datum/plant_def/def = GLOB.plant_defs[plant_def_type]
		color = def.seed_color // make a new spore color list later

	if(!passed_genetics)
		if(!spore_genetics)
			var/datum/plant_def/plant_def_instance = GLOB.plant_defs[plant_def_type]
			spore_genetics = new /datum/plant_genetics(plant_def_instance)
		else
			spore_genetics = new spore_genetics()
	else
		spore_genetics = passed_genetics.copy()

/obj/item/neuFarm/spore/Crossed(mob/living/L)
	. = ..()
	if(prob(10) && istype(L))
		playsound(loc,"seedextract", 40, FALSE)
		visible_message(span_warning("[L] crushes [src] underfoot."))
		qdel(src)

/obj/item/neuFarm/spore/examine(mob/user)
	. = ..()
	var/show_real_identity = FALSE
	if(isliving(user))
		var/mob/living/living = user
		// Seed knowers, know the seeds AND spores (druids and such)
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
			var/examine_name = "[plant_def_instance.spore_identity]"
			var/datum/plant_genetics/spore_genetics_instance = spore_genetics
			if(spore_genetics_instance.spore_identity_modifier)
				examine_name = "[spore_genetics_instance.spore_identity_modifier] " + examine_name
			. += span_notice("I can tell this is some [examine_name].")
			. += plant_def_instance.get_examine_details()

/obj/item/neuFarm/spore/attack_atom(atom/attacked_atom, mob/living/user)
	if(!isturf(attacked_atom))
		return ..()

	var/obj/structure/soil/mushmound/mushmound
	if(mushmound)
		try_plant_spore(user, mushmound)
		return TRUE
	return ..()

/obj/item/neuFarm/spore/proc/try_plant_spore(mob/living/user, obj/structure/soil/mushmound/mushmound)
	if(mushmound.plant)
		to_chat(user, span_warning("There is already something planted in \the [mushmound]!"))
		return
	if(!plant_def_type)
		return
	to_chat(user, span_notice("I plant \the [src] in \the [mushmound]."))
	mushmound.insert_plant(GLOB.plant_defs[plant_def_type], spore_genetics)
	qdel(src)

/obj/item/neuFarm/spore/coprinus
	plant_def_type = /datum/plant_def/coprinus

/obj/item/neuFarm/spore/reishi
	plant_def_type = /datum/plant_def/reishi

/obj/item/neuFarm/spore/morel
	plant_def_type = /datum/plant_def/morel

/obj/item/neuFarm/spore/oyster
	plant_def_type = /datum/plant_def/oyster

/obj/item/neuFarm/spore/porcini
	plant_def_type = /datum/plant_def/porcini

/obj/item/neuFarm/spore/chanterelle
	plant_def_type = /datum/plant_def/chanterelle
