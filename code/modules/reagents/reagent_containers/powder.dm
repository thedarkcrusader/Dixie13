/obj/item/reagent_containers/powder
	name = "powder parent item. You should not be seeing this."
	desc = ""
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "spice"
	item_state = "spice"
	possible_transfer_amounts = null
	volume = 15
	list_reagents = null
	sellprice = 10
	grid_height = 32
	grid_width = 32

/obj/item/reagent_containers/powder/canconsume(mob/eater, mob/user, silent)
	. = ..()
	if(!.)
		return
	if(user.zone_selected != BODY_ZONE_PRECISE_NOSE)
		to_chat(user, span_notice("\The [src] must be snorted."))
		return FALSE
	// Checked in parent for carbon
	var/mob/living/L = eater
	if(!L.can_smell())
		if(L == user)
			to_chat(user, span_warning("I can't use my nose!"))
		else
			to_chat(user, span_warning("[L.p_they(TRUE)] can't use [L.p_their()] nose!"))
		return FALSE
	return TRUE

/obj/item/reagent_containers/powder/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	. = ..()
	if(thrownthing?.target_zone != BODY_ZONE_PRECISE_NOSE)
		return
	if(iscarbon(hit_atom))
		var/mob/living/carbon/C = hit_atom
		if(canconsume(C, silent = TRUE))
			if(reagents.total_volume)
				playsound(get_turf(C), 'sound/items/sniff.ogg', 100, FALSE)
				reagents.trans_to(C, 1, transfered_by = thrownthing.thrower, method = "swallow")
				qdel(src)

/obj/item/reagent_containers/powder/attack(mob/M, mob/user, def_zone)
	if(!canconsume(M, user))
		return FALSE
	if(M == user)
		M.visible_message(span_notice("[user] sniffs [src]."))
	else
		if(iscarbon(M))
			var/mob/living/carbon/C = M
			var/obj/item/bodypart/CH = C.get_bodypart(BODY_ZONE_HEAD)
			if(!CH)
				to_chat(user, span_warning("[C.p_theyre(TRUE)] missing their head."))
				return FALSE
			C.visible_message(span_danger("[user] attempts to force [C] to inhale [src]."), \
							span_danger("[user] attempts to force me to inhale [src]!"))
			if(C.cmode)
				if(!CH.grabbedby)
					to_chat(user, span_info("[C.p_they(TRUE)] steals [C.p_their()] face from it."))
					return FALSE
			if(!do_after(user, 1 SECONDS, M))
				return FALSE

	playsound(get_turf(M), 'sound/items/sniff.ogg', 100, FALSE)

	if(reagents.total_volume)
		reagents.trans_to(M, reagents.total_volume, transfered_by = user, method = "swallow")
		SEND_SIGNAL(M, COMSIG_DRUG_SNIFFED, user)
		record_featured_stat(FEATURED_STATS_CRIMINALS, user)
		record_round_statistic(STATS_DRUGS_SNORTED)
	qdel(src)
	return TRUE

/obj/item/reagent_containers/powder/spice
	name = "spice"
	desc = "A potent powder known to grow from decaying bone matter, rumored to be spores of a fungi. \
	Its apparently mind opening properties have ensured it remains popular amongst the mages and other intellectuals."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "spice"
	item_state = "spice"
	list_reagents = list(/datum/reagent/druqks = 25)
	sellprice = 35

/datum/reagent/druqks
	name = "Drukqs"
	description = ""
	taste_description = "something spicy"
	color = "#60A584" // rgb: 96, 165, 132
	overdose_threshold = 16
	metabolization_rate = 0.2

/atom/movable/screen/fullscreen/druqks
	icon_state = "spa"
	plane = FLOOR_PLANE
	layer = ABOVE_OPEN_TURF_LAYER
	blend_mode = 0

/datum/reagent/druqks/on_mob_life(mob/living/carbon/M)
	M.set_drugginess(30)
	M.apply_status_effect(/datum/status_effect/buff/druqks)
	if(prob(5))
		if(M.gender == FEMALE)
			M.emote(pick("twitch_s","giggle"))
		else
			M.emote(pick("twitch_s","chuckle"))
	if(M.has_flaw(/datum/charflaw/addiction/junkie))
		M.sate_addiction()
	..()

/datum/reagent/druqks/on_mob_metabolize(mob/living/M)
	M.overlay_fullscreen("druqk", /atom/movable/screen/fullscreen/druqks)
	M.set_drugginess(30)
	if(M.client)
		ADD_TRAIT(M, TRAIT_DRUQK, "based")
		M.refresh_looping_ambience()

/datum/reagent/druqks/on_mob_end_metabolize(mob/living/M)
	M.clear_fullscreen("druqk")
	M.set_drugginess(0)
	M.remove_status_effect(/datum/status_effect/buff/druqks)
	if(M.client)
		REMOVE_TRAIT(M, TRAIT_DRUQK, "based")
		M.refresh_looping_ambience()

/datum/reagent/druqks/overdose_process(mob/living/M)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.25*REM)
	M.adjustToxLoss(0.25*REM, 0)
	. = ..()

/datum/reagent/druqks/overdose_start(mob/living/M)
	M.visible_message(span_warning("Blood runs from [M]'s nose."))

/obj/item/reagent_containers/powder/ozium
	name = "ozium"
	desc = "A potent drug that causes a state of euphoria, but can also arrest breathing. \
	Its pain numbing properties are why it remains popular amongst Feldshers and Physickers."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "ozium"
	list_reagents = list(/datum/reagent/ozium = 25)
	sellprice = 15

/datum/reagent/ozium
	name = "Ozium"
	description = ""
	taste_description = "a flash of white"
	color = "#60A584" // rgb: 96, 165, 132
	overdose_threshold = 16
	metabolization_rate = 0.2

/datum/reagent/ozium/on_mob_life(mob/living/carbon/M)
	if(M.has_flaw(/datum/charflaw/addiction/junkie))
		M.sate_addiction()
	M.apply_status_effect(/datum/status_effect/buff/ozium)
	..()

/datum/reagent/ozium/overdose_process(mob/living/M)
	M.adjustOxyLoss(0.25*REM, 0)
	. = ..()

/datum/reagent/ozium/overdose_start(mob/living/M)
	M.emote(pick("gasp","gag"))

/obj/item/reagent_containers/powder/moondust
	name = "moondust"
	desc = "Known to occur naturally in the skin of certain pallid goblins, \
	this drug is infamous for it's potency, both in pleasure and addiction. \
	As such many kingdoms, including Kingsfield, declared this drug illegal."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "moondust"
	list_reagents = list(/datum/reagent/moondust = 25)
	sellprice = 50

/obj/item/reagent_containers/powder/moondust/impure
	list_reagents = list(/datum/reagent/moondust = 10, /datum/reagent/berrypoison = 10, /datum/reagent/soap = 5)
	sellprice = 15

/datum/reagent/moondust
	name = "Moondust"
	description = ""
	taste_description = "gunpowder"
	color = "#bfc3b5"
	overdose_threshold = 50
	metabolization_rate = 0.2

/datum/reagent/moondust/on_mob_metabolize(mob/living/M)
	animate(M.client, pixel_y = 1, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
	animate(pixel_y = -1, time = 1, flags = ANIMATION_RELATIVE)

/datum/reagent/moondust/on_mob_end_metabolize(mob/living/M)
	M.remove_status_effect(/datum/status_effect/buff/moondust)
	animate(M.client)

/datum/reagent/moondust/on_mob_life(mob/living/carbon/M)
	if(M.reagents.has_reagent(/datum/reagent/moondust_purest))
		M.Sleeping(40, 0)
	if(M.has_flaw(/datum/charflaw/addiction/junkie))
		M.sate_addiction()
	M.apply_status_effect(/datum/status_effect/buff/moondust)
	..()

/datum/reagent/moondust/overdose_process(mob/living/M)
	M.adjustToxLoss(0.25*REM, 0)
	. = ..()

/datum/reagent/moondust/overdose_start(mob/living/M)
	M.playsound_local(get_turf(M), 'sound/misc/heroin_rush.ogg', 100, FALSE)
	M.visible_message(span_warning("Blood runs from [M]'s nose."))

/obj/item/reagent_containers/powder/moondust_purest
	name = "pure moondust"
	desc = "Purified moondust, deemed to be Baothan heresy due to the mind numbing pleasure and severe addiction it can cause."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "moondust_purest"
	list_reagents = list(/datum/reagent/moondust_purest = 25)
	sellprice = 100

/obj/item/reagent_containers/powder/moondust_purest/impure
	list_reagents = list(/datum/reagent/moondust = 5, /datum/reagent/soap = 5, /datum/reagent/berrypoison = 15, /datum/reagent/water/gross = 10)
	sellprice = 10

/datum/reagent/moondust_purest
	name = "Purest Moondust"
	description = ""
	taste_description = "gunpowder"
	color = "#bfc3b5"
	overdose_threshold = 50
	metabolization_rate = 0.2

/datum/reagent/moondust_purest/on_mob_metabolize(mob/living/M)
	M.overlay_fullscreen("druqks", /atom/movable/screen/fullscreen/druqks)
	animate(M.client, pixel_y = 1, time = 1, loop = -1, flags = ANIMATION_RELATIVE)
	animate(pixel_y = -1, time = 1, flags = ANIMATION_RELATIVE)

/datum/reagent/moondust_purest/on_mob_end_metabolize(mob/living/M)
	animate(M.client)
	M.clear_fullscreen("druqks")
	M.remove_status_effect(/datum/status_effect/buff/moondust_purest)

/datum/reagent/moondust_purest/on_mob_life(mob/living/carbon/M)
	if(M.reagents.has_reagent(/datum/reagent/moondust))
		M.Sleeping(40, 0)
	if(M.has_flaw(/datum/charflaw/addiction/junkie))
		M.sate_addiction()
	M.apply_status_effect(/datum/status_effect/buff/moondust_purest)
	..()

/datum/reagent/moondust_purest/overdose_process(mob/living/M)
	M.adjustToxLoss(0.5*REM, 0)
	. = ..()

/datum/reagent/moondust_purest/overdose_start(mob/living/M)
	M.playsound_local(get_turf(M), 'sound/misc/heroin_rush.ogg', 100, FALSE)
	M.visible_message(span_warning("Blood runs from [M]'s nose."))

/obj/item/reagent_containers/powder/manabloom
	name = "manabloom dust"
	desc = "Crushed manabloom useful as a combat measure against mages."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "salt"
	list_reagents = list(/datum/reagent/toxin/manabloom_juice = 5)
	sellprice = 10
	color = COLOR_CYAN

//generic herbs and spices used in cooking
//not as strong as pepper is, meant to be used by peasants and poor people to add some extra flavour
//feel free to make this be used in anything cooking related
/obj/item/reagent_containers/powder/herbs
	name = "herbs and spices"
	desc = "A bunch of herbs and spices mixed together."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "flour"
	volume = 1
	list_reagents = list(/datum/reagent/ash = 1)//you shouldn't be eating this anyways
	sellprice = 10
	color = COLOR_PALE_GREEN_GRAY

/obj/item/reagent_containers/powder/blastpowder
	name = "blastpowder"
	desc = "Explosive powder known to be produced by the dwarves. It's used in many explosives."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "blastpowder"
	list_reagents = list(/datum/reagent/blastpowder = 15)
	sellprice = 15
	var/primed = FALSE

/obj/item/reagent_containers/powder/blastpowder/spark_act()
	fire_act()

/obj/item/reagent_containers/powder/blastpowder/fire_act(added, maxstacks)
	if(primed)
		return
	primed = TRUE
	playsound(src, 'sound/items/fuse.ogg', 100)
	addtimer(CALLBACK(src, PROC_REF(boom)), 5 SECONDS)
	..()

/obj/item/reagent_containers/powder/blastpowder/proc/boom()
	var/turf/target_turf = get_turf(src)
	var/exp_devi = 0
	var/exp_heavy = 1
	var/exp_light = 1
	var/exp_flash = 3
	var/explode_sound = 'sound/misc/explode/bomb.ogg'
	explosion(target_turf, exp_devi, exp_heavy, exp_light, exp_flash, soundin = explode_sound)

	if(!isturf(loc))
		return

	if(!istype(loc, /turf/open/floor/naturalstone) && !istype(loc, /turf/open/floor/blocks) && !istype(loc, /turf/open/floor/grass) && !istype(loc, /turf/open/floor/dirt))
		return

	var/turf/closed/below = GET_TURF_BELOW(target_turf)
	if(istype(below))
		below.ScrapeAway()

	target_turf.ScrapeAway()

	qdel(src)
