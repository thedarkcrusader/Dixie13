/mob/living/simple_animal/hostile/retaliate/trogfish
	icon = 'icons/roguetown/mob/monster/trogfish.dmi'
	name = "trogfish"
	desc = ""
	icon_state = "trogfish"
	icon_living = "trogfish"
	icon_dead = "trogfish_dead"

	faction = list(FACTION_SEA)
	emote_hear = list("gurgles.")
	emote_see = list("oozes.")
	move_to_delay = 4
	vision_range = 2
	aggro_vision_range = 2

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/mince/beef = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/mince/beef = 1,
						/obj/item/natural/fur/rous = 1,/obj/item/alch/bone = 2)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 1,
						/obj/item/alch/sinew = 1,
						/obj/item/natural/fur/rous = 1, /obj/item/alch/bone = 4)
	head_butcher = /obj/item/natural/head/rous

	health = 70
	maxHealth = 70
	food_type = list(/obj/item/reagent_containers/food/snacks,
					/obj/item/bodypart,
					/obj/item/organ)

	base_intents = list(/datum/intent/simple/bite)
	attack_sound = 'sound/combat/wooshes/punch/punchwoosh (2).ogg'
	melee_damage_lower = 12
	melee_damage_upper = 14

	base_constitution = 8
	base_strength = 3
	base_speed = 6

	retreat_distance = 0
	minimum_distance = 0
	deaggroprob = 0
	defprob = 40
	defdrain = 5
	retreat_health = 0.3
	aggressive = TRUE
	stat_attack = UNCONSCIOUS
	remains_type = /obj/effect/decal/remains/trogfish
	body_eater = TRUE
	gender = NEUTER

	ai_controller = /datum/ai_controller/trogfish

	food_type = list(
		/obj/item/reagent_containers/food/snacks/cheddarslice,
		/obj/item/reagent_containers/food/snacks/cheese_wedge,
		/obj/item/reagent_containers/food/snacks/cheddar,
		/obj/item/reagent_containers/food/snacks/cheese,
	)
	tame_chance = 25
	bonus_tame_chance = 15

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

/obj/effect/decal/remains/trogfish
	name = "remains"
	gender = NEUTER
	icon_state = "trogfish_dead"
	icon = 'icons/roguetown/mob/monster/trogfish.dmi'

/mob/living/simple_animal/hostile/retaliate/trogfish/Initialize()
	AddComponent(/datum/component/obeys_commands, pet_commands) // here due to signal overridings from pet commands
	. = ..()
	AddComponent(/datum/component/ai_aggro_system)

	var/datum/action/cooldown/mob_cooldown/trogfish_burst/burst = new()
	burst.Grant(src)
	ai_controller?.set_blackboard_key(BB_TARGETED_ACTION, burst)

/datum/action/cooldown/mob_cooldown/trogfish_burst
	name = "Burst"
	button_icon = 'icons/effects/effects.dmi'
	button_icon_state = "acid"
	desc = "Contract your trogbladder, killing you in and producing a mass of acidic bile."
	cooldown_time = 7 SECONDS

	var/burst_liquid = /datum/reagent/toxin/acid
	var/burst_amt = 100 // keep in mind the threat scale as well
	var/burst_range = 2
	//TO DO: NEW SOUND
	var/sound_type = /datum/looping_sound/invokefire


/datum/action/cooldown/mob_cooldown/trogfish_burst/Activate(atom/target)
	if(isdead(owner)) // how
		return FALSE

	owner.visible_message(span_userdanger("[owner] starts to bubble and expand!"))

	var/datum/looping_sound/sound_loop
	if(sound_type)
		sound_loop = new sound_type(_parent = owner, start_immediately = TRUE)
	if(do_after(owner, cooldown_time / 2, owner, (IGNORE_USER_LOC_CHANGE|IGNORE_INCAPACITATED|IGNORE_SLOWDOWNS|IGNORE_USER_DIR_CHANGE)))
		var/turf/epicenter = get_turf(owner)
		if(!epicenter) // HOW
			return FALSE
		owner.visible_message(span_userdanger("[owner] violently bursts!"))
		var/datum/reagents/R = new(burst_amt, NO_REACT)
		R.add_reagent(burst_liquid, burst_amt)
		chem_splash(epicenter, burst_range, list(R, owner.reagents), 2)
		owner.gib()
		qdel(R)

	if(sound_loop)
		sound_loop.stop(TRUE)
		qdel(sound_loop)

	StartCooldown()
	return TRUE
