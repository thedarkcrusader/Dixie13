/mob/living/simple_animal/hostile/retaliate/megaleech
	icon = 'icons/roguetown/mob/monster/megaleech.dmi'
	name = "megaleech"
	desc = ""
	icon_state = "megaleech"
	icon_living = "megaleech"
	icon_dead = "megaleech_dead"

	animal_species = /mob/living/simple_animal/hostile/retaliate/megaleech
	faction = list(FACTION_SEA, FACTION_RATS) // not so different, you and I
	gender = FEMALE
	footstep_type = FOOTSTEP_MOB_SLIME
	emote_see = list("looks around.", "chews some leaves.")
	move_to_delay = 8

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 1,
						/obj/item/natural/hide = 1,
						/obj/item/alch/bone = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 3,
						/obj/item/reagent_containers/food/snacks/fat = 1,
						/obj/item/natural/hide = 2,
						/obj/item/alch/sinew = 2,
						/obj/item/alch/bone = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 4,
						/obj/item/reagent_containers/food/snacks/fat = 1,
						/obj/item/natural/hide = 4,
						/obj/item/alch/sinew = 2,
						/obj/item/alch/bone = 1)
	head_butcher = /obj/item/natural/head/saiga

	health = 120
	maxHealth = 120
	blood_gulp = 30

	food_max = BLOOD_VOLUME_OKAY // this is absurdly high compared to most mobs but it's used for bloodfeeding

	food_type = list(/obj/item/reagent_containers/food/snacks/produce/grain/wheat,
					/obj/item/reagent_containers/food/snacks/produce/grain/oat,
					/obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry,
					/obj/item/reagent_containers/food/snacks/produce/fruit/apple)
	tame_chance = 25
	bonus_tame_chance = 15

	base_intents = list(/datum/intent/simple/bite/megaleech)
	rmb_intent = list(/datum/rmb_intent/megaleech_feed)
	attack_sound = list('sound/vo/mobs/saiga/attack (1).ogg','sound/vo/mobs/saiga/attack (2).ogg')
	melee_damage_lower = 1
	melee_damage_upper = 1
	retreat_distance = 10
	minimum_distance = 10
	base_speed = 8
	base_constitution = 16
	base_strength = 9
	base_endurance = 12
	can_buckle = TRUE
	buckle_lying = FALSE
	can_saddle = TRUE
	aggressive = TRUE

	ai_controller = /datum/ai_controller/megaleech

	var/static/list/pet_commands = list(
		/datum/pet_command/idle,
		/datum/pet_command/free,
		/datum/pet_command/good_boy,
		/datum/pet_command/follow,
		/datum/pet_command/attack,
		/datum/pet_command/fetch,
		/datum/pet_command/play_dead,
		/datum/pet_command/protect_owner,
		/datum/pet_command/aggressive,
		/datum/pet_command/calm,
	)

/mob/living/simple_animal/hostile/retaliate/megaleech/Initialize()
	AddComponent(/datum/component/obeys_commands, pet_commands) // here due to signal overridings from pet commands // due to signal overridings from pet commands
	. = ..()
	var/datum/component/generic_mob_hunger/hunger = GetComponent(/datum/component/generic_mob_hunger)
	if(hunger)
		hunger.hunger_drain = 1
	AddElement(/datum/element/ai_retaliate)

	ADD_TRAIT(src, TRAIT_IGNOREDAMAGESLOWDOWN, ROUNDSTART_TRAIT)
	ADD_TRAIT(src, TRAIT_GOOD_SWIM, ROUNDSTART_TRAIT)

/mob/living/simple_animal/hostile/retaliate/megaleech/AttackingTarget(mob/living/passed_target)
	. = ..()
	var/mob/living/L = target
	if(. && istype(target) && L.blood_volume > 0 && SEND_SIGNAL(src, COMSIG_MOB_RETURN_HUNGER) < 100)
		var/blood_taken = min(L.blood_volume, blood_gulp)
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			if(C.dna?.species && (NOBLOOD in C.dna.species.species_traits))
				return
			drinksomeblood(C, zone_selected)
		else
			L.blood_volume -= blood_taken
			L.handle_blood()
			playsound(loc, 'sound/misc/drink_blood.ogg', 100, FALSE, -4)
		SEND_SIGNAL(src, COMSIG_MOB_ADJUST_HUNGER, blood_taken) // chance of minor overflow but it's negligible

/mob/living/simple_animal/hostile/retaliate/megaleech/update_overlays()
	. = ..()
	if(stat == DEAD)
		return
	if(ssaddle)
		var/mutable_appearance/saddlet = mutable_appearance(icon, "megaleech_saddle_above", 4.3)
		. += saddlet
		saddlet = mutable_appearance(icon, "megaleech_saddle")
		. += saddlet
	if(has_buckled_mobs())
		var/mutable_appearance/mounted = mutable_appearance(icon, "megaleech_mounted", 4.3)
		. += mounted

/mob/living/simple_animal/hostile/retaliate/megaleech/tamed(mob/user)
	. = ..()
	deaggroprob = 30
	if(can_buckle)
		AddComponent(/datum/component/riding/saiga)

/mob/living/simple_animal/hostile/retaliate/megaleech/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "snout"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "snout"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"

	return ..()

/mob/living/simple_animal/hostile/retaliate/megaleech/tame
	tame = TRUE

/mob/living/simple_animal/hostile/retaliate/megaleech/tame/saddled/Initialize()
	. = ..()
	var/obj/item/natural/saddle/S = new(src)
	ssaddle = S
	update_appearance(UPDATE_OVERLAYS)


/datum/intent/simple/bite/megaleech
	penfactor = 50


/datum/rmb_intent/megaleech_feed
	name = "feed"
	desc = "RMB - Feed a target blood from yourself."
	icon_state = "special"
	// per bump of the do_after
	var/feed_amount = 5

/datum/rmb_intent/megaleech_feed/special_attack(mob/living/user, atom/target)
	if(!isliving(target) || !isanimal(user))
		return
	var/mob/living/simple_animal/A = user
	var/mob/living/L = target
	var/hunger = SEND_SIGNAL(user, COMSIG_MOB_RETURN_HUNGER) * A.food_max / 100
	if(do_after(A, 1 SECONDS, extra_checks=CALLBACK(A, PROC_REF(can_feed), A, L), max_interact_count = 10, display_over_user = TRUE))
		var/blood_given = min(BLOOD_VOLUME_MAXIMUM - A.blood_volume, feed_amount, hunger)
		L.blood_volume += blood_given
		L.handle_blood()
		SEND_SIGNAL(user, COMSIG_MOB_ADJUST_HUNGER, -blood_given)

/datum/rmb_intent/megaleech_feed/proc/can_feed(mob/living/user, mob/living/target)
	return SEND_SIGNAL(user, COMSIG_MOB_RETURN_HUNGER) > 0 && target.blood_volume < BLOOD_VOLUME_MAXIMUM
