/mob/living/simple_animal/hostile/retaliate/meatvine
	name = "Horrible creature"
	desc = "What is that?!"
	icon = 'icons/obj/cellular/meat.dmi'
	icon_state = "bloodling_stage_1"
	icon_living = "bloodling_stage_1"
	icon_dead = "bloodling_stage_1_dead"
	faction = list("meat")
	health = 60
	maxHealth = 60
	hud_type = /datum/hud/putrid
	//melee_damage = 25
	//move_speed = 0
	see_in_dark = 10

	environment_smash = TRUE
	//search_objects = 1
	//wanted_objects = list(/obj/machinery/light, /obj/machinery/light/small, /obj/machinery/light/smart, /obj/machinery/bot/secbot/beepsky, /obj/machinery/camera)

	stat_attack = 1

	ai_controller = /datum/ai_controller/meatvine_defender

	pass_flags = PASSTABLE

	var/obj/effect/meatvine_controller/master
	var/personal_resource_pool = 0
	var/personal_resource_max = PERSONAL_RESOURCE_MAX
	var/is_draining_well = FALSE
	var/obj/structure/meatvine/healing_well/draining_target = null
	var/last_drain_time = 0

/mob/living/simple_animal/hostile/retaliate/meatvine/Initialize()
	. = ..()
	AddComponent(/datum/component/ai_aggro_system)
	ADD_TRAIT(src, TRAIT_PUTRID, INNATE_TRAIT)
	add_spell(/datum/action/cooldown/meatvine/spread_floor)
	add_spell(/datum/action/cooldown/meatvine/spread_wall)
	add_spell(/datum/action/cooldown/meatvine/spread_lair)
	add_spell(/datum/action/cooldown/meatvine/spread_spike)
	add_spell(/datum/action/cooldown/meatvine/spread_healing_well)

	add_spell(/datum/action/cooldown/meatvine/personal/drain_well)

/mob/living/simple_animal/hostile/retaliate/meatvine/Destroy()
	puff_gas()
	var/turf/turf = get_turf(src)
	turf.pollute_turf(/datum/pollutant/steam, 100)

	turf.add_liquid(/datum/reagent/blood, 20)

	return ..()

/mob/living/simple_animal/hostile/retaliate/meatvine/death()
	puff_gas()


	QDEL_IN(src, rand(60, 120) SECONDS)

	return ..()


/mob/living/simple_animal/hostile/retaliate/meatvine/Life(seconds_per_tick, times_fired)
	. = ..()
	if(stat != DEAD)
		regenerate_personal_resources(seconds_per_tick)

/mob/living/simple_animal/hostile/retaliate/meatvine/proc/regenerate_personal_resources(seconds_per_tick)
	if(is_draining_well)
		return

	var/regen_amount = PERSONAL_RESOURCE_REGEN_RATE * seconds_per_tick
	adjust_personal_resources(regen_amount)

/mob/living/simple_animal/hostile/retaliate/meatvine/proc/adjust_personal_resources(amount)
	var/old_resources = personal_resource_pool
	personal_resource_pool = clamp(personal_resource_pool + amount, 0, personal_resource_max)

	if(old_resources != personal_resource_pool)
		SEND_SIGNAL(src, COMSIG_MEATVINE_PERSONAL_RESOURCE_CHANGE, personal_resource_pool)

	return personal_resource_pool

/mob/living/simple_animal/hostile/retaliate/meatvine/proc/try_spend_personal_resources(amount)
	if(personal_resource_pool >= amount)
		adjust_personal_resources(-amount)
		return TRUE
	return FALSE

/mob/living/simple_animal/hostile/retaliate/meatvine/proc/start_draining_well(obj/structure/meatvine/healing_well/well)
	if(is_draining_well)
		to_chat(src, span_warning("Already draining a well!"))
		return FALSE

	if(world.time < last_drain_time + HEALING_WELL_DRAIN_COOLDOWN)
		var/time_left = round((last_drain_time + HEALING_WELL_DRAIN_COOLDOWN - world.time) / 10)
		to_chat(src, span_warning("Must wait [time_left] seconds before draining again!"))
		return FALSE

	if(well.is_being_drained)
		to_chat(src, span_warning("This well is already being drained!"))
		return FALSE

	if(get_dist(src, well) > 1)
		to_chat(src, span_warning("Must be adjacent to the healing well!"))
		return FALSE

	is_draining_well = TRUE
	draining_target = well
	well.start_drain(src)

	to_chat(src, span_notice("You begin draining the healing well..."))


	if(!do_after(src, HEALING_WELL_DRAIN_TIME, well))
		well.restore_healing()
		return FALSE

	if(QDELETED(well))
		cancel_well_drain()
		to_chat(src, span_warning("The drain was interrupted!"))
		return

	adjust_personal_resources(HEALING_WELL_DRAIN_AMOUNT)
	is_draining_well = FALSE
	draining_target = null
	last_drain_time = world.time

	well.finish_drain()

	to_chat(src, span_boldnotice("Drained [HEALING_WELL_DRAIN_AMOUNT] personal resources from the healing well!"))
	to_chat(src, span_info("Personal resources: [personal_resource_pool]/[personal_resource_max]"))

/mob/living/simple_animal/hostile/retaliate/meatvine/proc/cancel_well_drain()
	if(!is_draining_well)
		return

	is_draining_well = FALSE
	if(draining_target)
		draining_target.restore_healing()
		draining_target = null

/mob/living/simple_animal/hostile/retaliate/meatvine/proc/puff_gas()
	if(!prob(50))
		return

	var/turf/turf = get_turf(src)
	turf.pollute_turf(/datum/pollutant/rot, 100)
	return
