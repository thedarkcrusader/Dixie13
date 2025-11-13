/obj/item/weapon/garrote/razor // To Yische, the dude who made this originally, I respectfully decline your opinion simply because it would be cool as hell for assassin to have a garrote
	name = "Profane Razor" // Well, it used to be non lethal. Now it isn't, have fun agent 47.
	desc = "A thin wire of phantom black material strung between two steel grasps. The grasps are cold to the touch, even through gloves, and the strand of wire, while appearing fragile, is seemingly unbreakable. Perfect for asphyxiation."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "garrote"
	item_state = "garrote"
	gripsprite = TRUE
	throw_speed = 3
	throw_range = 7
	grid_height = 32
	grid_width = 32
	throwforce = 15
	force_wielded = 0
	force = 0
	obj_flags = CAN_BE_HIT
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_WRISTS
	experimental_inhand = TRUE
	wieldsound = TRUE
	resistance_flags = INDESTRUCTIBLE
	w_class = WEIGHT_CLASS_SMALL
	can_parry = FALSE
	gripped_intents = list(/datum/intent/garrote/grab, /datum/intent/garrote/choke)
	var/mob/living/victim
	var/obj/item/grabbing/currentgrab
	var/mob/living/lastcarrier
	var/active = FALSE
	var/choke_damage = 20
	embedding = null
	sellprice = 100
	wield_block = FALSE

/obj/item/weapon/garrote/razor/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 9,"ny" = -6,"wx" = -6,"wy" = -4,"ex" = 4,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 90,"wturn" = 93,"eturn" = -12,"nflip" = 0,"sflip" = 1,"wflip" = 0,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 9,"ny" = -6,"wx" = -6,"wy" = -4,"ex" = 4,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 90,"wturn" = 93,"eturn" = -12,"nflip" = 0,"sflip" = 1,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/datum/intent/garrote/choke
	name = "choke"
	icon_state = "inchoke"
	desc = "Used to begin choking the target out."
	no_attack = TRUE

/datum/intent/garrote/grab
	name = "grab"
	icon_state = "ingrab"
	desc = "Used to wrap around the target."
	no_attack = TRUE

/obj/item/weapon/garrote/razor/proc/wipeslate(mob/user)
	if(victim)
		REMOVE_TRAIT(victim, TRAIT_MUTE, "garroteCordage")
		REMOVE_TRAIT(victim, TRAIT_GARROTED, TRAIT_GENERIC)
		victim = null
		currentgrab = null
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		var/datum/component/two_handed/twohanded = GetComponent(/datum/component/two_handed)
		if(ismob(loc))
			twohanded.unwield(loc)
		active = FALSE
		playsound(loc, 'sound/items/garroteshut.ogg', 65, TRUE)

/obj/item/weapon/garrote/razor/attack_self(mob/user)
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		var/datum/component/two_handed/twohanded = GetComponent(/datum/component/two_handed)
		if(ismob(loc))
			twohanded.unwield(loc)
		active = FALSE
		if(user.pulling)
			user.stop_pulling()
		playsound(loc, 'sound/items/garroteshut.ogg', 65, TRUE)
		wipeslate(user)
		return
	if(gripped_intents)
		var/datum/component/two_handed/twohanded = GetComponent(/datum/component/two_handed)
		if(ismob(loc))
			twohanded.wield(loc)
		active = TRUE
		if(HAS_TRAIT(src, TRAIT_WIELDED))
			playsound(loc, pick('sound/items/garrote.ogg', 'sound/items/garrote2.ogg'), 65, TRUE)
			return

/obj/item/weapon/garrote/razor/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	lastcarrier = user
	wipeslate(lastcarrier)
	if(active)
		if(lastcarrier.pulling)
			lastcarrier.stop_pulling()
		playsound(user, 'sound/items/garroteshut.ogg', 65, TRUE)
		active = FALSE

/obj/item/weapon/garrote/razor/dropped(mob/user, silent)
	. = ..()
	wipeslate(lastcarrier)
	if(active)
		if(lastcarrier.pulling)
			lastcarrier.stop_pulling()
		playsound(user, 'sound/items/garroteshut.ogg', 65, TRUE)
		active = FALSE

/obj/item/weapon/garrote/razor/afterattack(mob/living/target, mob/living/user, proximity_flag, click_parameters)
	. = ..()
	if(istype(user.used_intent, /datum/intent/garrote/grab))	// Grab your target first.
		if(!iscarbon(target))
			return
		if(!proximity_flag)
			return
		if(victim == target)
			return
		if(user.pulling)

		// THROAT TARGET RESTRICTION. HEAVILY REQUESTED.
		if(user.zone_selected != "neck")
			to_chat(user, span_warning("I need to wrap it around their throat."))
			return
		victim = target
		playsound(loc, 'sound/items/garrotegrab.ogg', 100, TRUE)
		ADD_TRAIT(user, TRAIT_NOTIGHTGRABMESSAGE, TRAIT_GENERIC)
		ADD_TRAIT(user, TRAIT_NOSTRUGGLE, TRAIT_GENERIC)
		ADD_TRAIT(target, TRAIT_GARROTED, TRAIT_GENERIC)
		ADD_TRAIT(target, TRAIT_MUTE, "garroteCordage")
		if(target != user)
			user.start_pulling(target, state = 1, item_override = src)
		user.visible_message(span_danger("[user] wraps the [src] around [target]'s throat!"))
		user.adjust_stamina(25)
		user.changeNext_move(CLICK_CD_MELEE)
		REMOVE_TRAIT(user, TRAIT_NOSTRUGGLE, TRAIT_GENERIC)
		REMOVE_TRAIT(user, TRAIT_NOTIGHTGRABMESSAGE, TRAIT_GENERIC)
		var/obj/item/grabbing/I = user.get_inactive_held_item()
		if(istype(I, /obj/item/grabbing/))
			I.icon_state = null
			currentgrab = I

	if(istype(user.used_intent, /datum/intent/garrote/choke))	// Get started.
		if(!victim)
			to_chat(user, span_warning("Who am I choking? What?"))
			return
		if(!proximity_flag)
			return
		if(user.zone_selected != "neck")
			to_chat(user, span_warning("I need to constrict the throat."))
			return
		user.adjust_stamina(rand(4, 8))
		var/mob/living/carbon/C = victim
		// if(get_location_accessible(C, BODY_ZONE_PRECISE_NECK))
		playsound(loc, pick('sound/items/garrotechoke1.ogg', 'sound/items/garrotechoke2.ogg', 'sound/items/garrotechoke3.ogg', 'sound/items/garrotechoke4.ogg', 'sound/items/garrotechoke5.ogg'), 100, TRUE)
		if(prob(40))
			C.emote("choke")
		C.adjustOxyLoss(choke_damage)
		C.visible_message(span_danger("[user] [pick("garrotes", "asphyxiates")] [C]!"), \
		span_userdanger("[user] [pick("garrotes", "asphyxiates")] me!"), span_hear("I hear the sickening sound of cordage!"), COMBAT_MESSAGE_RANGE, user)
		to_chat(user, span_danger("I [pick("garrote", "asphyxiate")] [C]!"))
		user.changeNext_move(CLICK_CD_RESIST)	//Stops spam for choking.