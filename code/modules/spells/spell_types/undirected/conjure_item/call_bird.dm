/datum/action/cooldown/spell/undirected/conjure_item/call_bird
	name = "Call Messenger Bird"
	desc = "Calls for your messenger bird."
	button_icon_state = "zad"
	sound = null

	cooldown_time = 30 SECONDS
	spell_cost = 0

	invocation_type = INVOCATION_NONE
	item_type = /obj/item/reagent_containers/food/snacks/messenger_bird
	item_duration = null
	has_visual_effects = FALSE
	experience_modifer = 0

	attunements = list(
		/datum/attunement/light = 0.3,
	)

	var/bird_called = FALSE
	var/obj/item/reagent_containers/food/snacks/messenger_bird/owned_bird = null

	var/list/destinations = list(
		"My family" = "their family",
		"Cancel" = "cancel",
	)

/datum/action/cooldown/spell/undirected/conjure_item/call_bird/grenzel
	destinations = list(
		"My family" = "their family",
		"Grenzelhoft Imperiate" = "the Grenzelhoft Imperiate",
		"Cancel" = "cancel",
	)

/datum/action/cooldown/spell/undirected/conjure_item/call_bird/priest
	destinations = list(
		"The Archbishop" = "the Archbishop",
		"Cancel" = "cancel",
	)

/datum/action/cooldown/spell/undirected/conjure_item/call_bird/zalad
	destinations = list(
		"The Mercator Guild" = "the Mercator Guild",
		"Cancel" = "cancel",
	)


/datum/action/cooldown/spell/undirected/conjure_item/call_bird/cast(atom/cast_on)
	if(isliving(owner))
		var/mob/living/L = owner
		L.emote("attnwhistle", forced = TRUE)
		var/turf/T = L.loc
		if(!T.can_see_sky())
			to_chat(L, span_warning("You whistle, but feel like a fool as nothing happens..."))
			return
		if(bird_called && QDELETED(owned_bird) || owned_bird && owned_bird.dead) // Bird is dead
			to_chat(L, span_warning("You whistle, but nothing happens..."))
			L.add_stress(/datum/stress_event/dead_bird)
			return
		if(bird_called && owned_bird) // Calling back our bird
			owned_bird.fly_away()
	..()

/datum/action/cooldown/spell/undirected/conjure_item/call_bird/make_item()
	var/obj/item/reagent_containers/food/snacks/messenger_bird/bird = ..()
	bird_called = TRUE
	bird.source_spell = src
	bird.bird_owner = owner
	owned_bird = bird
	playsound(bird, 'sound/vo/mobs/bird/birdfly.ogg', 100, TRUE, -1)
	return bird

/obj/item/reagent_containers/food/snacks/messenger_bird
	name = "messenger bird"
	desc = "A small bird, used by nobles to send messages beyond the borders of this city. It has a small pouch on its leg for carrying notes."
	icon_state = "messenger"
	icon = 'icons/roguetown/mob/monster/messenger.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	foodtype = RAW
	verb_say = "squeaks"
	verb_yell = "squeaks"
	obj_flags = CAN_BE_HIT
	var/dead = FALSE
	eat_effect = /datum/status_effect/debuff/uncookedfood
	max_integrity = 10
	sellprice = 0
	blade_dulling = DULLING_CUT
	rotprocess = null
	static_debris = list(/obj/item/natural/feather=1)
	var/datum/action/cooldown/spell/undirected/conjure_item/call_bird/source_spell
	var/mob/living/bird_owner

/obj/item/reagent_containers/food/snacks/friedmessenger
	name = "fried messenger"
	desc = "A fried messenger bird. Poor thing."
	icon_state = "fcrow"
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("burnt flesh" = 1)
	eat_effect = null
	rotprocess = SHELFLIFE_SHORT
	sellprice = 0

/obj/item/reagent_containers/food/snacks/messenger_bird/burning(input as num)
	. = ..()
	if(!dead)
		if(burning >= burntime)
			dead = TRUE
			playsound(src, 'sound/vo/mobs/rat/rat_death.ogg', 100, FALSE, -1)
			icon_state = "[icon_state]1"

/obj/item/reagent_containers/food/snacks/messenger_bird/dead
	dead = TRUE
	rotprocess = SHELFLIFE_SHORT

/obj/item/reagent_containers/food/snacks/messenger_bird/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	if(dead)
		icon_state = "[icon_state]l"

/obj/item/reagent_containers/food/snacks/messenger_bird/attack_hand(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		if(!(L.mobility_flags & MOBILITY_PICKUP))
			return
	user.changeNext_move(CLICK_CD_MELEE)
	if(dead)
		..()
	else
		fly_away()
		return

/obj/item/reagent_containers/food/snacks/messenger_bird/atom_destruction(damage_flag)
	if(!dead)
		dead = TRUE
		playsound(src, 'sound/vo/mobs/rat/rat_death.ogg', 100, FALSE, -1)
		icon_state = "[icon_state]1"
		rotprocess = SHELFLIFE_SHORT
		return 1
	return ..()

/obj/item/reagent_containers/food/snacks/messenger_bird/proc/fly_away()
	if(!dead)
		playsound(src, 'sound/vo/mobs/bird/birdfly.ogg', 100, TRUE, -1)
		visible_message(span_notice("The messenger bird flies away!"))
		source_spell.bird_called = FALSE
		qdel(src)


/obj/item/reagent_containers/food/snacks/messenger_bird/attackby(obj/item/I, mob/user, params)
	if(!dead)
		if(isliving(user))
			var/mob/living/L = user
			if(prob(L.STASPD * 2) || bird_owner == user)
				if(istype(I, /obj/item/paper) && bird_owner == user)
					var/obj/item/paper/P = I
					if(length(P.info) > 0)
						to_chat(user, span_notice("You attach your note to the messenger bird."))
						var/noble_info = "[user.key]/([user.real_name]) ([user.job])"
						var/dest = input(user, "Where would you like the bird to go?", "Destination")  as anything in source_spell.destinations

						if(dest == "Cancel")
							to_chat(user, span_notice("You decide not to send the bird anywhere."))
							return

						to_chat(user, span_notice("You tell the bird to go to [source_spell.destinations[dest]]"))
						var/strip_info = STRIP_HTML_FULL(replacetext(P.info, "<br>", "\n"), MAX_MESSAGE_LEN)
						strip_info = replacetext(strip_info, "\n", "<br>")
						message_admins("[noble_info] [ADMIN_BIRD_LETTER(user)] [ADMIN_FLW(user)] writes to [source_spell.destinations[dest]]: <br>[strip_info]")
						user.log_message("Sent a message with a bird to [source_spell.destinations[dest]]: [strip_info]", LOG_GAME)
						fly_away()
						qdel(P)

						return
					else
						to_chat(user, span_warning("The note is blank!"))
						return
			else
				to_chat(user, "<span class='warning'>[src] gets away!</span>")
				fly_away()
				return
	..()


