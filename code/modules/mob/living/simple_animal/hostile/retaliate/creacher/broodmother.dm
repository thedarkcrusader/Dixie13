#define BIOMASS_TIER_1 "tier_1"
#define BIOMASS_TIER_2 "tier_2"
#define BIOMASS_TIER_3 "tier_3"

#define BIOMASS_TIER_1_THRESHOLD 20
#define BIOMASS_TIER_2_THRESHOLD 50
#define BIOMASS_TIER_3_THRESHOLD 100

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

	var/

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

