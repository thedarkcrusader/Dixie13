
/datum/action/cooldown/meatvine/personal
	name = "Personal Ability"
	desc = "Uses personal resources"
	button_icon = 'icons/obj/cellular/putrid_abilities.dmi'
	background_icon = 'icons/obj/cellular/putrid_abilities.dmi'
	base_background_icon_state = "button_bg"
	active_background_icon_state = "button_bg1"
	check_flags = NONE
	var/personal_resource_cost = 10

/datum/action/cooldown/meatvine/personal/IsAvailable()
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/simple_animal/hostile/retaliate/meatvine/consumed = owner
	if(!istype(consumed))
		return FALSE

	if(consumed.personal_resource_pool < personal_resource_cost)
		return FALSE

	return TRUE
