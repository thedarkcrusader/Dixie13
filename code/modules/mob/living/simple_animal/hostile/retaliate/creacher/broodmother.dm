#define BIOMASS_TIER_1 "tier_1"
#define BIOMASS_TIER_2 "tier_2"
#define BIOMASS_TIER_3 "tier_3"

#define BIOMASS_TIER_1_COST 25
#define BIOMASS_TIER_2_COST 50
#define BIOMASS_TIER_3_COST 90

#define BIOMASS_MAX_AMOUNT 100
#define BIOMASS_MIN_AMOUNT 0

/mob/living/simple_animal/hostile/retaliate/troll/broodmother
	name = "Broodmother"
	desc = "Once, Eora gifted to Graggar the Luxus Pragmas and told him to make a female companion with it.\
			He was supposed to make a beautiful and courageous wife from it, is what Eora had hoped he would do.\
			Instead, Graggar created this."
	icon = 'icons/mob/creacher/trolls/broodmother.dmi'
	icon_state = "broodmother"
	SET_BASE_PIXEL(-40, -8)
	hud_type = /datum/hud/broodmother

	var/tier_1_biomass_amount = 20
	var/tier_2_biomass_amount = 10
	var/tier_3_biomass_amount = 5

/mob/living/simple_animal/hostile/retaliate/troll/broodmother/Initialize()
	. = ..()
	var/datum/action/cooldown/mob_cooldown/earth_quake/quake_ability = new
	quake_ability.Grant(src)
	var/datum/action/toggle_frenzy/frenzy_toggle = new
	frenzy_toggle.Grant(src)
	var/datum/action/cooldown/mob_cooldown/stone_throw/throwing_stone = new
	throwing_stone.Grant(src)

/mob/living/simple_animal/hostile/retaliate/troll/broodmother/death(gibbed)
	icon_state = initial(icon_state)
	. = ..()

/datum/action/toggle_frenzy
	name = "Toggle Frenzy"
	var/state = FALSE

/datum/action/toggle_frenzy/Trigger(trigger_flags)
	. = ..()
	state = !state
	var/mob/living/living_owner = owner
	if(state)
		owner.icon_state = "broodmother_frenzy"
		owner.add_filter("frenzy_rays", 20, rays_filter(size = 80, color = "#c21a03"))
		playsound(owner, 'sound/misc/gods/astrata_scream.ogg', 80, extrarange = SHORT_RANGE_SOUND_EXTRARANGE, frequency = 32000)
		animate(owner, time = 0.15 SECONDS, pixel_w = rand(10, 15) * pick(1, -1), pixel_z = rand(10, 20) * pick(1, -1), transform = owner.transform.Turn(rand(10, 20)), easing = BOUNCE_EASING)
		animate(time = 0.15 SECONDS, pixel_w = -rand(10, 20) * pick(1, -1), pixel_z = rand(10, 20) * pick(1, -1), transform = initial(owner.transform):Turn(-rand(10, 20)), easing = BOUNCE_EASING)
		animate(time = 0.2 SECONDS, pixel_w = 0, pixel_z = 0, transform = initial(owner.transform), easing = BOUNCE_EASING)
	else
		owner.icon_state = "broodmother"
		owner.remove_filter("frenzy_rays")
	living_owner.update_vision_cone()

/mob/living/simple_animal/hostile/retaliate/troll/broodmother/proc/adjust_biomass(tier, amount)
	switch(tier)
		if(1)
			if((tier_1_biomass_amount + amount) < BIOMASS_MIN_AMOUNT)
				return FALSE
		if(2)
			if((tier_2_biomass_amount + amount) < BIOMASS_MIN_AMOUNT)
				return FALSE
		if(3)
			if((tier_3_biomass_amount + amount) < BIOMASS_MIN_AMOUNT)
				return FALSE

	_adjust_biomass(arglist(args))
	return TRUE

/mob/living/simple_animal/hostile/retaliate/troll/broodmother/proc/_adjust_biomass(tier, amount)
	switch(tier)
		if(1)
			tier_1_biomass_amount = clamp(tier_1_biomass_amount + amount, BIOMASS_MIN_AMOUNT, BIOMASS_MAX_AMOUNT)
		if(2)
			tier_1_biomass_amount = clamp(tier_2_biomass_amount + amount, BIOMASS_MIN_AMOUNT, BIOMASS_MAX_AMOUNT)
		if(3)
			tier_1_biomass_amount = clamp(tier_3_biomass_amount + amount, BIOMASS_MIN_AMOUNT, BIOMASS_MAX_AMOUNT)

	SEND_SIGNAL(src, COMSIG_BROODMOTHER_BIOMASS_CHANGE, amount, tier)

/mob/living/simple_animal/hostile/retaliate/troll/broodmother/proc/attempt_lay_egg(tier)
	if(!tier)
		stack_trace("didn't pass tier for egg")
	if(!egg_laying_checks(tier))
		return

	lay_egg(tier)

/mob/living/simple_animal/hostile/retaliate/troll/broodmother/proc/egg_laying_checks(tier)
	return TRUE

/mob/living/simple_animal/hostile/retaliate/troll/broodmother/proc/lay_egg(tier)
	var/egg_to_lay
	switch(tier)
		if(1)
			egg_to_lay = /obj/structure/broodmother_egg/goblin_egg
		if(2)
			egg_to_lay = /obj/structure/broodmother_egg/orc
		if(3)
			egg_to_lay = /obj/structure/broodmother_egg/troll

	var/obj/made_egg = new egg_to_lay(get_turf(src))
	to_chat(src, span_notice("you lay \a [made_egg]."))

/obj/structure/broodmother_egg
	name = "egg"
	desc = "an egg..."
	abstract_type = /obj/structure/broodmother_egg
	icon = 'icons/obj/broodmother_32x.dmi'
	var/hatched = FALSE
	var/hatch_time = 30 SECONDS
	var/type_to_spawn
	var/time_before_first_crack = 5 SECONDS
	var/cracking_speed = 6 SECONDS

/obj/structure/broodmother_egg/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(hatch)), hatch_time)
	addtimer(CALLBACK(src, PROC_REF(crack)), time_before_first_crack)

/obj/structure/broodmother_egg/proc/hatch()
	hatched = TRUE
	icon_state = "[icon_state]_hatched"
	name = "hatched " + name
	playsound(src, 'sound/foley/eggbreak.ogg', 70, TRUE)
	animate(src, tag = "hatching_animation", flags = ANIMATION_END_NOW)
	new type_to_spawn(get_turf(src))

/obj/structure/broodmother_egg/proc/crack()
	if(hatched)
		return

	playsound(src, SFX_EGG_HATCHING, 70, TRUE)
	animate(src, time = rand(1, 3), pixel_w = rand(1, 4) * pick(1, -1), pixel_z = rand(1, 4) * pick(1, -1), easing = ELASTIC_EASING, tag = "hatching_animation")
	animate(time = rand(1, 3), pixel_w = rand(1, 4) * pick(1, -1), pixel_z = rand(1, 4) * pick(1, -1), easing = ELASTIC_EASING)
	animate(time = rand(1, 3), pixel_w = rand(1, 4) * pick(1, -1), pixel_z = rand(1, 4) * pick(1, -1), easing = ELASTIC_EASING)
	animate(time = rand(1, 3), pixel_w = 0, pixel_z = 0, easing = ELASTIC_EASING)
	cracking_speed = max(cracking_speed - 0.5 SECONDS, 1 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(crack)), cracking_speed)

/obj/structure/broodmother_egg/goblin_egg
	name = "small egg"
	icon_state = "goblin_egg"
	type_to_spawn = /mob/living/carbon/human/species/goblin/npc

/obj/structure/broodmother_egg/orc
	name = "medium egg"
	icon_state = "orc_egg"
	type_to_spawn = /mob/living/carbon/human/species/orc/npc

/obj/structure/broodmother_egg/troll
	name = "large egg"
	icon_state = "troll_egg"
	type_to_spawn = /mob/living/simple_animal/hostile/retaliate/troll
